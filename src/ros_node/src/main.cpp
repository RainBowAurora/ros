#include <iostream>
#include "ros_node/ros_node.h"

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "ros_node");

    RosNode ros_node;
    
    ros_node.init();
    ros_node.run();

    return 0;
}   