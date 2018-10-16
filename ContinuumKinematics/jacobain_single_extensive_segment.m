function J=jacobain_single_extensive_segment(config,theta_thereshold)
% sketch for a extensive single segment
% this file is for recording only, no calculation
theta=config(1);
L=config(2);
delta=config(3);

Jv=zeros(3,3);
Jw=zeros(3,3);
if theta<theta_thereshold
    Jv(1,1)=cos(delta)*L/2;
    Jv(2,1)=-sin(delta)*L/2;
    Jv(3,2)=1;
    Jw(1,1)=sin(delta);
    Jw(2,1)=cos(delta);
else
    Jv(1,1)=cos(delta)*L/theta*(sin(theta)-(1-cos(theta))/theta);
    Jv(1,2)=cos(delta)*(1-cos(theta))/theta;
    Jv(1,3)=-L*sin(delta)*(1-cos(theta))/theta;
    Jv(2,1)=-sin(delta)*L/theta*(sin(theta)-(1-cos(theta))/theta);
    Jv(2,2)=-sin(delta)*(1-cos(theta))/theta;
    Jv(2,3)=-L*cos(delta)*(1-cos(theta))/theta;
    Jv(3,1)=L/theta*(cos(theta)-sin(theta)/theta);
    Jv(3,2)=sin(theta)/theta;
    Jw(1,1)=sin(delta);
    Jw(1,3)=cos(delta)*sin(theta);
    Jw(2,1)=cos(delta);
    Jw(2,3)=-sin(delta)*sin(theta);
    Jw(3,3)=cos(delta)-1;
end
J=[Jv;Jw];

