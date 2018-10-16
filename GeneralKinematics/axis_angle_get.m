function [axis,angle]=axis_angle_get(R)
%generate the axis and angle of a rotation matrix.
%[axis,angle]=axis_angle_get(R)
% axis is a column vector
%a general function
%Date: Nov.30, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
angle=acos((trace(R)-1)/2); %scalar
if abs(abs(angle)-pi)<1e-6
    axis=sqrt([R(1,1)+1;R(2,2)+1;R(3,3)+1]/2);
elseif abs(angle)<1e-6
%     angle=0; % revised on JUL 09th
    axis=[0,0,1]';
else
    axis=1/(2*sin(angle))*[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];
end
%checked
