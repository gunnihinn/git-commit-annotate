#!/bin/bash

# See https://stackoverflow.com/a/35800451/1569492
set -eE
set uo pipefail

logfile='/tmp/gca-test.log'
if [[ -f "$logfile" ]]; then
    rm "$logfile"
fi

function cleanup {
    popd >> $logfile
    rm -fr 'test'
}

function snitch {
    cat $logfile
}

trap cleanup EXIT
trap snitch ERR

mkdir 'test'
pushd 'test' >> $logfile
git init >> $logfile

# Annotate first commit to a repo
echo 'foo' > foo.txt
git add foo.txt >> $logfile
git commit -m 'Bar' >> $logfile

../git-commit-annotate --annotate 'Message' >> $logfile
git status >> $logfile
git cat-file commit HEAD | grep 'Message' >> $logfile

../git-commit-annotate --remove
git status >> $logfile
! git cat-file commit HEAD | grep 'Message' >> $logfile

# Annotate not-first commit to repo
echo 'foo too' >> foo.txt
git add foo.txt >> $logfile
git commit -m 'Bar too' >> $logfile

../git-commit-annotate --annotate 'Message' >> $logfile
git status >> $logfile
git cat-file commit HEAD | grep 'Message' >> $logfile

../git-commit-annotate --remove
git status >> $logfile
! git cat-file commit HEAD | grep 'Message' >> $logfile
