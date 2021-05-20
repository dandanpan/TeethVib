function [sigEnergyNorm] = loadDistribution(sigEnergy)
    % The function normalize the signal energy based on the minimum one
    % and returns the ratio of the profile
    % sigEnergy is a NxM matrix where N events for M sensor is reported
    
    
    meanVals = mean(sigEnergy); % mean for each sensor
    [mm,mi] = max(meanVals);
    sigEnergyNorm = sigEnergy./mm; %sigEnergy(:,mi);
end

