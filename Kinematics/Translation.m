function T_xyz=Translation(r)
%A 4X4 translation matrix.
%Date: Dec.02, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
T_xyz=[1 0 0 r(1);0 1 0 r(2);0 0 1 r(3);0 0 0 1];