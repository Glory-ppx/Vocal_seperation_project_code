%% here is the basic structure 
% for all the training data, we do the following preprocessing
% 1. read in both list
% 2. for the inst list, read in file one by one
% 3. do stft
% 4. use ODL to generate dictionary
% 5. for the vocal list, read in file one by one
% 6. do stft
% 7. use ODL to generate dictionary
clc,clear all
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
test_set = [15,34,47];

compress_rate = 1;
samplerate = 44100/compress_rate;%audio_info.SampleRate;
truncate_time = 6; %in secs
truncate_sample = samplerate*truncate_time;

dict_num = 30;
options.K = dict_num;  
options.niter_inversion = 100;
options.nbr_max_atoms = 5;

vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
l = 1;

%D_vocals = zeros(10000,dict_num*97);
D_vocals = [];
%% read in vocal files and learn dictionary for each vocal file
for j= 1:size(vocalFileNames.vocalsOnly,1)
    
    filedir = strcat(rootdir,vocalFileNames.vocalsOnly{j});
    %audio_mat = audio2mat(filedir,true);
    istest = false;
    for k = 1:size(test_set,2)
        if j == test_set(1,k)
            istest = true;
        end
    end
    if istest
        l = l+1;
    else
        audio_mat = ReadAudio(filedir,compress_rate);
        number_truncate = floor(size(audio_mat,1)/truncate_sample);
        % do stft here
%         for i = 1:number_truncate
%             [stft, f, t] = shorttft(x((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
%         end
        for i = 1:number_truncate
            [stft, f, t] = shorttft(audio_mat((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
            stft_result = abs(stft);
            [dict,~,~] = perform_dictionary_learning(stft_result,options);
            D_vocals = [D_vocals,dict];
        end
    end
    %D_vocals(:,(j-1)*dict_num+1:j*dict_num) = dict;
end

save(strcat(rootdir,'D_vocals_2.mat'),'D_vocals','-v7.3')
clear D_vocals

%% read in the instFileNames.mat
%D_inst = zeros(10000,dict_num*97*3);
D_inst=[];
l = 1;
for j= 1:size(instFileNames.instOnly,1)
    filedir = strcat(rootdir,instFileNames.instOnly{j});
    istest = false;
    for k = 1:size(test_set,2)
        te = ceil(j/3);
        if te == test_set(1,k)
            istest = true;
        end
    end
    if istest
        l = l+1;
    else
        audio_mat = ReadAudio(filedir,compress_rate);
        number_truncate = floor(size(audio_mat,1)/truncate_sample);
%         for i = 1:number_truncate
%             [stft, f, t] = shorttft(x((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
%         end
        for i = 1:number_truncate
            [stft, f, t] = shorttft(audio_mat((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
            stft_result = abs(stft);
            [dict,~,~] = perform_dictionary_learning(stft_result,options);
            D_inst = [D_inst,dict];
        end
        l=l+1;
    end
    %D_inst(:,(j-1)*dict_num+1:j*dict_num) = dict;
    l
end

%bgs_mat = bgs_mat(:,1:kb);
save(strcat(rootdir,'D_inst_2.mat'),'D_inst','-v7.3')
clear D_inst