clear;
close all;
clc;

Fs = 2200;
addpath('../functions/');

load('../data/D4_fix_event.mat');
load('../data/D4_ill_event.mat');

[feature1, sigEnergy1] = eventFreqFeatureExtraction(D4_fix_event, Fs);
[feature2, sigEnergy2] = eventFreqFeatureExtraction(D4_ill_event, Fs);
species = [ones(19,1);zeros(18,1)];

Y = tsne([feature1;feature2]);
figure;
gscatter(Y(:,1),Y(:,2),species);


