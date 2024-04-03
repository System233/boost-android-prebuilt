#!/bin/bash -e
# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# build ANDROID_ABI ANDROID_PLATFORM BOOST_VERSION ICU_VERSION

export ANDROID_ABI=$1
export ANDROID_PLATFORM=$2
BOOST_VERSION=$3
ICU_VERSION=$4
export BUILD_TYPE=$5

BOOST_VERSION=${BOOST_VERSION:-$(./latest-boost-version.sh)}
ICU_VERSION=${ICU_VERSION:-$(./latest-icu-version.sh)}
echo "Selected icu version $ICU_VERSION"
echo "Selected boost version $BOOST_VERSION"

# ICU_NAME=$(echo icu$ICU_VERSION|grep --perl-regex -e "release-\\K(.*)"  --only-matching|sed -e "s/-/.")
# BOOST_DIST_NAME=$BOOST_VERSION-$ICU_NAME-android$ANDROID_PLATFORM-$ANDROID_ABI.zip

JOBS=$(nproc)
BASE_DIR=$(pwd)
BUILD_DIST_DIR=${BUILD_DIST_DIR:-$BASE_DIR/dist}
ICU_DIST_DIR=$BUILD_DIST_DIR
BOOST_DIST_DIR=$BUILD_DIST_DIR
function clone_branch(){
    # clone_branch repo branch
    REPO=$1
    BRANCH=$2
    INTO=$3
    git clone --jobs $JOBS --recursive --depth 1 --single-branch --branch $BRANCH $REPO $INTO 
}

echo Building icu library
clone_branch https://github.com/unicode-org/icu.git $ICU_VERSION icu
./build-icu.sh icu $BUILD_DIST_DIR

echo Building boost library
clone_branch https://github.com/boostorg/boost.git $BOOST_VERSION boost
./build-boost.sh boost $BUILD_DIST_DIR

# cd $BUILD_DIST_DIR
# zip -9 -r . ../$BOOST_DIST_NAME

# echo $BOOST_DIST_NAME >> dist.txt