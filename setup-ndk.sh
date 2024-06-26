#!/bin/bash -e
# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
# setup-ndk 


NDK_HOME=${ANDROID_NDK_LATEST_HOME:-$ANDROID_NDK_HOME}

# https://github.com/android/ndk/wiki/Changelog-r26
# https://developer.android.com/ndk/downloads/revision_history
# KitKat (APIs 19 and 20) is no longer supported. The minimum OS supported by the NDK is Lollipop (API level 21). See Issue 1751 for details.
if [ $ANDROID_PLATFORM -le 20 ];then
   #/usr/local/lib/android/sdk/ndk/25.2.9519653
   NDK_HOME=$ANDROID_NDK_HOME
   NDK_MAJOR=$(basename "$NDK_HOME"| grep -oE '[0-9]+'|head -n 1)
   if [ $NDK_MAJOR -ge 26 ];then
      echo ERROR!

      echo "Error: KitKat (APIs 19 and 20) is no longer supported in NDK r$NDK_MAJOR. The minimum OS supported by the NDK is Lollipop (API level 21)." >2
      exit 1
   fi
fi
case $ANDROID_ABI in
   armeabi-v7a) TARGET_HOST=armv7a-linux-androideabi;;
   arm64-v8a) TARGET_HOST=aarch64-linux-android;;
   x86) TARGET_HOST=i686-linux-android;;
   x86_64) TARGET_HOST=x86_64-linux-android;;
esac

# Detect host operating system and architecture
HOST_OS=$(uname -s)
case $HOST_OS in
  Darwin) HOST_OS=darwin;;
  Linux) HOST_OS=linux;;
  FreeBsd) HOST_OS=freebsd;;
  *_NT-*) HOST_OS=windows;;
  CYGWIN*) HOST_OS=cygwin;;
  *) echo "ERROR: Unknown host operating system: $HOST_OS"
     exit 1
esac
# echo "HOST_OS=$HOST_OS"

HOST_ARCH=$(uname -m)
case $HOST_ARCH in
    arm64) HOST_ARCH=arm64;;
    i?86) HOST_ARCH=x86;;
    x86_64|amd64) HOST_ARCH=x86_64;;
    *) echo "ERROR: Unknown host CPU architecture: $HOST_ARCH"
       exit 1
esac
# echo "HOST_ARCH=$HOST_ARCH"

HOST_TAG=$HOST_OS-$HOST_ARCH
export TOOLCHAIN=$NDK_HOME/toolchains/llvm/prebuilt/$HOST_TAG
# Only choose one of these, depending on your device...
# export TARGET_HOST=aarch64-linux-android
# export TARGET=armv7a-linux-androideabi
# export TARGET=i686-linux-android
# export TARGET=x86_64-linux-android
# Set this to your minSdkVersion.
export API=$ANDROID_PLATFORM
# Configure and build.
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
