close all
clear all
clc
x = [0 1 2 3 4 5 6 7];
N = length(x);
xCol = [x(1:N/2); x(N/2+1:N)]';
% compute DFTs
% even branch
V11 = dft(xCol(1,:),N/4);
V21 = dft(xCol(2,:),N/4);
% odd branch
V12 = dft(xCol(3,:),N/4);
V22 = dft(xCol(4,:),N/4);
% combine 2-point DFTs
WN = exp(-1i*2*pi/(N/2));
k = 0:1:N/4-1;
WNk = WN.^k;
F1(1:N/4) = V11+WNk.*V12;
F1(N/4+1:N/2) = V11-WNk.*V12;
F2(1:N/4) = V21+WNk.*V22;
F2(N/4+1:N/2) = V21-WNk.*V22;
% combine 4-point DFTs
WN = exp(-1i*2*pi/N);
k = 0:1:N/2-1;
WNk = WN.^k;
X(1:N/2) = F1+WNk.*F2;
X(N/2+1:N) = F1-WNk.*F2;
X = X/N;

figure
subplot(2,1,1)
plot(abs(X),'*')
hold on
Xfft = fft(x/N);
plot(abs(Xfft),'o')

subplot(2,1,2)
plot(phase(X),'*')
hold on
plot(phase(Xfft),'o')
