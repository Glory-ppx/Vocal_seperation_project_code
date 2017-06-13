clc,clear all
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';

% dictionary learning setting
dict_num = 100;
options.K = dict_num;  
options.niter_inversion = 100;
options.nbr_max_atoms = 10;
%read in and truncate time setting
compress_rate = 1;
samplerate = 44100/compress_rate;%audio_info.SampleRate;
truncate_time = 6; %in secs
truncate_sample = samplerate*truncate_time;

% read in the file
vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
filedir = strcat(rootdir,instFileNames.instOnly{13});
%filedir = strcat(rootdir,vocalFileNames.vocalsOnly{1});

tic
alldict = [];
audio_mat = ReadAudio(filedir,1);
number_truncate = floor(size(audio_mat,1)/truncate_sample);
for i = 1:number_truncate
    [stft, f, t] = shorttft(audio_mat((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
    stft2 = abs(stft);
    [dict,~,~] = perform_dictionary_learning(stft2,options);
    alldict = [alldict,dict];
end
%[x, ~] = inverse_stft(stft, 44100);
%sound(x,44100)
toc