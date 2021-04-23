function [ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = eventDetection( rawSig, noiseSig, windowSize, sigmaSize )

    % Author: Shijia Pan
    % This function extract the impulsive signals against Gaussian noise
    % Inputs:
    %     rawSig: entire investigated signal segments
    %     noiseSig: sample ambient noise signal segments without any excitation
    
    
    if nargin < 3
        windowSize = 150;
    end
    
    if nargin < 4
        sigmaSize = 6;
    end
    
    % fixed system parameters
    WIN1=windowSize/2;
    WIN2=windowSize/2;
    offSet = windowSize/2;
    eventSize = WIN1+WIN2;
    
    % inferred parameters and align signals
    channelSize = min(size(rawSig));
    if size(rawSig,1) == channelSize
        rawSig = rawSig';
        noiseSig = noiseSig';
    end
    
    states = 0;
    windowEnergyArray = [];
    windowDataEnergyArray = [];
    stepEventsSig = [];
    stepEventsIdx = [];
    stepEventsVal = [];
    noiseRange = [];
    stepPeak = 1;
    stepStartIdxArray = [];
    stepStopIdxArray = [];
    
    idx = 1;
    while idx < length(noiseSig) - max(windowSize, eventSize) - 10
         windowData = noiseSig(idx:idx+windowSize-1,:);
         % calculate the sliding window signal energy as the sum of all the
         % channels
         windowDataEnergy = 0;
         for channelID = 1:channelSize
             channelData = windowData(:,channelID);
             channelData = channelData - mean(channelData);
             windowDataEnergy =+ sum(channelData.*channelData);
         end
         windowDataEnergyArray = [windowDataEnergyArray windowDataEnergy];
         idx = idx + offSet; 
    end
    [noiseMu,noiseSigma] = normfit(windowDataEnergyArray);
    
    idx = 1;
    windowEnergyArray = [];
    signal = rawSig;
    
    while idx < length(signal) - 2 * max(windowSize, eventSize)
        % if one sensor detected, we count all sensor detected it
        windowData = signal(idx:idx+windowSize-1,:);
        % calculate the sliding window signal energy as the sum of all the
         % channels
         windowDataEnergy = 0;
         for channelID = 1:channelSize
             channelData = windowData(:,channelID);
             channelData = channelData - mean(channelData);
             windowDataEnergy =+ sum(channelData.*channelData);
         end
         windowEnergyArray = [windowEnergyArray; windowDataEnergy idx];
        
        % gaussian fit
        if abs(windowDataEnergy - noiseMu) < noiseSigma * sigmaSize

            if states == 1 && idx < length(signal) - eventSize
                % find the event peak as well as the event
                stepEnd = idx;
                stepRange = rawSig(stepStart:stepEnd);
                [localPeakValue, localPeak] = max(abs(stepRange));
                stepPeak = stepStart + localPeak - 1;

                % extract clear signal
                stepStartIdx = max(stepPeak - WIN1, stepStart);
                stepStopIdx = stepStartIdx + eventSize - 1;
                stepSig = rawSig(stepStartIdx:stepStopIdx);
                stepStartIdxArray = [stepStartIdxArray, stepStartIdx];
                stepStopIdxArray = [stepStopIdxArray, stepStopIdx];

                % save the signal
                if size(stepSig,2) == 1
                    stepEventsSig = [stepEventsSig; stepSig'];
                else
                    stepEventsSig = [stepEventsSig; stepSig];
                end
                stepEventsIdx = [stepEventsIdx; stepPeak];
                stepEventsVal = [stepEventsVal; localPeakValue];

                % move the index to skip the event
                idx = stepStopIdx - offSet;
            end
            states = 0;
        else
            % mark step
            if states == 0 && idx - stepPeak > WIN1
                stepStart = idx; 
                states = 1;
            end
        end  
        
        idx = idx + offSet;
    end
    % unfinished Step
    if states == 1
        stepEnd = length(signal);
        stepRange = rawSig(stepStart:stepEnd);
        [localPeakValue, localPeak] = max(abs(stepRange));
        stepPeak = stepStart + localPeak - 1;


        % extract clear signal
        stepStartIdx = max(stepPeak - WIN1, stepStart);
        stepStopIdx = stepStartIdx + eventSize - 1;
        stepSig = rawSig(stepStartIdx:stepStopIdx);
        stepStartIdxArray = [stepStartIdxArray, stepStartIdx];
        stepStopIdxArray = [stepStopIdxArray, stepStopIdx];

        % save the signal
        if size(stepSig,2) == 1
            stepEventsSig = [stepEventsSig; stepSig'];
        else
            stepEventsSig = [stepEventsSig; stepSig];
        end
        stepEventsIdx = [stepEventsIdx; stepPeak];
        stepEventsVal = [stepEventsVal; localPeakValue];

    end
end

