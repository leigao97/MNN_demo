#include <MNNTrain/Lenet.hpp>

using namespace MNN::Train;
using namespace MNN::Express;
using namespace MNN::Train::Model;

int main() {
    std::shared_ptr<Module> model(new Lenet);
    return 0;
}