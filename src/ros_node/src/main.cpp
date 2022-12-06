#include <iostream>
#include <ros/ros.h>

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "ros_node");
    ros::NodeHandle nh;

    while(ros::ok()){
        ros::Duration(1).sleep();
        ROS_INFO("This is ros_node test");
    }
    return 0;
}   