function audio_mix = mixChannels(audio_mat)
    temp_audio = audio_mat(:,1)+audio_mat(:,2);
    max_temp_audio=max(max(max(temp_audio)),max(abs(min(temp_audio))));%for normalization
    audio_mix = temp_audio./max_temp_audio;
end