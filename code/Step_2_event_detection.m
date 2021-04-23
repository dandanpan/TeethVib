close all;
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Hardware: Arduino Zero, new sensors %
%  Software: Sampling rate 2.2k        %
%  With articulator                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('D_data.mat');
addpath('../functions');

sig = D1_ill(:,2:5);
Fs = 2200;
% normalize the sensor to zero mean
figure;
for channelID = 1:4
    sig(:,channelID) = sig(:,channelID) -  mean(sig(:,channelID));
%     [ Y, f, NFFT] = signalFreqencyExtract( sig(:,channelID), Fs );
%     figure;plot(f,Y);
       
    [sig(:,channelID)] = customizedNotchFilter(sig(:,channelID), Fs, 57);
    plot(sig(:,channelID));hold on;
end
hold off;


% extract noise signal
noiseSig = sig(1:5000,:);

[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = eventDetection( sig, noiseSig, 200, 3 );

figure;
for i = 1:size(sig,2)
    plot(sig(:,i)-mean(sig(:,i)));hold on;
end

for excitationID = 1:length(stepStartIdxArray)
    plot([stepStartIdxArray(excitationID), stepStartIdxArray(excitationID)],[-500,500],'r');
    plot([stepStopIdxArray(excitationID), stepStopIdxArray(excitationID)],[-500,500],'g');
end

D1_ill_event.stepStartIdxArray = stepStartIdxArray;
D1_ill_event.stepStopIdxArray = stepStopIdxArray;
D1_ill_event.data = sig;
save('D1_ill_event.mat','');





return;



feature = [];
sigEnergy = [];
label = [];

for eventID = 1:length(stepStartIdxArray)-1
    
    eventSig = sig(stepStartIdxArray(eventID):stepStopIdxArray(eventID),:);
    eventFeature = [];  
    energyFeature = [];
    for channelID = 1:size(sig,2)
        freqFeature = signalFreqencyExtract(eventSig(:,channelID),Fs)';
        timeFeature = [std(eventSig(:,channelID)), max(eventSig(:,channelID)), min(eventSig(:,channelID))];
        energyFeature = [energyFeature, sum(eventSig(:,channelID).*eventSig(:,channelID))];
        eventFeature = [eventFeature, freqFeature];
    end
    
    feature = [feature; eventFeature];
    sigEnergy = [sigEnergy; energyFeature]
    
end

figure;
plot(sigEnergy(:,1));hold on;
plot(sigEnergy(:,2));hold on;
plot(sigEnergy(:,3));hold on;
plot(sigEnergy(:,4));hold off;
