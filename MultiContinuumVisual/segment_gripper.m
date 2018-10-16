function gripper=segment_gripper(position_BDS,orientation_BDS,L0,theta_tl,delta,r)
%this function draw the gripper of the last segment using the position and orientation of base
%disk, length of primary backbone, theta, delta and the radius of end disk.
%(position_BDS,orientation_BDS,L0,theta_tl,delta,r)
%this is not a general function
%Date: Dec.02, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
gripper_0=zeros(4,4);
gripper_0(1,:)=0;                 %x
gripper_0(2,:)=[r/5 4*r/5 4*r/5 r/5];   %y
gripper_0(3,:)=[0 0 3*r/5 8*r/5];       %z
gripper_0(4,:)=1;
enddisk_pose=enddiskpose(position_BDS,orientation_BDS,L0,theta_tl,delta);  %pose of end disk
gripper1=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*gripper_0;
gripper2=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*Rotation_z(pi)*gripper_0;
gripper(1)=patch(gripper1(1,:)',gripper1(2,:)',gripper1(3,:)','r');
gripper(2)=patch(gripper2(1,:)',gripper2(2,:)',gripper2(3,:)','r');
set(gripper(1),'FaceVertexAlphaData',0.5)
set(gripper(1),'FaceVertexAlphaData',0.5)