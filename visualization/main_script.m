clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath('npy-matlab');
addpath('lsd_1.6');
addpath(genpath(pwd));


%% common setting to read Stray Scanner recording data

%
datasetPath = '../renaissance_plaza_scan/';
frameIndex =  831;





