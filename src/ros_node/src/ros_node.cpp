#include "ros_node/ros_node.h"

RosNode::RosNode(): nh_(){
    ROS_INFO("RosNode::RosNode()");
}


RosNode::~RosNode(){
    ROS_INFO("RosNode::~RosNode()");
}


void RosNode::init(){
    ROS_INFO("RosNode::init()");
}

void RosNode::run(){
    while(ros::ok()){
        ros::Duration(1).sleep();
        ROS_INFO("RosNode::run()");
    }
}