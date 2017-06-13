test = load('D:\learn\CS591_CompressedSensing\project\data\test_audio.mat');

for i = 1:3
    y = test.test_audio{i}(:,1);
    x = test.test_audio{i}(:,1);
    t = [truncateAudio(y,30,44100/4),truncateAudio(x,30,44100/4)];
    test.test_audio{i} = t;
end
