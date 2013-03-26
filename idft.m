function [y,t] = idft (Y,fs,N,K)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

j = sqrt(-1);

n = 0:N-1;

finc = fs/K;

WR = zeros(K,N);
WI = zeros(K,N);
for k = 0:K-1
    wk = (2*pi*k*finc)/K;
    WR(k+1,:) = fixed(cos(wk*n),16,1); % int_16 fixed point
    WI(k+1,:) = fixed(sin(wk*n),16,1); % int_16 fixed point
end

Y = fixed(Y,16,1); % int_16 fixed point

R = Y*WR; % Y&WR = int_16 fixed point: R = int_31
I = Y*WI; % Y&WR = int_16 fixed point: I = int_31

y = floating((R+j*I),31,1);

Ts = 1/fs;
t = 0:Ts:(N-1)*Ts;

end
