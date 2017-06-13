
rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
test_set = [15,34,47];
vocalFileNames = load('vocalFileNames.mat');


compress_rate = 4;
truncate_time = 30; %in secs
samplerate = 44100/compress_rate;%audio_info.SampleRate;
truncate_sample = samplerate*truncate_time;


filedir{1} = 'D:\learn\CS591_CompressedSensing\project\data\DSD100\Mixtures\Test\015 - Fergessen - The Wind\mixture.wav';
filedir{2} = 'D:\learn\CS591_CompressedSensing\project\data\DSD100\Mixtures\Test\034 - Secretariat - Over The Top\mixture.wav';
filedir{3} = 'D:\learn\CS591_CompressedSensing\project\data\DSD100\Mixtures\Test\047 - Voelund - Comfort Lives In Belief\mixture.wav';

for i=1:3
    mixture = ReadAudio(filedir{i},compress_rate);
    vocal_dir{i} = strcat(rootdir,vocalFileNames.vocalsOnly{test_set(i)});
    vocal = ReadAudio(vocal_dir{i},compress_rate);
    test_audio{i} = [mixture vocal];
end
test_audio{size(test_set,2)+1} = filedir;
test_audio{size(test_set,2)+2} = vocal_dir;