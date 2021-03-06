#include <iostream>
#include "MnistDataset.hpp"
#include "Lenet.hpp"
#include <MNN/expr/Executor.hpp>
#include "SGD.hpp"
#include <MNN/AutoTime.hpp>
#include "Loss.hpp"
#include "LearningRateScheduler.hpp"
#include "Transformer.hpp"

using namespace MNN;
using namespace MNN::Train;
using namespace MNN::Express;

int main(int argc, char *argv[]) {
    std::string dataPath = argv[1];
    int epoch_total = atoi(argv[2]);
    float scalar = std::stof(argv[3]);
    float rate = std::stof(argv[4]);

    // Create model
    std::shared_ptr<Module> model(new Model::Lenet);

    auto exe = Executor::getGlobalExecutor();
    BackendConfig config;
    if (strcmp(argv[5], "fp16" ) == 0) {
        config.precision = BackendConfig::Precision_Low;  
    }
    exe->setGlobalExecutorConfig(MNN_FORWARD_CPU, config, 4);
    std::cout << config.precision << std::endl; // Precision_Low = 2
    std::cout << exe->getCurrentRuntimeStatus(STATUS_SUPPORT_FP16) << std::endl;  // True for FP16 support

    std::shared_ptr<SGD> sgd(new SGD(model));
    sgd->setMomentum(0.9f);
    // sgd->setMomentum2(0.99f);
    sgd->setWeightDecay(0.0005f);

    // Create the data set and DataLoader
    auto dataset = MnistDataset::create(dataPath, MnistDataset::Mode::TRAIN);
    // the stack transform, stack [1, 28, 28] to [n, 1, 28, 28]
    const size_t batchSize  = 64;
    const size_t numWorkers = 0;
    bool shuffle            = true;

    auto dataLoader = std::shared_ptr<DataLoader>(dataset.createLoader(batchSize, true, shuffle, numWorkers));

    size_t iterations = dataLoader->iterNumber();

    auto testDataset            = MnistDataset::create(dataPath, MnistDataset::Mode::TEST);
    const size_t testBatchSize  = 20;
    const size_t testNumWorkers = 0;
    shuffle                     = false;

    auto testDataLoader = std::shared_ptr<DataLoader>(testDataset.createLoader(testBatchSize, true, shuffle, testNumWorkers));

    size_t testIterations = testDataLoader->iterNumber();

    for (int epoch = 0; epoch < epoch_total; ++epoch) {
        model->clearCache();
        exe->gc(Executor::FULL);
        exe->resetProfile();
        {
            AUTOTIME;
            dataLoader->reset();
            model->setIsTraining(true);
            Timer _100Time;
            int lastIndex = 0;
            int moveBatchSize = 0;
            for (int i = 0; i < iterations; i++) {
                // AUTOTIME;
                auto trainData  = dataLoader->next();
                auto example    = trainData[0];
                auto cast       = _Cast<float>(example.first[0]);
                example.first[0] = cast * _Const(1.0f / 255.0f);
                moveBatchSize += example.first[0]->getInfo()->dim[0];

                // Compute One-Hot
                auto newTarget = _OneHot(_Cast<int32_t>(example.second[0]), _Scalar<int>(10), _Scalar<float>(1.0f),
                                         _Scalar<float>(0.0f));

                auto predict = model->forward(example.first[0]);
                auto loss    = _CrossEntropy(predict, newTarget);

                // float rate   = LrScheduler::inv(0.01, epoch * iterations + i, 0.0001, 0.75);
                sgd->setLearningRate(rate);
                if (moveBatchSize % (10 * batchSize) == 0 || i == iterations - 1) {
                    std::cout << "epoch: " << (epoch);
                    std::cout << "  " << moveBatchSize << " / " << dataLoader->size();
                    std::cout << " loss: " << loss->readMap<float>()[0];
                    std::cout << " lr: " << rate;
                    std::cout << " time: " << (float)_100Time.durationInUs() / 1000.0f << " ms / " << (i - lastIndex) <<  " iter"  << std::endl;
                    std::cout.flush();
                    _100Time.reset();
                    lastIndex = i;
                }
                sgd->step(_Multiply(loss, _Const(scalar)));  // TODO: FP16 training fails due to loss over/underflows.
            }
        }
        Variable::save(model->parameters(), "mnist.snapshot.mnn");
        {
            model->setIsTraining(false);
            auto forwardInput = _Input({1, 1, 28, 28}, NC4HW4);
            forwardInput->setName("data");
            auto predict = model->forward(forwardInput);
            predict->setName("prob");
            Transformer::turnModelToInfer()->onExecute({predict});
            Variable::save({predict}, "temp.mnist.mnn");
        }

        int correct = 0;
        testDataLoader->reset();
        model->setIsTraining(false);
        int moveBatchSize = 0;
        for (int i = 0; i < testIterations; i++) {
            auto data       = testDataLoader->next();
            auto example    = data[0];
            moveBatchSize += example.first[0]->getInfo()->dim[0];
            if ((i + 1) % 100 == 0) {
                std::cout << "test: " << moveBatchSize << " / " << testDataLoader->size() << std::endl;
            }
            auto cast       = _Cast<float>(example.first[0]);
            example.first[0] = cast * _Const(1.0f / 255.0f);
            auto predict    = model->forward(example.first[0]);
            predict         = _ArgMax(predict, 1);
            auto accu       = _Cast<int32_t>(_Equal(predict, _Cast<int32_t>(example.second[0]))).sum({});
            correct += accu->readMap<int32_t>()[0];
        }
        auto accu = (float)correct / (float)testDataLoader->size();
        std::cout << "epoch: " << epoch << "  accuracy: " << accu << std::endl;
        exe->dumpProfile();
    }

    return 0;
}
