function [y] = floating(x,nbits,signed)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y = x/(2^(nbits-signed));

end

