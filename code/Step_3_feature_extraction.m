clear;
close all;
clc;

Fs = 2200;
% similarity 12,13,14,23,24,34

%% D1 fix
load('../data-CHASE/D1_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D1Fix] = featureExtra(D1_fix_event, [1:10], Fs);
title('D1_fix');
mean(sigSimilarity)
%% D1 ill
load('../data-CHASE/D1_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D1Ill] = featureExtra(D1_ill_event, [1:10], Fs);
title('D1_ill');
mean(sigSimilarity)
%% D2 fix
load('../data-CHASE/D2_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D2Fix] = featureExtra(D2_fix_event, [1:10], Fs);
title('D2_fix');
% check
mean(sigSimilarity)
%% D2 ill
load('../data-CHASE/D2_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D1Ill] = featureExtra(D2_ill_event, [1:5,7:11], Fs);
title('D2_ill');
mean(sigSimilarity)
%% D3 fix
load('../data-CHASE/D3_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D3Fix] = featureExtra(D3_fix_event, [1:10], Fs);
title('D3_fix');
mean(sigSimilarity)
%% D3 ill
load('../data-CHASE/D3_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D3Ill] = featureExtra(D3_ill_event, [1:10], Fs);
title('D3_ill');
mean(sigSimilarity)
%% D4 fix
load('../data-CHASE/D4_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D4Fix] = featureExtra(D4_fix_event, [5:14], Fs);
title('D4_fix');
mean(sigSimilarity)
%% D4 ill
load('../data-CHASE/D4_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D4Ill] = featureExtra(D4_ill_event, [1:10], Fs);
title('D4_ill');
mean(sigSimilarity)

%% D5 fix
load('../data-CHASE/D5_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D5Fix] = featureExtra(D5_fix_event, [15:24], Fs);
title('D5_fix');
mean(sigSimilarity)
%% D4 ill
load('../data-CHASE/D5_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_D5Ill] = featureExtra(D5_ill_event, [1:10], Fs);
title('D5_ill');

%% N1 fix
load('../data-CHASE/N1_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N1Fix] = featureExtra(N1_fix_event, [1:4,10:12,16,18,19], Fs);
title('N1_fix');
mean(sigSimilarity)
%% N1 ill
load('../data-CHASE/N1_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N1Ill] = featureExtra(N1_ill_event, [1:10], Fs);
title('N1_ill');
mean(sigSimilarity)
%% N2 fix
load('../data-CHASE/N2_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N2Fix] = featureExtra(N2_fix_event, [1:10], Fs);
mean(sigSimilarity)
%% N2 ill
load('../data-CHASE/N2_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N2Ill] = featureExtra(N2_ill_event, [1:10], Fs);
mean(sigSimilarity)
% one caine not contacting
%% N4 fix
load('../data-CHASE/N4_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N4Fix] = featureExtra(N4_fix_event, [1:10], Fs);
mean(sigSimilarity)
%% N4 ill
load('../data-CHASE/N4_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N4Ill] = featureExtra(N4_ill_event, [1:10], Fs);
mean(sigSimilarity)
% check the teeth
% doesn't change is good
% ideal model
%% N5 fix
load('../data-CHASE/N5_fix_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N5Fix] = featureExtra(N5_fix_event, [1:10], Fs);
title('N5_fix');
mean(sigSimilarity)
%% N5 ill
load('../data-CHASE/N5_ill_event.mat');
[sigFreqFeature,sigSimilarity,sigEnergy_N5Ill] = featureExtra(N5_ill_event, [1:10], Fs);
title('N5_ill');
mean(sigSimilarity)

%% plot sigEnergy comparison

sigEnergy_D1Ill_Norm = loadDistribution(sigEnergy_D1Ill);
sigEnergy_D1Fix_Norm = loadDistribution(sigEnergy_D1Fix);
sigEnergy_D3Ill_Norm = loadDistribution(sigEnergy_D3Ill);
sigEnergy_D3Fix_Norm = loadDistribution(sigEnergy_D3Fix);
sigEnergy_D4Ill_Norm = loadDistribution(sigEnergy_D4Ill);
sigEnergy_D4Fix_Norm = loadDistribution(sigEnergy_D4Fix);
sigEnergy_N1Ill_Norm = loadDistribution(sigEnergy_N1Ill);
sigEnergy_N1Fix_Norm = loadDistribution(sigEnergy_N1Fix);
sigEnergy_N2Ill_Norm = loadDistribution(sigEnergy_N2Ill);
sigEnergy_N2Fix_Norm = loadDistribution(sigEnergy_N2Fix);
sigEnergy_N4Ill_Norm = loadDistribution(sigEnergy_N4Ill);
sigEnergy_N4Fix_Norm = loadDistribution(sigEnergy_N4Fix);

meanVals = [mean(sigEnergy_D1Ill_Norm); ...
            mean(sigEnergy_D1Fix_Norm); ...
            mean(sigEnergy_D3Ill_Norm); ...
            mean(sigEnergy_D3Fix_Norm); ...
            mean(sigEnergy_D4Ill_Norm); ...
            mean(sigEnergy_D4Fix_Norm); ...
            mean(sigEnergy_N1Ill_Norm); ...
            mean(sigEnergy_N1Fix_Norm); ...
            mean(sigEnergy_N2Ill_Norm); ...
            mean(sigEnergy_N2Fix_Norm); ...
            mean(sigEnergy_N4Ill_Norm); ...
            mean(sigEnergy_N4Fix_Norm); ...
            ];
        
stdVals = [std(sigEnergy_D1Ill_Norm); ...
            std(sigEnergy_D1Fix_Norm); ...
            std(sigEnergy_D3Ill_Norm); ...
            std(sigEnergy_D3Fix_Norm); ...
            std(sigEnergy_D4Ill_Norm); ...
            std(sigEnergy_D4Fix_Norm); ...
            std(sigEnergy_N1Ill_Norm); ...
            std(sigEnergy_N1Fix_Norm); ...
            std(sigEnergy_N2Ill_Norm); ...
            std(sigEnergy_N2Fix_Norm); ...
            std(sigEnergy_N4Ill_Norm); ...
            std(sigEnergy_N4Fix_Norm); ...
            ];

figure;
subplot(2,2,1);
boxplot(sigEnergy_D3Ill_Norm); ylim([0,1.5]);title('(a) Disease1 Real Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');
subplot(2,2,3);
boxplot(sigEnergy_D3Fix_Norm); ylim([0,1.5]);title('(b) Disease1 Ideal Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');

% figure;
subplot(2,2,2);
boxplot(sigEnergy_D4Ill_Norm); ylim([0,1.5]);title('(c) Disease2 Real Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');
subplot(2,2,4);
boxplot(sigEnergy_D4Fix_Norm); ylim([0,1.5]);title('(d) Disease2 Ideal Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');

figure;
subplot(2,2,1);
boxplot(sigEnergy_N1Ill_Norm); ylim([0,1.5]);title('(a) NonDisease1 Real Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');
subplot(2,2,3);
boxplot(sigEnergy_N1Fix_Norm); ylim([0,1.5]);title('(b) NonDisease1 Ideal Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');

% figure;
subplot(2,2,2);
boxplot(sigEnergy_N4Ill_Norm); ylim([0,1.5]); title('(c) NonDisease2 Real Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');
subplot(2,2,4);
boxplot(sigEnergy_N4Fix_Norm); ylim([0,1.5]); title('(d) NonDisease2 Ideal Fitting');xlabel('Teeth Position');ylabel('Relative Bite Load');