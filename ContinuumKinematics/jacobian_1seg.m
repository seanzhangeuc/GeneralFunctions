function jacobian=jacobian_1seg(theta,delta_t,lt)
%generate the Jacobian of a single segment.
%given the parameters of theta and delta
%a specified function for snake.
%Date: Nov.30, 2014
%revised on Feb. 20, 2018. for r426 use.
%Copyright 2014 Sean Zhang. All rights reserved.
error=abs(theta);      %sign of singularity
jacobian=ones(6,2);
if error>0.01
    jacobian(1,1)=lt*cos(delta_t)*(theta*sin(theta)+cos(theta)-1)/theta^2;
    jacobian(1,2)=lt*sin(delta_t)*(cos(theta)-1)/theta;
    jacobian(2,1)=lt*sin(delta_t)*(1-theta*sin(theta)-cos(theta))/theta^2;
    jacobian(2,2)=lt*cos(delta_t)*(cos(theta)-1)/theta;
    jacobian(3,1)=lt*(theta*cos(theta)-sin(theta))/theta^2;
    jacobian(3,2)=0;
    jacobian(4,1)=sin(delta_t);
    jacobian(4,2)=cos(delta_t)*sin(theta);
    jacobian(5,1)=cos(delta_t);
    jacobian(5,2)=-sin(delta_t)*sin(theta);
    jacobian(6,1)=0;
    jacobian(6,2)=-1+cos(theta);
else
    jacobian(1,1)=lt/2*cos(delta_t);
    jacobian(2,1)=-lt/2*sin(delta_t);
    jacobian(3,1)=0;
    jacobian(4,1)=sin(delta_t);
    jacobian(5,1)=cos(delta_t);
    jacobian(6,1)=0;
    jacobian(:,2)=zeros(6,1);
end
%checked & revised
    
