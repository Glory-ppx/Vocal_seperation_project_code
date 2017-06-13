function truncatedaudio = truncateAudio(audiovec, time,samplerate) 
    truncate_sample = samplerate*time;
    number_truncate = floor(size(audiovec,1)/truncate_sample);
    truncatedaudio = zeros(truncate_sample,number_truncate);
    for i = 1:number_truncate
        %vocals_mat = [vocals_mat;audio_mat((i-1)*number_truncate+1:i*number_truncate,1)];
        truncatedaudio(:,i) = audiovec((i-1)*truncate_sample+1:i*truncate_sample,1);
    end