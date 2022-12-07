#!/bin/bash

BUILD_PATH=build
DEVEL_PATH=devel
INSTALL_PATH=install
DEB_PATH=package

function create_control_file(){
mkdir -p ${DEB_PATH}/DEBIAN/
mkdir -p ${DEB_PATH}/opt/ros/${ROS_DISTRO}/

VERSION='1.0'
DATE=`date +%y%m%d`

cat >${DEB_PATH}/DEBIAN/control << EOF 
Package: ros-${ROS_DISTRO}-ros-node
Version: ${VERSION}-${DATE}
Section: misc
Priority: optional
Architecture: amd64
Maintainer: 851045076@qq.com
Description: The ros_node package
EOF

cp -r install/bin ${DEB_PATH}/opt/ros/${ROS_DISTRO}/
cp -r install/include ${DEB_PATH}/opt/ros/${ROS_DISTRO}/
cp -r install/lib ${DEB_PATH}/opt/ros/${ROS_DISTRO}/
cp -r install/share ${DEB_PATH}/opt/ros/${ROS_DISTRO}/

dpkg-deb --build ${DEB_PATH}/ ros-${ROS_DISTRO}-ros-node-${DATE}.deb

}


create_control_file 
