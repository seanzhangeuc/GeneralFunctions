function R_z=Rotation_z(theta)
%A 4X4 rotation matrix for a rotation along z axis of theta radian.
%11/8/2014 Sean Zhang
R_z=[cos(theta) -sin(theta) 0 0;sin(theta) cos(theta) 0 0;0 0 1 0;0 0 0 1];