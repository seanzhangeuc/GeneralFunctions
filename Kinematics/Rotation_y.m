function R_y=Rotation_y(theta)
%A 4X4 rotation matrix for a rotation along y axis of theta radian.
%11/8/2014 Sean Zhang
R_y=[cos(theta) 0 sin(theta) 0;0 1 0 0;-sin(theta) 0 cos(theta) 0;0 0 0 1];