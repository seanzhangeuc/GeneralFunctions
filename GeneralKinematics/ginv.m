function G=ginv(X)
% to generate the Reflexive generalized inverse matrix of A.
% reference page: https://www.mathworks.com/matlabcentral/fileexchange/22687-ginv-x
% J is a mXn matrix
% Date: Sept.28, 2018
% Copyright 2018 Sean Zhang. All rights reserved.

[n,k] = size(X); r = rank(X);

% 1. Find any nonsingular rxr submatrix C. It is not necessary that 
%    the elements of C occupy adjacent rows and columns in A.

[x,i] = sort(rand(1,n));
[y,j] = sort(rand(1,k));

C = X(i(1:r),j(1:r));

while rank(C)<r
    [x,i] = sort(rand(1,n));
    [y,j] = sort(rand(1,k));
    C = X(i(1:r),j(1:r));
end

% 2. Find inv(C) and [inv(C)]'

C = C\eye(r); C = C';

% 3. Replace the elements of C by the elements of [inv(C)]'
% 4. Replace all other elements in A by zeros

G = zeros(n,k);
G(i(1:r),j(1:r)) = C;

% 5. Transpose the resulting matrix

G = G';