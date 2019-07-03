close all
clear all
clc
% input data
x = 0:1:7;
N = length(x);
stages =  log2(N);
xCol = [x(1:N/2); x(N/2+1:N)]';
% xCol = split(x,N);
xprime = x;%copy of input for comparison

%% stage 1
% compute DFTs
% even branch
xn(1:2) = dft(xCol(1,:),N/4);
xn(3:4) = dft(xCol(3,:),N/4);
% odd branch
xn(5:6) = dft(xCol(2,:),N/4);
xn(7:8) = dft(xCol(4,:),N/4);
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

function xColWise = split(x,N)

xColWise = zeros(1,N);
for i = 1:N/2
    xColWise(2*i-1) = x(i);
    xColWise(2*i) = x(i+N/2);
end

end