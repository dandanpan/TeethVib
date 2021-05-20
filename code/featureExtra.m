function [sigFreqFeature,sigSimilarity,sigEnergy] = featureExtra(sigSet, validInd, Fs)
    % sigSet is detected events
    % validInd is the selected events

    stepStartIdxArray = sigSet.stepStartIdxArray(validInd);
    stepStopIdxArray = sigSet.stepStopIdxArray(validInd);
    sig = sigSet.data-mean(sigSet.data);
    
%     figure;
%     plot(sig(:,1)); hold on;
%     plot(sig(:,2)); hold on;
%     plot(sig(:,3)); hold on;
%     plot(sig(:,4)); hold on;
%     for i = 1:length(stepStartIdxArray)
%         plot([stepStartIdxArray(i), stepStartIdxArray(i)],[-500,500],'g');
%         plot([stepStopIdxArray(i), stepStopIdxArray(i)],[-500,500],'r');
%     end
    
    sigFreqFeature = [];
    sigSimilarity = [];
    sigEnergy = [];

    for eventID = 1:length(stepStartIdxArray)

        eventSig = sig(stepStartIdxArray(eventID):stepStopIdxArray(eventID),:);
        eventFeature = [];  
        energyFeature = [];
        eventSimilarity = [];
        for channelID = 1:size(sig,2)
            freqFeature = signalFreqencyExtract(eventSig(:,channelID),Fs)';
            timeFeature = [std(eventSig(:,channelID)), max(eventSig(:,channelID)), min(eventSig(:,channelID))];
            energyFeature = [energyFeature, sum(eventSig(:,channelID).*eventSig(:,channelID))];
            eventFeature = [eventFeature, freqFeature];
            for compareChannel = channelID+1:size(sig,2)
                eventSimilarity = [eventSimilarity, signalSimilarity(eventSig(:,channelID),eventSig(:,compareChannel))];
            end
        end


        sigFreqFeature = [sigFreqFeature; eventFeature];
        sigEnergy = [sigEnergy; energyFeature];
        sigSimilarity = [sigSimilarity; eventSimilarity];
    end

%     figure;
%     plot(sigEnergy(:,1));hold on;
%     plot(sigEnergy(:,2));hold on;
%     plot(sigEnergy(:,3));hold on;
%     plot(sigEnergy(:,4));hold off;
    

end

