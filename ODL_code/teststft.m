clc,clear all
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
mixeddir1 = 'DSD100\Mixtures\Test\015 - Fergessen - The Wind\mixture.wav';

vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
%filedir = strcat(rootdir,instFileNames.instOnly{13});
filedir = strcat(rootdir,mixeddir1);
%filedir = strcat(rootdir,vocalFileNames.vocalsOnly{1});

audio_mat = ReadAudio(filedir,1);
audio_mat = audio_mat(1:44100*10,1);
%sound(audio_mat,44100)
[stft, ~, ~] = shorttft(audio_mat, 44100);
[x, ~] = inverse_stft(stft, 44100);
%sound(x,44100)
k = abs(stft);
[x2, ~] = inverse_stft(k, 44100);
%sound(x2,44100)