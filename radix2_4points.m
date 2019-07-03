close all
clear all
clc
x = [1 2 0 0];
N = length(x);
% split sequence into even and odd samples
f1 = x(1:2:end);% even being index 0 and 2 (matlab indexes at 1)
f2 = x(2:2:end);
% compute dfts
F1 = dft(f1,N/2);
F2 = dft(f2,N/2);
% combine 2-point dfts
WN = exp(-1i*2*pi/N);
k = 0:1:N/2-1;
WNk = WN.^k;
X(1:N/2) = F1+WNk.*F2;
X(N/2+1:N) = F1-WNk.*F2;
% X = X/N;

figure
subplot(2,1,1)
plot(abs(X),'*')
hold on
Xfft = fft(x);
plot(abs(Xfft),'o')

subplot(2,1,2)
plot(angle(X),'*')
hold on
plot(angle(Xfft),'o')




function Xk = dft(x,N)

n = 0:1:N-1;
k = n;
WN = exp(-1i*2*pi/N);
nk = n'*k;
WNnk = WN.^nk;
Xk = x*WNnk;

end