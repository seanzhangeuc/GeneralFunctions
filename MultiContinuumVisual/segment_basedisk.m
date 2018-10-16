function basedisk=segment_basedisk(position_BDS,orientation_BDS,r)
%this function draw the spacer disk of a segment using the position and orientation of base
%disk, length of primary backbone, theta, delta and the radius of end disk.
%(position_BDS,orientation_BDS,r)
%this is not a general function
%Date: Nov.23, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
point_num=50; %points to draw a disk
disk_0=zeros(4,1);
for i=1:point_num
    disk_0(1,i)=r*sin(2*pi/point_num*i);  %X data
    disk_0(2,i)=r*cos(2*pi/point_num*i);   %Y data
    disk_0(3,i)=0;   %Z data
    disk_0(4,i)=1;
end
disk=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*disk_0;
basedisk=patch(disk(1,:)',disk(2,:)',disk(3,:)','b','facealpha',0.3);
hold on
coordinatedrawing(position_BDS,orientation_BDS,8);
%checked
