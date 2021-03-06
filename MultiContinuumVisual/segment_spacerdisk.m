function spacerdisk=segment_spacerdisk(position_BDS,orientation_BDS,L0,theta_tl,delta,r)
%this function draw the spacer disk of a segment using the position and orientation of base
%disk, length of primary backbone, theta, delta and the radius of end disk.
%this is not a general function
%(position_BDS,orientation_BDS,L0,theta_tl,delta,r)
%Date: Nov.23, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
point_num=50; %points to draw a disk
disk_0=zeros(4,1);
for i=1:point_num
    disk_0(1,i)=r*sin(2*pi/point_num*i);
    disk_0(2,i)=r*cos(2*pi/point_num*i);
    disk_0(3,i)=0;
    disk_0(4,i)=1;
end
spacerdisk_pose=enddiskpose(position_BDS,orientation_BDS,L0/2,0.5*theta_tl,delta);   %pose of end disk
disk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
spacerdisk=patch(disk(1,:)',disk(2,:)',disk(3,:)','b');
%checked
