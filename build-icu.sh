# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-icu SRC_DIR DIST_DIR

ICU_SRC_DIR=$1/icu4c/source
ICU_DIST_DIR=$2
JOBS=$(nproc)
ROOT_DIR=$(pwd)


CXXFLAGS=-std=c++11
cd $ICU_SRC_DIR

mkdir build
cd build
../runConfigureICU Linux
make -j$JOBS
cd ..
source $ROOT_DIR/setup-ndk.sh
mkdir target
cd target
../configure --host=$TARGET --with-cross-build=$(pwd)/../build
make -j$JOBS