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
cmake .. -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$ANDROID_ABI \
        -DANDROID_PLATFORM=$ANDROID_PLATFORM \
        -DBOOST_LOCALE_ENABLE_POSIX=off \
        -DBOOST_LOCALE_ENABLE_ICONV=off \
        -DBOOST_LOCALE_ENABLE_STD=on \
        -DBOOST_LOCALE_ENABLE_ICU=on \
        -DICU_INCLUDE_DIR=$BUILD_DIST_DIR/include \
        -DICU_UC_LIBRARY_RELEASE=$BUILD_DIST_DIR/lib/libicuuc.so \
        -DICU_I18N_LIBRARY_RELEASE=$BUILD_DIST_DIR/lib/libicui18n.so \
        -DICU_DATA_LIBRARY_RELEASE=$BUILD_DIST_DIR/lib/libicudata.so
cmake --build . --config Release
cmake --install . --prefix=$BUILD_DIST_DIR