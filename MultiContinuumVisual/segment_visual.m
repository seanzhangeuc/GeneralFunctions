function seg=segment_visual(position_BDS,orientation_BDS,L0,theta_tl,delta,r)
% to generate one segment by drawing the components with one function to
% cut down the calculation time. 
%Date: Feb.21, 2018
%Copyright 2018 Sean Zhang. All rights reserved.

%% basic settings
% disk generating
point_num=36; %point # to draw a disk
disk_0=zeros(4,1); % space of coordinates of edge points [x,y,z,1]
for i=1:point_num
    disk_0(1,i)=r*sin(2*pi/point_num*i);  %X data
    disk_0(2,i)=r*cos(2*pi/point_num*i);   %Y data
    disk_0(3,i)=0;   %Z data
    disk_0(4,i)=1;
end
hold on
%% basedisk
disk_1=disk_0;
basedisk=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*disk_1;
seg.basedisk=patch(basedisk(1,:)',basedisk(2,:)',basedisk(3,:)','b','facealpha',0.3);
hold on
% coordinatedrawing(position_BDS,orientation_BDS,8);
%% backbones
%initialization
linepara0=ones(4,500);
linepara1=ones(4,500);
linepara2=ones(4,500);
linepara3=ones(4,500);
% parameters constructed at the origin
if theta_tl==0
    % situation of straight
    origin0=[0,0,0]';   %ogi is a vector of 3X1
    origin1=[r;0;0]; %radius curvature of 1st secondary backbone
    origin2=[r*cos(2*pi/3);r*sin(2*pi/3);0]; %radius curvature of 2nd secondary backbone
    origin3=[r*cos(4*pi/3);r*sin(4*pi/3);0]; %radius curvature of 1st secondary backbone
    % define the straight backbones
    linepara0(1,:)=origin0(1)*ones(1,500);
    linepara0(2,:)=origin0(2)*ones(1,500);
    linepara0(3,:)=linspace(0,L0,500);
    linepara0(4,:)=ones(1,500);
    linepara1(1,:)=origin1(1)*ones(1,500);
    linepara1(2,:)=origin1(2)*ones(1,500);
    linepara1(3,:)=linspace(0,L0,500);
    linepara1(4,:)=ones(1,500);
    linepara2(1,:)=origin2(1)*ones(1,500);
    linepara2(2,:)=origin2(2)*ones(1,500);
    linepara2(3,:)=linspace(0,L0,500);
    linepara2(4,:)=ones(1,500);
    linepara3(1,:)=origin3(1)*ones(1,500);
    linepara3(2,:)=origin3(2)*ones(1,500);
    linepara3(3,:)=linspace(0,L0,500);
    linepara3(4,:)=ones(1,500);
else
    rho_t=L0/theta_tl;    %radius curvature of the backbone
    %note the lines below is expressed in the bending plane coordinate ct
    ct_center0=[rho_t,0,0]';   %center is a vector of 3X1
    ct_center1=ct_center0+[0;r*sin(delta);0]; %radius curvature of 1st secondary backbone
    ct_center2=ct_center0+[0;r*sin(2*pi/3+delta);0]; %radius curvature of 2nd secondary backbone
    ct_center3=ct_center0+[0;r*sin(4*pi/3+delta);0]; %radius curvature of 1st secondary backbone
    bt_Tct=Rotation_z(-delta);   %4x4
    bt_Rct=bt_Tct(1:3,1:3);
    %convert points back to the tb coordinate
    center0=bt_Rct*ct_center0;
    center1=bt_Rct*ct_center1;
    center2=bt_Rct*ct_center2;
    center3=bt_Rct*ct_center3;
    r0=rho_t;
    r1=rho_t-r*cos(delta);
    r2=rho_t-r*cos(2*pi/3+delta);
    r3=rho_t-r*cos(4*pi/3+delta);
    for i=1:500
        linepara0(1,i)=center0(1)-r0*cos((i-1)/500*theta_tl)*cos(-delta);
        linepara0(2,i)=center0(2)-r0*cos((i-1)/500*theta_tl)*sin(-delta);
        linepara0(3,i)=center0(3)+r0*sin((i-1)/500*theta_tl);
        linepara0(4,i)=1;
        linepara1(1,i)=center1(1)-r1*cos((i-1)/500*theta_tl)*cos(-delta);
        linepara1(2,i)=center1(2)-r1*cos((i-1)/500*theta_tl)*sin(-delta);
        linepara1(3,i)=center1(3)+r1*sin((i-1)/500*theta_tl);
        linepara1(4,i)=1;
        linepara2(1,i)=center2(1)-r2*cos((i-1)/500*theta_tl)*cos(-delta);
        linepara2(2,i)=center2(2)-r2*cos((i-1)/500*theta_tl)*sin(-delta);
        linepara2(3,i)=center2(3)+r2*sin((i-1)/500*theta_tl);
        linepara2(4,i)=1;
        linepara3(1,i)=center3(1)-r3*cos((i-1)/500*theta_tl)*cos(-delta);
        linepara3(2,i)=center3(2)-r3*cos((i-1)/500*theta_tl)*sin(-delta);
        linepara3(3,i)=center3(3)+r3*sin((i-1)/500*theta_tl);
        linepara3(4,i)=1;
    end
end
% translation to the target base coordinate
line0=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*linepara0;   
line1=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*linepara1;
line2=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*linepara2;
line3=Translation(position_BDS)*[orientation_BDS,zeros(3,1);0 0 0 1]*linepara3;  
%draw the line
curve0=line(line0(1,:), line0(2,:), line0(3,:));
curve1=line(line1(1,:), line1(2,:), line1(3,:));
curve2=line(line2(1,:), line2(2,:), line2(3,:));
curve3=line(line3(1,:), line3(2,:), line3(3,:));
% get(curve)
set(curve0,'LineWidth',[2],'Color',[1 1 0]);
set(curve1,'LineWidth',[2],'Color',[1 0 0]);
set(curve2,'LineWidth',[2],'Color',[0 1 0]);
set(curve3,'LineWidth',[2],'Color',[0 0 1]);
%checked
hold on
seg.backbone=[curve0,curve1,curve2,curve3];
%% spacerdisk
disk_2=disk_0;
spacerdisk_pose=enddiskpose(position_BDS,orientation_BDS,L0/2,0.5*theta_tl,delta);   %pose of end disk
disk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_2;
seg.spacerdisk=patch(disk(1,:)',disk(2,:)',disk(3,:)','b');
%% enddisk
disk_3=disk_0;
enddisk_pose=enddiskpose(position_BDS,orientation_BDS,L0,theta_tl,delta);  %pose of end disk
disk=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*disk_3;
seg.enddisk=patch(disk(1,:)',disk(2,:)',disk(3,:)','b','facealpha',0.3);
seg.enddiskpose=enddisk_pose;
hold on