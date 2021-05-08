clear;
close all;
clc;

Fs = 2200;
addpath('../functions/');

load('../data/D5_fix_event.mat');
load('../data/D5_ill_event.mat');
load('../data/D4_fix_event.mat');
load('../data/D4_ill_event.mat');


[feature1, sigEnergy1] = eventFreqFeatureExtraction(D4_fix_event, Fs);
[feature2, sigEnergy2] = eventFreqFeatureExtraction(D4_ill_event, Fs);
[feature3, sigEnergy3] = eventFreqFeatureExtraction(D5_fix_event, Fs);
[feature4, sigEnergy4] = eventFreqFeatureExtraction(D5_ill_event, Fs);
species = [ones(size(feature1,1),1);...
            ones(size(feature2,1),1).*2;...
            ones(size(feature3,1),1).*1;...
            ones(size(feature4,1),1).*2];

opts = statset('MaxIter',10000);
Y = tsne([feature1;feature2;feature3;feature4],'Options',opts);
figure;
gscatter(Y(:,1),Y(:,2),species,'br','xo');


