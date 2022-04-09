# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

NDK=$ANDROID_NDK_LATEST_HOME

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
echo "HOST_OS=$HOST_OS"

HOST_ARCH=$(uname -m)
case $HOST_ARCH in
    arm64) HOST_ARCH=arm64;;
    i?86) HOST_ARCH=x86;;
    x86_64|amd64) HOST_ARCH=x86_64;;
    *) echo "ERROR: Unknown host CPU architecture: $HOST_ARCH"
       exit 1
esac
echo "HOST_ARCH=$HOST_ARCH"

HOST_TAG=$HOST_OS-$HOST_ARCH
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
# Only choose one of these, depending on your device...
export TARGET=aarch64-linux-android
# export TARGET=armv7a-linux-androideabi
# export TARGET=i686-linux-android
# export TARGET=x86_64-linux-android
# Set this to your minSdkVersion.
export API=21
# Configure and build.
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip