function [feature, sigEnergy] = eventFreqFeatureExtraction(eventArray, Fs)
    % Input: a data structure with time series data, and event index array
    % Output: event freq features, event signal energy
    
    sig = eventArray.data;
    stepStartIdxArray = eventArray.stepStartIdxArray;
    stepStopIdxArray = eventArray.stepStopIdxArray;

    feature = [];
    sigEnergy = [];

    for eventID = 1:length(stepStartIdxArray)-1

        eventSig = sig(stepStartIdxArray(eventID):stepStopIdxArray(eventID),:);
        eventFeature = [];  
        energyFeature = [];
        for channelID = 1:size(sig,2)
            freqFeature = signalFreqencyExtract(eventSig(:,channelID),Fs)';
            energyFeature = [energyFeature, sum(eventSig(:,channelID).*eventSig(:,channelID))];
            eventFeature = [eventFeature, freqFeature];
        end

        feature = [feature; eventFeature];
        sigEnergy = [sigEnergy; energyFeature]

    end


end

