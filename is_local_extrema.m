function [bool] = is_local_extrema(Pixel,S, thresh)
% Pixel is the point we want to examine the local neighbourhood of
% S is the scale space
% we store the local neighbourhood in a matrix of size 27, and check if
% the center pixel is the max or min
bool = false;

x = Pixel(1);
y = Pixel(2);
z = Pixel(3);

local(1) = S(x+1,y+1,z+1);
local(2) = S(x+1,y+1,z);
local(3) = S(x+1,y+1,z-1);
local(4) = S(x+1,y,z+1);
local(5) = S(x+1,y,z);
local(6) = S(x+1,y,z-1);
local(7) = S(x+1,y-1,z+1);
local(8) = S(x+1,y-1,z);
local(9) = S(x+1,y-1,z-1);
local(10) = S(x,y+1,z+1);
local(11) = S(x,y+1,z);
local(12) = S(x,y+1,z-1);
local(13) = S(x,y,z+1);
local(14) = S(x,y,z);
local(15) = S(x,y,z-1);
local(16) = S(x,y-1,z+1);
local(17) = S(x,y-1,z);
local(18) = S(x,y-1,z-1);
local(19) = S(x-1,y+1,z+1);
local(20) = S(x-1,y+1,z);
local(21) = S(x-1,y+1,z-1);
local(22) = S(x-1,y,z+1);
local(23) = S(x-1,y,z);
local(24) = S(x-1,y,z-1);
local(25) = S(x-1,y-1,z+1);
local(26) = S(x-1,y-1,z);
local(27) = S(x-1,y-1,z-1);

local = sort(local);

if (local(1) == S(x,y,z) && (local(2) / local(1)) > thresh) || ...
        (local(27) == S(x,y,z) && (local(27) / local(26)) > thresh)
    bool = true;
end
