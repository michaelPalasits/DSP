close all
clear all
clc
% input data
x = 1:1:128;
xprime = x;%copy of input for comparison
x = bitrevorder(x);
N = length(x);
stages =  log2(N);


for i = 1:stages % stage loop
    WN = exp(-1i*2*pi/(2^i));
    c = 1;
    for j = 1:2^(stages-i)% branch loop
        k = 0;
        while k < 2^i % phase loop
            for m = 1:2^(i-1) % group loop
                X(c) = x(m+(2^i)*(j-1))+x(2^(i-1)+m+(2^i)*(j-1)).*WN^k;
                k = k+1;
                c = c+1;
            end
        end
    end
    x = X;
end

%comp
diff = fft(xprime)-X;
if (abs(diff) < 1e-6)
    diff = 0;
end
diff

figure
subplot(2,1,1)
plot(abs(fftshift(X)),'*')
hold on
Xfft = fftshift(fft(xprime));
plot(abs(Xfft),'o')

subplot(2,1,2)
plot(phase(fftshift(X)),'*')
hold on
plot(phase(Xfft),'o')