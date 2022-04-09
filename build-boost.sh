# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-boost SRC_DIR DIST_DIR ICU_DIST_DIR
ROOT_DIR=$(pwd)
SRC_DIR=$1
DIST_DIR=$2
source setup-ndk.sh
cd $SRC_DIR
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_LATEST_HOME/build/cmake/android.toolchain.cmake -DBOOST_CONTEXT_ARCHITECTURE=arm64 -DBOOST_LOCALE_ENABLE_POSIX=on
cmake --build . --config Release
