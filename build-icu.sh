# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-icu SRC_DIR DIST_DIR

ICU_SRC_DIR=$1/icu4c/source
ICU_DIST_DIR=$2
HOST=aarch64-linux-android32
JOBS=$(nproc)


CXXFLAGS =  -std=c++11
cd $ICU_SRC_DIR
ndk-build

# mkdir build
# cd build
# ../runConfigureICU Linux
# make -j$JOBS
# cd ..
# mkdir target
# cd target
# ../configure --host=$HOST --with-cross-build=../build
# make -j$JOBS