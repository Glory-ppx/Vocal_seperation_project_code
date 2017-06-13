function [result,f,t] = shorttft(X_t,fs)
    wlen = 2048;%1024;%2048;
    h = 2048/4;%1024/4;%2048/4;
    nfft = 1024;
    [result, f, t] = stft(X_t, wlen, h, nfft, fs);
end