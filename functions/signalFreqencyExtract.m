function [ Y, f, NFFT] = signalFreqencyExtract( sig, Fs )

        sig = sig./sqrt(sum(sig.*sig));
        L = length(sig);
        NFFT = 2^nextpow2(L); % Next power of 2 from length of y
        
        Y = fft(sig,NFFT)/L;
        Y = 2*abs(Y(1:NFFT/2+1));
        f = Fs/2*linspace(0,1,NFFT/2+1);
end

