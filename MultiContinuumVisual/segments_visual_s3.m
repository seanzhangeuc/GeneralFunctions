function segs=segments_visual_s3(config,position_SOS,orientation_SOS,lengths)
% to generate one segment by drawing the components with one function to
% cut down the calculation time. 
%Date: Feb.21, 2018
%Copyright 2018 Sean Zhang. All rights reserved.

%% basic settings
L1=lengths(1);
Ln=lengths(2);
L2=lengths(3);
r=2.3;
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

% backbones generating
% initialization
linepara0=ones(4,500);
linepara1=ones(4,500);
linepara2=ones(4,500);
linepara3=ones(4,500);

%% parameter convertion
phi=config(1);
L0=config(2);
theta1=config(3);
delta1=config(4);
theta2=config(5);
delta2=config(6);



%% Stem Section
position_SS=position_SOS;
orientation_SS=orientation_SOS*[cos(phi),-sin(phi),0;sin(phi),cos(phi),0;0,0,1];
%% basedisk
stem_basedisk=Translation(position_SS)*[orientation_SS,zeros(3,1);0 0 0 1]*disk_0;
segs.stem_basedisk=patch(stem_basedisk(1,:)',stem_basedisk(2,:)',stem_basedisk(3,:)','b','facealpha',0.3);
hold on
%% backbones
% parameters constructed at the origin
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

% translation to the target base coordinate
line0=Translation(position_SS)*[orientation_SS,zeros(3,1);0 0 0 1]*linepara0;   
line1=Translation(position_SS)*[orientation_SS,zeros(3,1);0 0 0 1]*linepara1;
line2=Translation(position_SS)*[orientation_SS,zeros(3,1);0 0 0 1]*linepara2;
line3=Translation(position_SS)*[orientation_SS,zeros(3,1);0 0 0 1]*linepara3;  
%draw the line
curve0=line(line0(1,:), line0(2,:), line0(3,:));
curve1=line(line1(1,:), line1(2,:), line1(3,:));
curve2=line(line2(1,:), line2(2,:), line2(3,:));
curve3=line(line3(1,:), line3(2,:), line3(3,:));
% get(curve)
set(curve0,'LineWidth',2,'Color',[1 1 0]);
set(curve1,'LineWidth',2,'Color',[1 0 0]);
set(curve2,'LineWidth',2,'Color',[0 1 0]);
set(curve3,'LineWidth',2,'Color',[0 0 1]);
%checked
hold on
segs.stem_backbone=[curve0,curve1,curve2,curve3];
%% spacer disk
% spacerdisk_pose=enddiskpose(position_SS,orientation_SS,L0/2,0,0);   %pose of end disk
spacerdisk_pose=[orientation_SS*[0,0,L0/2]'+position_SS,orientation_SS];
stem_spacerdisk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
segs.stem_spacerdisk=patch(stem_spacerdisk(1,:)',stem_spacerdisk(2,:)',stem_spacerdisk(3,:)','b');
%% end disk
% enddisk_pose=enddiskpose(position_SS,orientation_SS,L0,0,0);  %pose of end disk
enddisk_pose=[orientation_SS*[0,0,L0]'+position_SS,orientation_SS];
stem_enddisk=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*disk_0;
segs.stem_enddisk=patch(stem_enddisk(1,:)',stem_enddisk(2,:)',stem_enddisk(3,:)','b','facealpha',0.3);
% segs.enddiskpose=enddisk_pose;



%% 1st segment
position_1BOS=enddisk_pose(:,1);
orientation_1BOS=enddisk_pose(:,2:4);
%% basedisk
seg1_basedisk=Translation(position_1BOS)*[orientation_1BOS,zeros(3,1);0 0 0 1]*disk_0;
segs.seg1_basedisk=patch(seg1_basedisk(1,:)',seg1_basedisk(2,:)',seg1_basedisk(3,:)','b','facealpha',0.3);
hold on
%% backbones
% parameters constructed at the origin
if theta1==0
    % situation of straight
    origin0=[0,0,0]';   %ogi is a vector of 3X1
    origin1=[r;0;0]; %radius curvature of 1st secondary backbone
    origin2=[r*cos(2*pi/3);r*sin(2*pi/3);0]; %radius curvature of 2nd secondary backbone
    origin3=[r*cos(4*pi/3);r*sin(4*pi/3);0]; %radius curvature of 1st secondary backbone
    % define the straight backbones
    linepara0(1,:)=origin0(1)*ones(1,500);
    linepara0(2,:)=origin0(2)*ones(1,500);
    linepara0(3,:)=linspace(0,L1,500);
    linepara0(4,:)=ones(1,500);
    linepara1(1,:)=origin1(1)*ones(1,500);
    linepara1(2,:)=origin1(2)*ones(1,500);
    linepara1(3,:)=linspace(0,L1,500);
    linepara1(4,:)=ones(1,500);
    linepara2(1,:)=origin2(1)*ones(1,500);
    linepara2(2,:)=origin2(2)*ones(1,500);
    linepara2(3,:)=linspace(0,L1,500);
    linepara2(4,:)=ones(1,500);
    linepara3(1,:)=origin3(1)*ones(1,500);
    linepara3(2,:)=origin3(2)*ones(1,500);
    linepara3(3,:)=linspace(0,L1,500);
    linepara3(4,:)=ones(1,500);
else
    rho_t=L1/theta1;    %radius curvature of the backbone
    %note the lines below is expressed in the bending plane coordinate ct
    ct_center0=[rho_t,0,0]';   %center is a vector of 3X1
    ct_center1=ct_center0+[0;r*sin(delta1);0]; %radius curvature of 1st secondary backbone
    ct_center2=ct_center0+[0;r*sin(2*pi/3+delta1);0]; %radius curvature of 2nd secondary backbone
    ct_center3=ct_center0+[0;r*sin(4*pi/3+delta1);0]; %radius curvature of 1st secondary backbone
    bt_Tct=Rotation_z(-delta1);   %4x4
    bt_Rct=bt_Tct(1:3,1:3);
    %convert points back to the tb coordinate
    center0=bt_Rct*ct_center0;
    center1=bt_Rct*ct_center1;
    center2=bt_Rct*ct_center2;
    center3=bt_Rct*ct_center3;
    r0=rho_t;
    r1=rho_t-r*cos(delta1);
    r2=rho_t-r*cos(2*pi/3+delta1);
    r3=rho_t-r*cos(4*pi/3+delta1);
    for i=1:500
        linepara0(1,i)=center0(1)-r0*cos((i-1)/500*theta1)*cos(-delta1);
        linepara0(2,i)=center0(2)-r0*cos((i-1)/500*theta1)*sin(-delta1);
        linepara0(3,i)=center0(3)+r0*sin((i-1)/500*theta1);
        linepara0(4,i)=1;
        linepara1(1,i)=center1(1)-r1*cos((i-1)/500*theta1)*cos(-delta1);
        linepara1(2,i)=center1(2)-r1*cos((i-1)/500*theta1)*sin(-delta1);
        linepara1(3,i)=center1(3)+r1*sin((i-1)/500*theta1);
        linepara1(4,i)=1;
        linepara2(1,i)=center2(1)-r2*cos((i-1)/500*theta1)*cos(-delta1);
        linepara2(2,i)=center2(2)-r2*cos((i-1)/500*theta1)*sin(-delta1);
        linepara2(3,i)=center2(3)+r2*sin((i-1)/500*theta1);
        linepara2(4,i)=1;
        linepara3(1,i)=center3(1)-r3*cos((i-1)/500*theta1)*cos(-delta1);
        linepara3(2,i)=center3(2)-r3*cos((i-1)/500*theta1)*sin(-delta1);
        linepara3(3,i)=center3(3)+r3*sin((i-1)/500*theta1);
        linepara3(4,i)=1;
    end
end
% translation to the target base coordinate
line0=Translation(position_1BOS)*[orientation_1BOS,zeros(3,1);0 0 0 1]*linepara0;   
line1=Translation(position_1BOS)*[orientation_1BOS,zeros(3,1);0 0 0 1]*linepara1;
line2=Translation(position_1BOS)*[orientation_1BOS,zeros(3,1);0 0 0 1]*linepara2;
line3=Translation(position_1BOS)*[orientation_1BOS,zeros(3,1);0 0 0 1]*linepara3;  
%draw the line
curve0=line(line0(1,:), line0(2,:), line0(3,:));
curve1=line(line1(1,:), line1(2,:), line1(3,:));
curve2=line(line2(1,:), line2(2,:), line2(3,:));
curve3=line(line3(1,:), line3(2,:), line3(3,:));
% get(curve)
set(curve0,'LineWidth',2,'Color',[1 1 0]);
set(curve1,'LineWidth',2,'Color',[1 0 0]);
set(curve2,'LineWidth',2,'Color',[0 1 0]);
set(curve3,'LineWidth',2,'Color',[0 0 1]);
%checked
% hold on
segs.seg1_backbone=[curve0,curve1,curve2,curve3];
%% spacer disk
spacerdisk_pose=enddiskpose(position_1BOS,orientation_1BOS,L1/2,0.5*theta1,delta1);   %pose of end disk
seg1_spacerdisk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
segs.seg1_spacerdisk=patch(seg1_spacerdisk(1,:)',seg1_spacerdisk(2,:)',seg1_spacerdisk(3,:)','b');
%% end disk
enddisk_pose=enddiskpose(position_1BOS,orientation_1BOS,L1,theta1,delta1);  %pose of end disk
seg1_enddisk=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*disk_0;
segs.seg1_enddisk=patch(seg1_enddisk(1,:)',seg1_enddisk(2,:)',seg1_enddisk(3,:)','b','facealpha',0.3);



%% Neck Section
position_NSS=enddisk_pose(:,1);
orientation_NSS=enddisk_pose(:,2:4);
%% basedisk
neck_basedisk=Translation(position_NSS)*[orientation_NSS,zeros(3,1);0 0 0 1]*disk_0;
segs.neck_basedisk=patch(neck_basedisk(1,:)',neck_basedisk(2,:)',neck_basedisk(3,:)','b','facealpha',0.3);
% hold on
%% backbones
% parameters constructed at the origin
    % situation of straight
    origin0=[0,0,0]';   %ogi is a vector of 3X1
    origin1=[r;0;0]; %radius curvature of 1st secondary backbone
    origin2=[r*cos(2*pi/3);r*sin(2*pi/3);0]; %radius curvature of 2nd secondary backbone
    origin3=[r*cos(4*pi/3);r*sin(4*pi/3);0]; %radius curvature of 1st secondary backbone
    % define the straight backbones
    linepara0(1,:)=origin0(1)*ones(1,500);
    linepara0(2,:)=origin0(2)*ones(1,500);
    linepara0(3,:)=linspace(0,Ln,500);
    linepara0(4,:)=ones(1,500);
    linepara1(1,:)=origin1(1)*ones(1,500);
    linepara1(2,:)=origin1(2)*ones(1,500);
    linepara1(3,:)=linspace(0,Ln,500);
    linepara1(4,:)=ones(1,500);
    linepara2(1,:)=origin2(1)*ones(1,500);
    linepara2(2,:)=origin2(2)*ones(1,500);
    linepara2(3,:)=linspace(0,Ln,500);
    linepara2(4,:)=ones(1,500);
    linepara3(1,:)=origin3(1)*ones(1,500);
    linepara3(2,:)=origin3(2)*ones(1,500);
    linepara3(3,:)=linspace(0,Ln,500);
    linepara3(4,:)=ones(1,500);

% translation to the target base coordinate
line0=Translation(position_NSS)*[orientation_NSS,zeros(3,1);0 0 0 1]*linepara0;   
line1=Translation(position_NSS)*[orientation_NSS,zeros(3,1);0 0 0 1]*linepara1;
line2=Translation(position_NSS)*[orientation_NSS,zeros(3,1);0 0 0 1]*linepara2;
line3=Translation(position_NSS)*[orientation_NSS,zeros(3,1);0 0 0 1]*linepara3;  
%draw the line
curve0=line(line0(1,:), line0(2,:), line0(3,:));
curve1=line(line1(1,:), line1(2,:), line1(3,:));
curve2=line(line2(1,:), line2(2,:), line2(3,:));
curve3=line(line3(1,:), line3(2,:), line3(3,:));
% get(curve)
set(curve0,'LineWidth',2,'Color',[1 1 0]);
set(curve1,'LineWidth',2,'Color',[1 0 0]);
set(curve2,'LineWidth',2,'Color',[0 1 0]);
set(curve3,'LineWidth',2,'Color',[0 0 1]);
%checked
% hold on
segs.neck_backbone=[curve0,curve1,curve2,curve3];
%% spacer disk
spacerdisk_pose=[orientation_NSS*[0,0,Ln/2]'+position_NSS,orientation_NSS];%pose of end disk
neck_spacerdisk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
segs.neck_spacerdisk=patch(neck_spacerdisk(1,:)',neck_spacerdisk(2,:)',neck_spacerdisk(3,:)','b');
%% end disk
enddisk_pose=[orientation_NSS*[0,0,Ln]'+position_NSS,orientation_NSS];%pose of end disk
neck_enddisk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
segs.neck_enddisk=patch(neck_enddisk(1,:)',neck_enddisk(2,:)',neck_enddisk(3,:)','b','facealpha',0.3);
% segs.enddiskpose=enddisk_pose;


%% 2nd segment
position_2BOS=enddisk_pose(:,1);
orientation_2BOS=enddisk_pose(:,2:4);
%% basedisk
seg2_basedisk=Translation(position_2BOS)*[orientation_2BOS,zeros(3,1);0 0 0 1]*disk_0;
segs.seg2_basedisk=patch(seg2_basedisk(1,:)',seg2_basedisk(2,:)',seg2_basedisk(3,:)','b','facealpha',0.3);
% hold on
%% backbones
% parameters constructed at the origin
if theta2==0
    % situation of straight
    origin0=[0,0,0]';   %ogi is a vector of 3X1
    origin1=[r;0;0]; %radius curvature of 1st secondary backbone
    origin2=[r*cos(2*pi/3);r*sin(2*pi/3);0]; %radius curvature of 2nd secondary backbone
    origin3=[r*cos(4*pi/3);r*sin(4*pi/3);0]; %radius curvature of 1st secondary backbone
    % define the straight backbones
    linepara0(1,:)=origin0(1)*ones(1,500);
    linepara0(2,:)=origin0(2)*ones(1,500);
    linepara0(3,:)=linspace(0,L2,500);
    linepara0(4,:)=ones(1,500);
    linepara1(1,:)=origin1(1)*ones(1,500);
    linepara1(2,:)=origin1(2)*ones(1,500);
    linepara1(3,:)=linspace(0,L2,500);
    linepara1(4,:)=ones(1,500);
    linepara2(1,:)=origin2(1)*ones(1,500);
    linepara2(2,:)=origin2(2)*ones(1,500);
    linepara2(3,:)=linspace(0,L2,500);
    linepara2(4,:)=ones(1,500);
    linepara3(1,:)=origin3(1)*ones(1,500);
    linepara3(2,:)=origin3(2)*ones(1,500);
    linepara3(3,:)=linspace(0,L2,500);
    linepara3(4,:)=ones(1,500);
else
    rho_t=L2/theta2;    %radius curvature of the backbone
    %note the lines below is expressed in the bending plane coordinate ct
    ct_center0=[rho_t,0,0]';   %center is a vector of 3X1
    ct_center1=ct_center0+[0;r*sin(delta2);0]; %radius curvature of 1st secondary backbone
    ct_center2=ct_center0+[0;r*sin(2*pi/3+delta2);0]; %radius curvature of 2nd secondary backbone
    ct_center3=ct_center0+[0;r*sin(4*pi/3+delta2);0]; %radius curvature of 1st secondary backbone
    bt_Tct=Rotation_z(-delta2);   %4x4
    bt_Rct=bt_Tct(1:3,1:3);
    %convert points back to the tb coordinate
    center0=bt_Rct*ct_center0;
    center1=bt_Rct*ct_center1;
    center2=bt_Rct*ct_center2;
    center3=bt_Rct*ct_center3;
    r0=rho_t;
    r1=rho_t-r*cos(delta2);
    r2=rho_t-r*cos(2*pi/3+delta2);
    r3=rho_t-r*cos(4*pi/3+delta2);
    for i=1:500
        linepara0(1,i)=center0(1)-r0*cos((i-1)/500*theta2)*cos(-delta2);
        linepara0(2,i)=center0(2)-r0*cos((i-1)/500*theta2)*sin(-delta2);
        linepara0(3,i)=center0(3)+r0*sin((i-1)/500*theta2);
        linepara0(4,i)=1;
        linepara1(1,i)=center1(1)-r1*cos((i-1)/500*theta2)*cos(-delta2);
        linepara1(2,i)=center1(2)-r1*cos((i-1)/500*theta2)*sin(-delta2);
        linepara1(3,i)=center1(3)+r1*sin((i-1)/500*theta2);
        linepara1(4,i)=1;
        linepara2(1,i)=center2(1)-r2*cos((i-1)/500*theta2)*cos(-delta2);
        linepara2(2,i)=center2(2)-r2*cos((i-1)/500*theta2)*sin(-delta2);
        linepara2(3,i)=center2(3)+r2*sin((i-1)/500*theta2);
        linepara2(4,i)=1;
        linepara3(1,i)=center3(1)-r3*cos((i-1)/500*theta2)*cos(-delta2);
        linepara3(2,i)=center3(2)-r3*cos((i-1)/500*theta2)*sin(-delta2);
        linepara3(3,i)=center3(3)+r3*sin((i-1)/500*theta2);
        linepara3(4,i)=1;
    end
end
% translation to the target base coordinate
line0=Translation(position_2BOS)*[orientation_2BOS,zeros(3,1);0 0 0 1]*linepara0;   
line1=Translation(position_2BOS)*[orientation_2BOS,zeros(3,1);0 0 0 1]*linepara1;
line2=Translation(position_2BOS)*[orientation_2BOS,zeros(3,1);0 0 0 1]*linepara2;
line3=Translation(position_2BOS)*[orientation_2BOS,zeros(3,1);0 0 0 1]*linepara3;  
%draw the line
curve0=line(line0(1,:), line0(2,:), line0(3,:));
curve1=line(line1(1,:), line1(2,:), line1(3,:));
curve2=line(line2(1,:), line2(2,:), line2(3,:));
curve3=line(line3(1,:), line3(2,:), line3(3,:));
% get(curve)
set(curve0,'LineWidth',2,'Color',[1 1 0]);
set(curve1,'LineWidth',2,'Color',[1 0 0]);
set(curve2,'LineWidth',2,'Color',[0 1 0]);
set(curve3,'LineWidth',2,'Color',[0 0 1]);
%checked
% hold on
segs.seg2_backbone=[curve0,curve1,curve2,curve3];
%% spacer disk
spacerdisk_pose=enddiskpose(position_2BOS,orientation_2BOS,L2/2,0.5*theta2,delta2);   %pose of end disk
seg2_spacerdisk=[spacerdisk_pose(:,2:4),spacerdisk_pose(:,1);0 0 0 1]*disk_0;
segs.seg2_spacerdisk=patch(seg2_spacerdisk(1,:)',seg2_spacerdisk(2,:)',seg2_spacerdisk(3,:)','b');
%% end disk
enddisk_pose=enddiskpose(position_2BOS,orientation_2BOS,L2,theta2,delta2);  %pose of end disk
seg2_enddisk=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*disk_0;
segs.seg2_enddisk=patch(seg2_enddisk(1,:)',seg2_enddisk(2,:)',seg2_enddisk(3,:)','b','facealpha',0.3);



%% gripper
gripper_0=zeros(4,4);
gripper_0(1,:)=0;                 %x
gripper_0(2,:)=[r/5 4*r/5 4*r/5 r/5];   %y
gripper_0(3,:)=[0 0 3*r/5 8*r/5];       %z
gripper_0(4,:)=1;
% enddisk_pose=enddiskpose(position_BDS,orientation_BDS,L0,theta_tl,delta);  %pose of end disk
gripper1=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*gripper_0;
gripper2=Translation(enddisk_pose(:,1))*[enddisk_pose(:,2:4),zeros(3,1);0 0 0 1]*Rotation_z(pi)*gripper_0;
segs.gripper(1)=patch(gripper1(1,:)',gripper1(2,:)',gripper1(3,:)','r');
segs.gripper(2)=patch(gripper2(1,:)',gripper2(2,:)',gripper2(3,:)','r');
set(segs.gripper(1),'FaceVertexAlphaData',0.5)
set(segs.gripper(2),'FaceVertexAlphaData',0.5)

%% visualization configuration
xlabel x
ylabel y
zlabel z
% view(3)
box on
grid on
axis equal
% set(gca,'xtick',-50:25:50)
% set(gca,'ytick',-50:25:50)