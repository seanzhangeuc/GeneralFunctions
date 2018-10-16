function ssm=skew_symmetric_matrix3(vector)
%generate the skew symmetric matrix for a 3X1 vector.
%such that vector A cross M = ssm(A) dot M for M(3X3).
%Date: Nov.30, 2014
%Copyright 2014 Sean Zhang. All rights reserved.
ssm=zeros(3);
ssm(1,2)=-vector(3);
ssm(1,3)=vector(2);
ssm(2,1)=vector(3);
ssm(2,3)=-vector(1);
ssm(3,1)=-vector(2);
ssm(3,2)=vector(1);
