clc,
clearvars,
close all;

%%%
% Author : Ýsmail can Büyüktepe
% Date: 10.01.2019
% Institute : Gebze Technical University
% E-mail: ismailcanbuyuktepe@gmail.com
%
% In first part of this work , The given data sets are assumed to be 
% suitable for the gauss mixture model. We will do implementation of EM 
% algorithm (Expectation Maximization). GMM parameters estimation will make
% using EM algorithm.
%
% My e-mail address for your questions or suggestions is in the document.


folderName = '..\handlers';                             % Don't change
folderNameOfFunctions = '..\handlers\functions';        % Don't change
folderNameOfDataSets = '..\handlers\datasets';          % Don't change
    
addpath(folderName , folderNameOfFunctions , folderNameOfDataSets);

dataset = load('synthData1.mat');

data= dataset.data;
dataTranspose = data';

[row , column] = size(dataTranspose);

figure(1),
plot(data(1,:) , data(2,:) , '.', 'Color' , 'blue');
title('Overview of distribution data');
xlabel('x');
ylabel('y');

%% first step: 
%  Initialize parameters of Gaussian distribution for t=0;

numberOfGauss = 3;                           % you can see from figure(1).

% Parameters is initialized for EM algorithm.
weightOfGauss=[1/3 , 1/3 , 1/3];

mean_x1 = max(dataTranspose(:,1))/4 + 3*min(dataTranspose(:,1))/4;
mean_x2 = 2*max(dataTranspose(:,1))/4 + 2*min(dataTranspose(:,1))/4;
mean_x3 = 3*max(dataTranspose(:,1))/4 + min(dataTranspose(:,1))/4;
mean_y = max(dataTranspose(:,2))/2 + min(dataTranspose(:,2))/2;

meanMatrix = [mean_x1 , mean_x2 , mean_x3 ; mean_y , mean_y , mean_y];

cov(:,:,1)=[1, 0 ; 0, 1];
cov(:,:,2)=[1, 0 ; 0, 1];
cov(:,:,3)=[1, 0 ; 0, 1];

iterationNumber=70;

%% EM algorithm is started.

for i=1:iterationNumber
    
   [pdfValuesOfEachGauss] = pdfOfGauss(data, row, numberOfGauss, meanMatrix, cov);
    
   [wik] =calcWik(numberOfGauss , row , weightOfGauss, pdfValuesOfEachGauss);
   
   [Nk]=calcNk(row, numberOfGauss, wik);
   
   [meanMatrix] = calcMean(row, column, numberOfGauss, Nk, wik, data);
   
   [weightOfGauss] = calcWeight( Nk, row, numberOfGauss);
   
   [cov] = calcCovariance(Nk, wik, data, meanMatrix, row, numberOfGauss);
     
end

%% Each Gauss Distribution is shown in different colors.

figure(2),hold on
title('EM algorithm result for GMM')
xlabel('x'),ylabel('y'),

    for i=1:row
        [max_value , index] = max(wik(:,i));
        
        if index ==1
            plot(data(1,i),data(2,i),'.','Color','red')
        end
            
        if index ==2
            plot(data(1,i),data(2,i),'.','Color','blue')
        end
        
        if index ==3
            plot(data(1,i),data(2,i),'.','Color','green')
        end
    end


