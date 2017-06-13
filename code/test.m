%testdir = 'E:\DSD100\Sources\Dev\051 - AM Contra - Heart Peripheral\vocals.wav';
%audio_info = audioinfo(testdir);
% test_mat = audio2mat(testdir,false);
% 
% %recovery
% %test_mat_mix = result of mixture of 2 channels
% %value between -1 and 1
% test_mat_mix = test_mat(:,1)+test_mat(:,2);
% max_test_mat=max(max(max(test_mat_mix)),max(abs(min(test_mat_mix))));
% test_mat_mix = test_mat_mix./max_test_mat;
% Y_2 = [test_mat_mix,test_mat_mix];
% Y_1 = [test_mat(:,1),test_mat(:,1)];
% 
% audiowrite('Mixed.wav',Y_2,audio_info.SampleRate)
% audiowrite('Channel_1.wav',Y_1,audio_info.SampleRate)


rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
%% Truncate and Transform
 truncate_time = 30; %in secs
 samplerate = 44100;%audio_info.SampleRate;
 truncate_sample = samplerate*truncate_time;


vocals_mat = zeros(truncate_sample,1);
bgs_mat = zeros(truncate_sample,1);
kv = 1;
kb = 1;

% for each audio file
% here we need to get the path of the audio file 

% for vocal
%filedir = testdir;

vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
%read in the vocalFileNames.mat
for j= 1:size(vocalFileNames.vocalsOnly,1)
    filedir = strcat(rootdir,vocalFileNames.vocalsOnly{j});
    audio_mat = audio2mat(filedir,true);
    number_truncate = floor(size(audio_mat,1)/truncate_sample);
    for i = 1:number_truncate
        %vocals_mat = [vocals_mat;audio_mat((i-1)*number_truncate+1:i*number_truncate,1)];
        %vocals_mat{:,kv} = audio_mat((i-1)*number_truncate+1:i*number_truncate,1);
        kv = kv+1;
    end
end

%read in the instFileNames.mat
for j= 1:size(instFileNames.instOnly,1)
    filedir = strcat(rootdir,instFileNames.instOnly{j});
    %here is for all the background for 1 
    audio_mat = audio2mat(filedir,true);
    number_truncate = floor(size(audio_mat,1)/truncate_sample);
    for i = 1:number_truncate
        %bgs_mat(:,kb) = audio_mat((i-1)*number_truncate+1:i*number_truncate,1);
        kb = kb+1;
    end
end

        


