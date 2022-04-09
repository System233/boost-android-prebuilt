# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


ICU_VERSION=$(git ls-remote --tags --sort=-v:refname https://github.com/unicode-org/icu.git|grep "refs/tags/release-"|head -n 1|grep --perl-regex -e "refs/tags/\\K(.*)" --only-matching)
BOOST_VERSION=$(git ls-remote --tags --sort=-v:refname https://github.com/boostorg/boost.git|head -n 1|grep --perl-regex -e "refs/tags/\\K(.*)" --only-matching)
JOBS=$(nproc)
ICU_DIST_DIR=$(pwd)/icu-dist
BOOST_DIST_DIR=$(pwd)/boost-dist
function clone_branch(){
    # clone_branch repo branch
    REPO=$1
    BRANCH=$2
    INTO=$3
    git clone --jobs $JOBS --recursive --depth 1 --single-branch --branch $BRANCH $REPO $INTO 
}

# Detect host operating system and architecture
HOST_OS=$(uname -s)
case $HOST_OS in
  Darwin) HOST_OS=darwin;;
  Linux) HOST_OS=linux;;
  FreeBsd) HOST_OS=freebsd;;
  CYGWIN*|*_NT-*) HOST_OS=cygwin;;
  *) echo "ERROR: Unknown host operating system: $HOST_OS"
     exit 1
esac
log "HOST_OS=$HOST_OS"

HOST_ARCH=$(uname -m)
case $HOST_ARCH in
    arm64) HOST_ARCH=arm64;;
    i?86) HOST_ARCH=x86;;
    x86_64|amd64) HOST_ARCH=x86_64;;
    *) echo "ERROR: Unknown host CPU architecture: $HOST_ARCH"
       exit 1
esac
log "HOST_ARCH=$HOST_ARCH"

HOST_TAG=$HOST_OS-$HOST_ARCH

export PATH=$PATH:$ANDROID_NDK_LATEST_HOME/toolchains/llvm/prebuilt/$HOST_TAG/bin

clone_branch https://github.com/unicode-org/icu.git $ICU_VERSION icu

./build-icu.sh icu "$ICU_DIST_DIR"

# clone_branch https://github.com/boostorg/boost.git $BOOST_VERSION boost
# ./build-boost.sh boost "$BOOST_DIST_DIR" "$ICU_DIST_DIR"