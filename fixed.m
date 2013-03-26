function [y] = fixed(x,nbits,signed)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y = round(x*2^(nbits-signed));

end

