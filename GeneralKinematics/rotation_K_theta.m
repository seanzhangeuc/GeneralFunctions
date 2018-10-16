function Rotation_K_theta=rotation_K_theta(K,theta)
%»∆»Œ“‚÷·K£®kx,ky,kz£©'–˝◊™theta
%rotation_K_theta(K,theta)
%Date: Nov.23, 2014
%revised on Jan.06, 2018, normalize the axis.
%Copyright 2014 Sean Zhang. All rights reserved.
K=K./norm(K);
k1=K(1);
k2=K(2);
k3=K(3);
v=1-cos(theta);
s=sin(theta);
c=cos(theta);
Rotation_K_theta=[k1*k1*v+c k2*k1*v-k3*s k3*k1*v+k2*s 0
                  k2*k1*v+k3*s k2*k2*v+c k2*k3*v-k1*s 0
                  k1*k3*v-k2*s k2*k3*v+k1*s k3*k3*v+c 0
                  0                0         0        1]; %4X4
%checked              