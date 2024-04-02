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
        LIBRARY_SUFFIX=a
else
        BUILD_SHARED_LIBS=on
        LIBRARY_SUFFIX=so
fi
echo /usr/local/lib/android/sdk/ndk/26.2.11394342/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include 
ls /usr/local/lib/android/sdk/ndk/26.2.11394342/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -lh
echo /home/runner/work/boost-android-prebuilt/boost-android-prebuilt/dist/
ls /home/runner/work/boost-android-prebuilt/boost-android-prebuilt/dist -lh
ls /home/runner/work/boost-android-prebuilt/boost-android-prebuilt/dist/include -lh
ls /home/runner/work/boost-android-prebuilt/boost-android-prebuilt/dist/lib -lh
echo BUILD_DIST_DIR=$BUILD_DIST_DIR
ls $BUILD_DIST_DIR -lh
ls /home/runner/work/boost-android-prebuilt/boost-android-prebuilt -lh
echo BASE_DIR=$BASE_DIR
ls /home/runner/work/boost-android-prebuilt/ -lh
echo BASE_DIR/dist=$BASE_DIR/dist
ls /home/runner/work/boost-android-prebuilt/dist -lh
echo BASE_DIR/dist2=$BASE_DIR/dist2
ls $BASE_DIR/dist -lh
cmake .. -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$ANDROID_ABI \
        -DANDROID_PLATFORM=$ANDROID_PLATFORM \
        -DBUILD_SHARED_LIBS=$BUILD_SHARED_LIBS \
        -DBOOST_LOCALE_ENABLE_POSIX=off \
        -DBOOST_LOCALE_ENABLE_ICONV=off \
        -DBOOST_LOCALE_ENABLE_STD=off \
        -DBOOST_LOCALE_ENABLE_ICU=on \
        -DICU_DEBUG=on \
        -DICU_ROOT=$BUILD_DIST_DIR \
        -DICU_INCLUDE_DIR=$BUILD_DIST_DIR/include
cmake --build . --config Release
cmake --install . --prefix=$BUILD_DIST_DIR