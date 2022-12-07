#ifndef __ROS_NODE_H__
#define __ROS_NODE_H__

#include <ros/ros.h>

class RosNode{
public:
    RosNode();
    ~RosNode();
    void init();
    void run();

private:
    ros::NodeHandle nh_;

}; //end class RosNode

#endif /*__ROS_NODE_H__*/