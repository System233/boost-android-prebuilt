#!/bin/bash -e
# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-icu BUILD_SRC_DIR BUILD_DIST_DIR
BUILD_SRC_DIR=$1
BUILD_DIST_DIR=$2

BASE_DIR=$(pwd)
ICU4C_SRC_DIR=$(readlink -f $BUILD_SRC_DIR/icu4c/source)
JOBS=$(nproc)

cd $ICU4C_SRC_DIR

if [ "$BUILD_TYPE" == "static" ];then
        EX_ARGS=--enable-static
else
        EX_ARGS=--enable-shared
fi


mkdir build
cd build
../configure
make -j$JOBS

cd ..
source $BASE_DIR/setup-ndk.sh
mkdir target
cd target
../configure --host=$TARGET_HOST --with-cross-build=$ICU4C_SRC_DIR/build $EX_ARGS||(cat config.log&&false)
make -j$JOBS
make install prefix=$BUILD_DIST_DIR