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

clone_branch https://github.com/unicode-org/icu.git $ICU_VERSION icu
clone_branch https://github.com/boostorg/boost.git $BOOST_VERSION boost

./build-icu.sh icu "$ICU_DIST_DIR"
./build-boost.sh boost "$BOOST_DIST_DIR" "$ICU_DIST_DIR"