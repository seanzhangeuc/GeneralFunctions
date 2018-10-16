function jacobian2=jacobian_2seg(para,rel_pose)
%generate the Jacobian of a single segment.
%given the parameters of theta and delta in para as defined below.
%theta_tl is a 2X1 matrix. so does delta_t & lt.
%refer to Page34 of KAI.XU's Graduation thesis.
%a specified function for snake.
%Date: Nov.30, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
theta_tl=para(1,:);
delta_t=para(2,:);
lt=para(3,:);
%convert relative poses
b1_P2l=rel_pose.b1_P2l(1:3,:);
b1_P3l=rel_pose.b1_P3l(1:3,:);
b2_P3l=rel_pose.b2_P3l(1:3,:);
b1_Rb2=rel_pose.b1_Rb2;
b1_Rb3=rel_pose.b1_Rb3;
%construct the jacobian m
jacob_1st=jacobian_1seg(theta_tl(1),delta_t(1),lt(1));
jacob_2nd=jacobian_1seg(theta_tl(2),delta_t(2),lt(2));
jacob_1_v=jacob_1st(1:3,:);
jacob_1_w=jacob_1st(4:6,:);
jacob_2_v=jacob_2nd(1:3,:);
jacob_2_w=jacob_2nd(4:6,:);
jacobian2=zeros(6,4);
jacobian2(1:3,1:2)=jacob_1_v-skew_symmetric_matrix3(b1_P2l)*jacob_1_w;
jacobian2(1:3,3:4)=b1_Rb2*jacob_2_v;
jacobian2(4:6,1:2)=jacob_2_w;
jacobian2(4:6,3:4)=b1_Rb2*jacob_2_w;