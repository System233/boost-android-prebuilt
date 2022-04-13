# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-icu BUILD_SRC_DIR BUILD_DIST_DIR
BUILD_SRC_DIR=$1
BUILD_DIST_DIR=$2

BASE_DIR=$(pwd)
ICU4C_SRC_DIR=$BUILD_SRC_DIR/icu4c/source
JOBS=$(nproc)

cd $ICU4C_SRC_DIR


mkdir build
cd build
../configure
make -j$JOBS

cd ..

source $BASE_DIR/setup-ndk.sh
mkdir target
cd target
../configure --host=$TARGET_HOST --with-cross-build=$(readlink -f $ICU4C_SRC_DIR/build)
make -j$JOBS
make install prefix=$BUILD_DIST_DIR