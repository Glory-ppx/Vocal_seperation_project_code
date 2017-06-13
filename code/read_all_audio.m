function audio_mat_all = read_all_audio(folderdir,audiolength)
%% what it is
% it is use for getting one audio matrix from all audio in a folder

%% how to use
%input
%folderdir: String. Don't end with '/'!
%audiolength: the number of samples you want to truncate the audio so that
%all of them can be fit in one matrix. 

%output
%audio_mat_all: m*n matrix, with m is the length of each audio vector, n is
%the number of audio in that folder.
    Files=dir(folderdir+'/*.*');
    audio_mat_all = zeros(audiolength,length(Files));
    for k=1:length(Files)
       FileNames=Files(k).name;
       [audiomat,~,~] = audio2mat(folderdir+'/'+FileNames,true);
       audio_mat_all(:,k) = audiomat(1:audiolength,1);
    end
end