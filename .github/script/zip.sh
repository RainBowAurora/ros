#!/bin/bash

cd $1
catkin_make install
tar -cvf build.tar.gz build
tar -cvf devel.tar.gz devel
