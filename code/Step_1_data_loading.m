clear all
close all
clc

data = csvimport('./D1_fixed_front.csv');
dataM = cell2mat(data(2:end,:));
D1_fix = dataM;

data = csvimport('./D1_ill_front.csv');
dataM = cell2mat(data(2:end,:));
D1_ill = dataM;

data = csvimport('./D4_fixed_bite.csv');
dataM = cell2mat(data(2:end,:));
D4_fix = dataM;

data = csvimport('./D4_ill_front.csv');
dataM = cell2mat(data(2:end,:));
D4_ill = dataM;

save('D_data.mat','D1_ill','D1_fix','D4_ill','D4_fix');
return;
%%
data = csvimport('./sda.csv');
dataM = cell2mat(data(2:end,:));
sample = dataM;
size(find(sample(:,6) < 10))
