function pose=statical_segments(para,pose_BDS)
%to generate a statical image, or a frame to show the snake
%para is a 3Xn matrix showing the theta, delta and length of backbone with
%each column, as [pi/3,pi/4,pi/6;pi/4,pi/12,pi/3;100 100 100] for a 3-seg
%snake.
%pose is a 3X4 matrix showing the pose(position & Orientation) of the 1st
%base disk. Note only 2 columns of Orientation is independent.[p|x,y,z]
%size of disk is defined in function as 5
%Date: Dec.02, 2014
%Copyright 2014 Sean Zhang. All rights reserved.

Matrix_theta=para(1,:);
Matrix_delta=para(2,:);
L=para(3,:); %get the length of every segment
radius_d=2.3;
seg_num=size(para);
pose=pose_BDS;
axis equal
% axis([-75 75 -75 75 0 150]);
xlabel x
ylabel y
zlabel z

view(3)
box on
grid on
for i=1:seg_num(2)
%     segment_basedisk(pose(:,1),pose(:,2:4),radius_d); %draw the basedisk 
%     segment_backbone(pose(:,1),pose(:,2:4),L(i),Matrix_theta(i),Matrix_delta(i),radius_d); %draw the backbone of ith segment
%     segment_spacerdisk(pose(:,1),pose(:,2:4),L(i),Matrix_theta(i),Matrix_delta(i),radius_d); %draw spacerdisks
%     segment_enddisk(pose(:,1),pose(:,2:4),L(i),Matrix_theta(i),Matrix_delta(i),radius_d); %draw enddisks
% or using a compact version of segment drawing.
    seg=segment_visual(pose(:,1),pose(:,2:4),L(i),Matrix_theta(i),Matrix_delta(i),radius_d);
    if i==seg_num(2)
        segment_gripper(pose(:,1),pose(:,2:4),L(i),Matrix_theta(i),Matrix_delta(i),radius_d); %draw the gripper
    end
    pose=seg.enddiskpose;
end
set(gca,'xtick',-50:25:50)
set(gca,'ytick',-50:25:50)