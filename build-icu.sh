# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build-icu SRC_DIR DIST_DIR

ICU_SRC_DIR=$1/icu4c/source
ICU_DIST_DIR=$2

cd $ICU_SRC_DIR
mkdir build
cd build
../runConfigureICU Linux
make
cd ..
mkdir target
cd target
../configure --host=arm --with-cross-build=../build