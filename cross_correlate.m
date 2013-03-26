function [r,tau] = cross_correlate (x,y,fs,K)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

N = length(x);

r = zeros(1,2*K);

Ts = 1/fs;
tau = -(K*Ts):Ts:((K-1)*Ts);

for k = -K:K-1,
    r(K + k + 1) = conj(x(K+1:N-K))*y(K+k+1:N-K+k)';
end

r = r/(N-2*K);

end
