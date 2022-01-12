#!/usr/bin/env bash

set eu
cd `dirname $0`

VERSION=2.4.0

[ -e temp ] && rm -rf temp

mkdir temp
cd temp

wget https://github.com/cli/cli/releases/download/v$VERSION/gh_${VERSION}_linux_amd64.tar.gz

tar -xvf gh_${VERSION}_linux_amd64.tar.gz
mv gh_${VERSION}_linux_amd64 build

cd build
mv bin/gh ./
chmod u+x gh

