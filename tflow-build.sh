#!/bin/bash

# Building tensorflow package from the sources manually

TF_BRANCH=r1.X

cd /

git clone --branch=${TF_BRANCH} --depth=1 https://github.com/tensorflow/tensorflow.git

cd tensorflow

git checkout ${TF_BRANCH}

updatedb

cd /

cp auto_build.sh .tf_configure.bazelrc  /tensorflow

cd tensorflow

/bin/bash auto_build.sh
