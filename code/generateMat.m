
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
test_set = [15,34,47];
%2364,784
%% Truncate and Transform
compress_rate = 4;
 truncate_time = 30; %in secs
 samplerate = 44100/compress_rate;%audio_info.SampleRate;
 truncate_sample = samplerate*truncate_time;


vocals_mat = zeros(truncate_sample,770); %770%791
bgs_mat = zeros(truncate_sample,2308); %2265%2371

kv = 1;
kb = 1;

% for each audio file
% here we need to get the path of the audio file 

% for vocal
%filedir = testdir;

vocalFileNames = load('vocalFileNames.mat');
instFileNames = load('instFileNames.mat');
%read in the vocalFileNames.mat
vocaltest = cell(size(test_set,2),1);
bgstest = cell(3*size(test_set,2),1);
l = 1;
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
        vocaltest{l,1}=filedir;
        l = l+1;
    else
        audio_mat = ReadAudio(filedir,compress_rate);
        number_truncate = floor(size(audio_mat,1)/truncate_sample);
        for i = 1:number_truncate
            %vocals_mat = [vocals_mat;audio_mat((i-1)*number_truncate+1:i*number_truncate,1)];
            vocals_mat(:,kv) = audio_mat((i-1)*truncate_sample+1:i*truncate_sample,1);
            kv = kv+1;
        end
    end
end

%vocals_mat = vocals_mat(:,1:kv);
save(strcat(rootdir,'vocals_mat.mat'),'vocals_mat','-v7.3')
clear vocals_mat
l = 1;

%read in the instFileNames.mat
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
        bgstest{l,1}=filedir;
        l = l+1;
    else
    %here is for all the background for 1 
    %audio_mat = audio2mat(filedir,true);
        audio_mat = ReadAudio(filedir,compress_rate);
        number_truncate = floor(size(audio_mat,1)/truncate_sample);
        for i = 1:number_truncate
            bgs_mat(:,kb) = audio_mat((i-1)*truncate_sample+1:i*truncate_sample,1);
            kb = kb+1;
        end
    end
end

%bgs_mat = bgs_mat(:,1:kb);
save(strcat(rootdir,'bgs_mat.mat'),'bgs_mat','-v7.3')
clear bgs_mat
