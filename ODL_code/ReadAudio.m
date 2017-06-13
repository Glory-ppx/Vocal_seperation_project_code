function [ M,Fs ] = ReadAudio( file_dir , k )
%READAUDIO Summary of this function goes here
%   Detailed explanation goes here
% the function to transform audio to vector with compression and merging 2
% channels
% inputs :
% file_dir : the direction of the audio file
% k : the compression rate, e.g. k=2 compress to the size of one half
% suggestion for choice of k, k=2 or k=4
% s : the window size of truncation. e.g. s = 1000 gives you the output
% vector length 1000

% output:
% M : the output matrix, each column correspond to a piece of the audio
% signal window. note that the number of columns is variable
% Fs : the sampling rate after compression

% read in the audio
[y,Fs] = audioread(file_dir);

% merge two channels
y = y(:,1)+y(:,2);
y = y./2;

%compression
ii = length(y)/k;
idex = 1:ii;
idex = idex.*k;
yy = y(idex,:);
Fs = Fs/k;

M = yy;
%M = [];

% truncate
% while 1
%     M = [M,yy(1:s)];
%     yy(1:s)=[];
%     if length(yy)<s
%         break
%     end 
% end

end

