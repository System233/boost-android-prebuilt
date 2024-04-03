#!/bin/sh -e
# Copyright (c) 2022 github.com/System233
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

git ls-remote --tags --sort=-v:refname https://github.com/boostorg/boost.git|head -n 1|grep -oP "refs/tags/\\K(.*)"