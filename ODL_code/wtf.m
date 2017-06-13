clear, clc, close all

% define signal parameters 
% sine-wave signal (stationary signal)

fs = 48000; 
t = 0:1/fs:1-1/fs; 
x = 10*sin(2*pi*t*10);

% define analysis and synthesis parameters 
wlen = 64; 
h = wlen/4; 
nfft = wlen;

% perform analysis and resynthesis 
[stft, f, t_stft] = stft(x, wlen, h, nfft, fs); 
[x_istft, t_istft] = istft(stft, h, nfft, fs);

% plot the original signal 
figure(1) 
plot(t, x, 'b') 
grid on 
axis([0 1 -15 15]) 
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14) 
xlabel('Time, s') 
ylabel('Amplitude, V') 
title('Original and reconstructed signal')

% plot the resynthesized signal 
hold on 
plot(t_istft, x_istft, '-.r') 
legend('Original signal', 'Reconstructed signal')