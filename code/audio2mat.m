function [audiomat,samplerate,audio_info] = audio2mat(filedir,onechannel)
%% how to use
%input
%filedir: Type: String. The directory of the file
%onechannel: Type: Boolean. whether we only get the first channel of the 
%audiofile. If true, it only return a audio_length by 1 (l*1) matrix. 
%If false, it returns all the channels.

%output
%audiomat: Type:Double matrix. An m-by-n matrix, where m is the number of audio 
% samples read and n is the number of audio channels in the file.
%samplerate: Type: Int. In Hertz.
%audio_info : Type: Struct. Contain information of the files. For further
%information, type 'help audioinfo' in matlab's command window.

%example: [audiomat,~,~] = audio2mat(filedir,true)
    audio_info = audioinfo(filedir);
    [audiomat,samplerate] = audioread(filedir,'double');
    if onechannel
        audiomat = mixChannels(audiomat);
    end
end