function [Y,f] = dft (y,fs,N,K)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

j = sqrt(-1);

n = 0:N-1;

finc = fs/N;

WR = zeros(K,N);
WI = zeros(K,N);
for k = 0:K-1
    wk = (2*pi*k*finc)/N;
    WR(k+1,:) = fixed(cos(wk*n),16,1); % int_16 fixed point
    WI(k+1,:) = fixed(sin(wk*n),16,1); % int_16 fixed point
end

y = fixed(y,16,1); % int_16 fixed point

R = y*WR;
I = y*WI;

Y = floating((R-j*I),31,1);

f = 0:finc:(fs-finc);
end

