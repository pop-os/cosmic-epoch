#!/usr/bin/env bash

set -e

if [ -z "$1" ]
then
    echo "$0 [epoch version]" >&2
    exit 1
fi

VERSION="$1"
TAG="epoch-$1"

echo "Do you want to tag the current state of cosmic-epoch with the tag $TAG? (y/N)"
read answer
if [ "$answer" != "y" ]
then
    echo "Did not answer y, exiting" >&2
    exit 1
fi

set -x

git fetch --recurse-submodules

git tag --force --annotate "$TAG" --message "Epoch ${VERSION}"
git submodule foreach git tag --force --annotate "$TAG" --message "Epoch ${VERSION}"

git push --force origin tag "$TAG"
git submodule foreach git push --force origin tag "$TAG"
