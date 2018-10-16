function R_x=Rotation_x(theta)
%A 4X4 rotation matrix for a rotation along x axis of theta radian.
%11/8/2014 Sean Zhang
R_x=[1 0 0 0;0 cos(theta) -sin(theta) 0;0 sin(theta) cos(theta) 0;0 0 0 1];