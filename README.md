<!--
 Copyright (c) 2022 github.com/System233
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# Boost prebuilt for Android 

Boost library build scripts for Android, prebuilt binaries are [here](https://github.com/System233/boost-android-prebuilt/releases).

CXX Standard: `c++20`
Android ABI: `armeabi-v7a`, `arm64-v8a`, `x86`, `x86_64`
Android API Level: `19-34` (no 20, 19 requires NDK <= r25)
Linker: `static`, `shared`
Repository Dependencies: [Boost](https://github.com/boostorg/boost), [ICU](https://github.com/unicode-org/icu)

## Usage

```shell
export ANDROID_NDK_HOME=<Your Android NDK Location>
build.sh [armeabi-v7a|arm64-v8a|x86|x86_64] [API-Level] [boost-version-tag] [icu-version-tag] [shared|static]
```

## Version Tag
[boost-version-tag list](https://github.com/boostorg/boost/tags)
[icu-version-tag list](https://github.com/unicode-org/icu/tags)

## Example
```shell
export ANDROID_NDK_HOME=<Your Android NDK Location>
git clone https://github.com/System233/boost-android-prebuilt.git
cd boost-android-prebuilt
./build.sh arm64-v8a 31
```
The build output will be placed in the dist directory.

## Note
On Windows platforms, you need [MSYS2](https://www.msys2.org/) to execute the build scripts.

Please enjoy it😝.