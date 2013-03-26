function [y,t] = create_source(f0,B,P,fs,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

j = sqrt(-1);

K = fs;

f = 0:1:K-1;

YA = (P/2).*(sinc((f-f0)/(B/2))+sinc((f-(K-f0))/(B/2)));

YP = pi*rand(1,K/2) - pi;
YP = [0,YP,-fliplr(YP(1:K/2-1))];

Y = YA.*(cos(YP)+ j*sin(YP));

[y,t] = idft(Y,fs,N,K);

end

