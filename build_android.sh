#!/bin/bash
ANDROID_DIR=/data/local/tmp

cmake ../ \
-DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
-DCMAKE_BUILD_TYPE=Release \
-DANDROID_ABI="arm64-v8a" \
-DANDROID_NATIVE_API_LEVEL=android-21

make
adb push demo /data/local/tmp

EPOCH=1
LOSS_SCALAR=1
LR=0.01
PRECISION="fp32"
adb shell "LD_LIBRARY_PATH=$ANDROID_DIR $ANDROID_DIR/demo $ANDROID_DIR/mnist_data $EPOCH $LOSS_SCALAR $LR $PRECISION"