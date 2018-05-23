#!/bin/sh

if [[ $1 == *.go ]]
then
  goimports -w $1
  gofmt -w $1
  golint $1
  go vet $1
fi
