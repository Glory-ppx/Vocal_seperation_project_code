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

compress_rate = 2;
samplerate = 44100/compress_rate;%audio_info.SampleRate;
truncate_time = 3; %in secs
truncate_sample = samplerate*truncate_time;

dict_num = 3000;
options.K = dict_num;  
options.niter_inversion = 500;
options.nbr_max_atoms = 10;

vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
l = 1;
stft_result = [];
tic
%% read in vocal files and learn dictionary for each vocal file
for j= 1:floor(size(vocalFileNames.vocalsOnly,1)/2)  
    
    filedir = strcat(rootdir,vocalFileNames.vocalsOnly{j});
    istest = false;
    for k = 1:size(test_set,2)
        if j == test_set(1,k)
            istest = true;
        end
    end
    if istest
        l = l+1;
    else
        if mod(k,3)==1
            audio_mat = ReadAudio(filedir,compress_rate);
            number_truncate = floor(size(audio_mat,1)/truncate_sample);
            % do stft here
    %         for i = 1:number_truncate
    %             [stft, f, t] = shorttft(x((i-1)*truncate_sample+1:i*truncate_sample,1), samplerate);
    %         end
            %for i = 1:number_truncate
                [stft, f, t] = shorttft(audio_mat, samplerate);
                k = mod([1:size(stft,2)],4);
                stft = abs(stft(:,k==0));
                stft_result = [stft_result,stft];
            %end
        end
    %D_vocals(:,(j-1)*dict_num+1:j*dict_num) = dict;
    end
end
[D_vocals,~,~] = perform_dictionary_learning(stft_result,options);
save(strcat(rootdir,'D_vocals_3.mat'),'D_vocals','-v7.3')
clear D_vocals
toc
