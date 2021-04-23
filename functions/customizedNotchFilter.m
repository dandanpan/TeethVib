function [filt_sig] = customizedNotchFilter(signal, Fs, noiseFreq)
%CUSTOMIZED_FILTER to remove 60Hz and resonance at 180, 300

%     filt_sig = signal;
    for i = 1:length(noiseFreq)
        wo = noiseFreq(i)/(Fs/2);  
        bw = wo/8;
        [b,a] = iirnotch(wo,bw);
        filt_sig = filtfilt(b,a,signal);
    end

%     wo = 114/(Fs/2);  
%     bw = wo/10;
%     [b,a] = iirnotch(wo,bw);
%     filt_sig = filtfilt(b,a,filt_sig);
    
%     wo = 180/(Fs/2);  
%     bw = wo/30;
%     [b,a] = iirnotch(wo,bw);
%     filt_sig = filtfilt(b,a,filt_sig);
% 
%     wo = 300/(Fs/2);  
%     bw = wo/90;
%     [b,a] = iirnotch(wo,bw);
%     filt_sig = filtfilt(b,a,filt_sig);
%     
%     wo = 340/(Fs/2);  
%     bw = wo/90;
%     [b,a] = iirnotch(wo,bw);
%     filt_sig = filtfilt(b,a,filt_sig);
end

