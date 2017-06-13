clc,clear all
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
mixeddir1 = 'DSD100\Mixtures\Test\015 - Fergessen - The Wind\mixture.wav';
mixeddir2 = 'DSD100\Mixtures\Test\034 - Secretariat - Over The Top\mixture.wav';
mixeddir3 = 'DSD100\Mixtures\Test\047 - Voelund - Comfort Lives In Belief\mixture.wav';
sparsity = 20;
compress_rate=1;
samplerate = 44100;
num_sample = samplerate*10;

filedir = strcat(rootdir,mixeddir1);
audio_mat = ReadAudio(filedir,compress_rate);

s1 = audio_mat;
s2 = audio_mat(1:num_sample,:);

[stft1, f, t] = shorttft(s1, samplerate);
stft_abs1 = abs(stft1);
stft_phase1 = stft1./stft_abs1;
%stft_phase1 = unwrap(stft1);
inverse = inverse_stft(stft_abs1.*stft_phase1,samplerate);

[stft2, f, t] = shorttft(s2, samplerate);
ttt2 = inverse_stft(stft2,samplerate);
%sound(ttt2,samplerate)
stft_abs2 = abs(stft2);
stft_phase2 = stft2./stft_abs2;
stft_phase2(isnan(stft_phase2))=0;
%stft_phase2 = unwrap(stft2);
inverse2 = inverse_stft(stft_abs2.*stft_phase2,samplerate);
%sound(inverse2,samplerate)
n = size(stft_abs2,2);

diff = sum(sum((stft_abs1(:,1:n)-stft_abs2).^2,1),2);