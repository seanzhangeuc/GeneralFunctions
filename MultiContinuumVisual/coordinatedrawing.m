function arrows=coordinatedrawing(orig_position,orientation,length)
%this function draws the coordinate defined by the input.
%Date: Jan.06, 2018
%Copyright 2014 Sean Zhang. All rights reserved.
orientation=length.*orientation; %introduce length to the normalized vectors
hold on
arrows_x=quiver3(orig_position(1),orig_position(2),orig_position(3),orientation(1,1),orientation(2,1),orientation(3,1),'r','filled','LineWidth',2);   % x axis
arrows_y=quiver3(orig_position(1),orig_position(2),orig_position(3),orientation(1,2),orientation(2,2),orientation(3,2),'g','filled','LineWidth',2);   % y axis
arrows_z=quiver3(orig_position(1),orig_position(2),orig_position(3),orientation(1,3),orientation(2,3),orientation(3,3),'b','filled','LineWidth',2);   % z axis
arrows=[arrows_x,arrows_y,arrows_z];