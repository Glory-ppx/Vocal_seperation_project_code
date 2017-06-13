% for this, we need to read in the two dictionary matrix
% read in the mixed audio
% stft for the read in testing music and treated its abs as y, and get the phase
% matrix
% for every columns of y, we try to solve the L0 minization problem
% use the vocals dict and bgs dict to recover the vocals and bgs
% add the phase back for both
% istft to get the original sound

rootdir = 'D:\learn\CS591_CompressedSensing\project\data\';
vocaldict = 'D_vocals_3.mat';
bgdict1 = 'D_bg1_3.mat';
bgdict2 = 'D_bg2_3.mat';
bgdict3 = 'D_bg3_3.mat';
mixeddir1 = 'DSD100\Mixtures\Test\015 - Fergessen - The Wind\mixture.wav';
mixeddir2 = 'DSD100\Mixtures\Test\034 - Secretariat - Over The Top\mixture.wav';
mixeddir3 = 'DSD100\Mixtures\Test\047 - Voelund - Comfort Lives In Belief\mixture.wav';
sparsity = 20;
compress_rate=1;
samplerate = 44100;
num_sample = samplerate*5;
startind = samplerate*10;
endind = samplerate*25;
testmode=0;
if testmode == 1
    fprintf('test mode on!')
end

if exist('D','var') == 0
    vocalD = load(strcat(rootdir,vocaldict));
    bgD1 = load(strcat(rootdir,bgdict1));
    bgD2 = load(strcat(rootdir,bgdict2));
    bgD3 = load(strcat(rootdir,bgdict3));
%     vocalD = vocalD.D_vocals;
%     bgD1 = bgD1.D_inst;
%     bgD2 = bgD2.D_inst;
%     bgD3 = bgD3.D_inst;
    nfft = size(vocalD,1);
    colvocal = size(vocalD,2);
    colbg = 3*size(bgD1,2);
    D = [vocalD,bgD];
    clear vocalD bgD
end
filedir = strcat(rootdir,mixeddir1);
audio_mat = ReadAudio(filedir,compress_rate);
if testmode == 1
    audio_mat = audio_mat(num_sample:num_sample+samplerate,1);
else
    audio_mat = audio_mat(startind:endind,1);
end
[stft, f, t] = shorttft(audio_mat, samplerate);
stft_abs = abs(stft);
stft_phase = stft./stft_abs;
stft_phase(isnan(stft_phase))=0;
%try to solve the l0 problem for stft_abs as y and dictionary as A
col_s = size(stft_abs,2);
fprintf('columns to solve is %d',col_s)
vocal_recover=zeros(size(D,1),col_s);
inst_recover=zeros(size(D,1),col_s);

if testmode == 1
    diff = zeros(10,1);
    test_recover_record = [];
    col_s = 5;
end
for i = 1:col_s
    if testmode == 1
        tic
    end
    %temp = OMP_others(D,stft_abs(:,i),sparsity);
    temp = OMP_others(D,stft_abs(:,i),sparsity);
    if testmode == 1
        diff(i,1) = sum(sum((D*temp-stft_abs(:,i)).^2,1),2);
        test_recover_record = [test_recover_record,temp];
    end
    temp_vocal = D(:,1:colvocal)*temp(1:colvocal,1);
    temp_inst = D(:,colvocal+1:colvocal+colbg)*temp(colvocal+1:colvocal+colbg,1);
    vocal_recover(:,i) = temp_vocal;
    inst_recover(:,i) = temp_inst;
    if mod(i,100) == 0
        i/col_s    
    end
    if testmode == 1
        toc
    end
end
vocal_recover = vocal_recover.*stft_phase;
inst_recover = inst_recover.*stft_phase;
vocal_wav = inverse_stft(vocal_recover,samplerate);
inst_wav = inverse_stft(inst_recover,samplerate);
vocal_wav = vocal_wav';
inst_wav =  inst_wav';
tr_size = min(size(audio_mat,1),size(vocal_wav,1));
minus_v = audio_mat(1:tr_size,1)-inst_wav(1:tr_size,1);
minus_inst = audio_mat(1:tr_size,1)-vocal_wav(1:tr_size,1);
if testmode == 0
    %audiowrite(strcat(rootdir,'vocal15.wav'),'vocal_wav','-v7.3')
    %audiowrite(strcat(rootdir,'instrument15.wav'),'inst_wav','-v7.3')
    %audiowrite(strcat(rootdir,'minus_vocal15.wav'),'minus_v','-v7.3')
    %audiowrite(strcat(rootdir,'minus_instrument15.wav'),'minus_inst','-v7.3')
    audiowrite(strcat(rootdir,'vocal15.wav'),vocal_wav,samplerate)
    audiowrite(strcat(rootdir,'instrument15.wav'),inst_wav,samplerate)
    audiowrite(strcat(rootdir,'minus_vocal15.wav'),vocal_wav,samplerate)
    audiowrite(strcat(rootdir,'minus_instrument15.wav'),inst_wav,samplerate)
    
end
