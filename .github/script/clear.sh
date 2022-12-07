#!/bin/bash

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

delete_build