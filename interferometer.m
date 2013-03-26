fs = 4000;
N = 8000;
K = fs/2;
delay_t = 0.4;
delay_n = round(delay_t*fs);

% [m1,t1] = create_source(1,1,1,fs,N+delay_n);
% [m2,t2] = create_source(407,20,0,fs,N+delay_n);
% [m3,t3] = create_source(623,80,0,fs,N+delay_n);
% [m4,t4] = create_source(923,50,0,fs,N+delay_n);
% [m5,t5] = create_source(300,20,0,fs,N+delay_n);
[m1,t1] = create_source(111,101,0.7,fs,N+delay_n);
[m2,t2] = create_source(467,40,0.9,fs,N+delay_n);
[m3,t3] = create_source(693,80,0.6,fs,N+delay_n);
[m4,t4] = create_source(923,50,0.9,fs,N+delay_n);
[m5,t5] = create_source(300,20,0.5,fs,N+delay_n);

figure(1); plot(t1,m1,t2,m2,t3,m3,t4,m4,t5,m5)

o = m1(1+delay_n:N+delay_n) + m2(1:N)+ m3(1:N) + m4(1:N);
x = m1(1:N) + m2(1+delay_n*3/4:N+delay_n*3/4) + m3(1:N) + m5(1:N);
y = m1(1+delay_n/4:N+delay_n/4) + m2(1:N)+ m3(1+delay_n*3/4:N+delay_n*3/4) + m5(1:N);

t = t1(1:N);

figure(2); plot(t,o,t,x,t,y)

[O,fo] = dft(o(1:fs),fs,fs,fs);
[X,fx] = dft(x(1:fs),fs,fs,fs);
[Y,fy] = dft(y(1:fs),fs,fs,fs);

figure(3); plot(fo(1:fs/2),abs(O(1:fs/2)))
figure(4); plot(fx(1:fs/2),abs(X(1:fs/2)),fy(1:fs/2),abs(Y(1:fs/2)))

[r1,tau1] = cross_correlate(o,x,fs,K);
[r2,tau2] = cross_correlate(o,y,fs,K);

figure(5); plot(tau1,r1)
figure(6); plot(tau1,r2)

[R1,fR1] = dft(r1,fs,K*2,K*2);
[R2,fR2] = dft(r2,fs,K*2,K*2);

figure(7); plot(fR1(1:fs/2),abs(R1(1:fs/2)))
figure(8); plot(fR2(1:fs/2),abs(R2(1:fs/2)))

figure(9); plot(fR1(1:fs/2),unwrap(angle(round((R1(1:fs/2))))))
figure(10); plot(fR2(1:fs/2),unwrap(angle(round((R2(1:fs/2))))))

% r1_Hbp1 = round(filter(Hbp1,r1)/100);
% r2_Hbp1 = round(filter(Hbp1,r2)/100);
% 
% figure(11); plot(tau1,r1,tau1,r1_Hbp1*100)
% figure(12); plot(tau1,r2,tau1,r2_Hbp1*100)
% 
% r_Hbp1_xy = r1_Hbp1'*r2_Hbp1;
% 
% r1_Hbp2 = round(filter(Hbp2,r1)/100);
% r2_Hbp2 = round(filter(Hbp2,r2)/100);
% 
% figure(13); plot(tau1,r1,tau1,r1_Hbp2*100)
% figure(14); plot(tau1,r2,tau1,r2_Hbp2*100)
% 
% r_Hbp2_xy = r1_Hbp2'*r2_Hbp2;
% 
% r1_Hbp3 = round(filter(Hbp3,r1)/100);
% r2_Hbp3 = round(filter(Hbp3,r2)/100);
% 
% figure(15); plot(tau1,r1,tau1,r1_Hbp3*100)
% figure(16); plot(tau1,r2,tau1,r2_Hbp3*100)
% 
% r_Hbp3_xy = r1_Hbp3'*r2_Hbp3;
%  
% figure(20); contour(tau1,tau2,r_Hbp1_xy + 15*r_Hbp2_xy + 10*r_Hbp3_xy)

H = zeros(5,4000);
H(1,1:200) = 1;
H(2,201:400) = 1;
H(3,401:600) = 1;
H(4,601:800) = 1;
H(5,801:1000) = 1;

r_xy_H1 = ifft(H(1,:).*R2)'*(ifft(H(1,:).*R1));
r_xy_H2 = ifft(H(2,:).*R2)'*(ifft(H(2,:).*R1));
r_xy_H3 = ifft(H(3,:).*R2)'*(ifft(H(3,:).*R1));
r_xy_H4 = ifft(H(4,:).*R2)'*(ifft(H(4,:).*R1));
r_xy_H5 = ifft(H(5,:).*R2)'*(ifft(H(5,:).*R1));

r_xy = round(r_xy_H1 + r_xy_H2 + r_xy_H3 + r_xy_H4 + r_xy_H5);

figure(20); contour(tau1,tau2,real(r_xy))



