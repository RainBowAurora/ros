#!/bin/bash

BUILD_PATH=build
DEVEL_PATH=devel
INSTALL_PATH=install
DEB_PATH=package

function print_usage(){
    local prog="$(basename $0)"
    echo "Usage:"
    echo "bash ${prog} [Options]"
    echo "Available options:"
    echo "-c, --clean     Clear workspace" 
    echo "-b, --build     Build all work"
    echo "-h, --help      Show this message and exit"
    echo "-d, --deb       Compressing ros package to deb"
}

function delete_build(){
    if [ -d ${BUILD_PATH} ];then
        echo "Delete ${BUILD_PATH}"
        rm -rf ${BUILD_PATH}
    fi

    if [ -d ${DEVEL_PATH} ];then
        echo "Delete ${DEVEL_PATH}"
        rm -rf ${DEVEL_PATH}
    fi

    if [ -d ${INSTALL_PATH} ];then
        echo "Delete ${INSTALL_PATH}"
        rm -rf ${INSTALL_PATH}
    fi

    if [ -d ${DEB_PATH} ];then
        echo "Delete ${DEB_PATH}"
        rm -rf ${DEB_PATH}
    fi
}

function build_object(){
    CPU_CORE_NUM=`grep processor /proc/cpuinfo | wc -l`
    delete_build
    catkin_make --source . -DCMAKE_BUILD_TYPE=Release -DCATKIN_ENABLE_TESTING=false install -j${CPU_CORE_NUM} 
}

function create_control_file(){
mkdir -p ${DEB_PATH}/DEBIAN/
mkdir -p ${DEB_PATH}/opt/ros/${ROS_DISTRO}/

VERSION='1.0'
DATE=`date +%y%m%d`
HASH_KEY=`git rev-parse --verify --short HEAD`

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

dpkg-deb --build ${DEB_PATH}/ ros-${ROS_DISTRO}-ros-node-${DATE}-${HASH_KEY}.deb

}


function parse_arguments() {
    if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]]; then
        print_usage
        exit 0
    fi

    while [[ $# -gt 0 ]]; do
        local opt="$1"
        shift
        case $opt in
            -h|--help)
                print_usage
                exit 0
                ;;
            
            -b|--build)
                build_object
                exit 0
                ;;

            -c|--clear)
                delete_build
                exit 0
                ;;
            -d|--deb)
                create_control_file
                exit 0
                ;;
            *)
                echo "Unknown option: ${opt}"
                print_usage
                exit 1
                ;;
        esac
    done
}


parse_arguments "$@"