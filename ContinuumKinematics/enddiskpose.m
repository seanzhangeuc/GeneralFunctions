function pose=enddiskpose(position_BDS,orientation_BDS,L0,theta_tl,delta)
%this function gives the pose(position & orientation)of the end disk in THIS segment
%with parameters (position_BDS,orientation_BDS,L0,theta_tl,delta)
%this is not a general function
%Date: Dec.02, 2014
%revised on Jan. 06, 2018. small mistakes
%Copyright 2014 Sean Zhang. All rights reserved.
if theta_tl==0
    re_position_EDS=[0,0,L0]';      %A vector of 3X1, a relative expression of enddisk position in the base disk frame.
    position_EDS=orientation_BDS*re_position_EDS+position_BDS;    %convert it into a absolute frame
    % orientation_EDS
    orientation_EDS=orientation_BDS;  %3X3
    pose=[position_EDS,orientation_EDS];   %combination 3X4
else
    rho_t=L0/theta_tl;   %radius curvature of the primary backbone
    O_b=[rho_t*cos(-delta),rho_t*sin(-delta),0]';   %A vector of 3X1, represents the curvature center of primary backbone.
    re_position_EDS=zeros(3,1);      %A vector of 3X1, represents the center of end disk.
    re_position_EDS(1)=O_b(1)-rho_t*cos(theta_tl)*cos(-delta);       %x
    re_position_EDS(2)=O_b(2)-rho_t*cos(theta_tl)*sin(-delta);       %y
    re_position_EDS(3)=O_b(3)+rho_t*sin(theta_tl);                  %z
    position_EDS=orientation_BDS*re_position_EDS+position_BDS;    %convert it into a absolute frame
    %orientation calculation
    K=[cos(pi/2-delta),sin(pi/2-delta),0]';    %axis of bending backbone, in relative frame,a vector(direction) only,3X1.
    % orientation_EDS_4X4=rotation_K_theta(K(1:3,1),theta_tl-pi/2)*[orientation_BDS,zeros(3,1);0 0 0 1];    %4X4
    orientation_EDS_4X4=[orientation_BDS,position_BDS;0 0 0 1]*rotation_K_theta(K,theta_tl);    %4X4 
    orientation_EDS=orientation_EDS_4X4(1:3,1:3);  %3X3
    pose=[position_EDS,orientation_EDS];   %combination 3X4
end
%checked

