# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-boost BUILD_SRC_DIR BUILD_DIST_DIR

BUILD_SRC_DIR=$1
BUILD_DIST_DIR=$2

BASE_DIR=$(pwd)
source $BASE_DIR/setup-ndk.sh

cd $BUILD_SRC_DIR
mkdir build
cd build

if [ "$BUILD_TYPE" == "static" ];then
        BUILD_SHARED_LIBS=off
else
        BUILD_SHARED_LIBS=on
fi

cmake .. -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$ANDROID_ABI \
        -DANDROID_PLATFORM=$ANDROID_PLATFORM \
        -DBUILD_SHARED_LIBS=$BUILD_SHARED_LIBS \
        -DBOOST_LOCALE_ENABLE_POSIX=off \
        -DBOOST_LOCALE_ENABLE_ICONV=off \
        -DBOOST_LOCALE_ENABLE_STD=off \
        -DBOOST_LOCALE_ENABLE_ICU=on \
        -DICU_ROOT=$BUILD_DIST_DIR
cmake --build . --config Release
cmake --install . --prefix=$BUILD_DIST_DIR