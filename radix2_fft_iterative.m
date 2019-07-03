close all
clear all
clc
% input data
x = 0:1:7;
N = length(x);
stages =  log2(N);
xprime = x;%copy of input for comparison

%% stage 1
WN = exp(-1i*2*pi/2);
k = 0:1;
for i = 1:N/4
    xn(2*i-1:2*i) = x(2*i-1)+x(2.^(stages-1)+2*i-1).*WN.^k;
end
for i = N/4+1:N/2
    xn(2*i-1:2*i) = x(2*i-2^(stages-1))+x(2*i).*WN.^k;
end
x = xn;
%% all other stages
for i = 2:stages
    c = 1;
    WN = exp(-1i*2*pi/(2^i));
    for j = 1:2^(stages-i)
        for k = 1:2
            for L = 1:2^(i-1)
                xn(c) = x(L+(j-1)*2^i)+x(L+2+(j-1)*2^i+2*(i-2)).*WN^(L-1+2^(i-1)*(k-1));
                c = c+1;
            end
        end
    end
    x = xn;
end