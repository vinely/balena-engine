#!/bin/sh

set -o errexit

version=$(git describe --tags --always)

for pkg in ./vendor/*; do
	pkg=$(basename $pkg)
	ln -s "$PWD/vendor/$pkg" "$GOPATH/src/$pkg"
done

# dynbinary-balena 
PATH=$PATH:$pwd/balena-engine VERSION="$version" ./hack/make.sh test-integration
