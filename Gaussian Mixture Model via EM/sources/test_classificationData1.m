clc,
clearvars,
close all;

%%%
% Author : Ýsmail can Büyüktepe
% Date: 10.01.2019
% Institute : Gebze Technical University
% E-mail: ismailcanbuyuktepe@gmail.com

% Brief: In the data set ClassificationData1, there are feature vectors of 
% two different classes. There are 2000 attribute vectors for each class. 
% Assume that the attribute vectors are suitable for the Gauss-mix model.
% Using the following code, the GMM parameters were first calculated by 
% the EM algorithm.
% In this process, the data set is divided into two parts as test and 
% training set.In the training set, the first 1800 were taken from 2000 
% data for both classes.The training was performed with 3600 data and the 
% parameters were calculated for each class. The classification was then 
% carried out. It was tested on 400 data using the parameters calculated 
% by training data and calculated the classification success rate.

folderName = '..\handlers';                             % Don't change
folderNameOfFunctions = '..\handlers\functions';        % Don't change
folderNameOfDataSets = '..\handlers\datasets';          % Don't change
    
addpath(folderName , folderNameOfFunctions , folderNameOfDataSets);

dataSet = load('ClassificationData1.mat');

%%
% The distribution of class-1 and class-2 data is shown and the number of
% gauss was determined.

subplot(2,1,1),
plot(dataSet.class1_data(1,1:1800),dataSet.class1_data(2,1:1800),'.','Color','red');
title('Distribution of class-1 data'),
xlabel('x1'); ylabel('y1');

subplot(2,1,2);
plot(dataSet.class2_data(1,1:1800),dataSet.class2_data(2,1:1800),'.','Color','blue');
title('Distribution of class-2 data'),
xlabel('x2'); ylabel('y2');

%% Values of initial parameters are determined for class-1.
dataTranspose =dataSet.class1_data(:,1:1800)';
weight=[1/3,1/3,1/3];

covariance(:,:,1)=[1,0;0,1];
covariance(:,:,2)=[1,0;0,1];
covariance(:,:,3)=[1,0;0,1];

mu_y_init = (max(dataTranspose(:,2))+ min(dataTranspose(:,2)))/2;

mu_x1_init = max(dataTranspose(:,1))/4 + 3*min(dataTranspose(:,1))/4;
mu_x2_init = 2*max(dataTranspose(:,1))/4 + 2*min(dataTranspose(:,1))/4;
mu_x3_init = 3*max(dataTranspose(:,1))/4 + 1*min(dataTranspose(:,1))/4;
meanClass1=[ mu_x1_init, mu_x2_init ,mu_x3_init ; mu_y_init, mu_y_init, mu_y_init  ];

[rowClass1,columnClass1]=size(dataTranspose);
numberOfGaussForClass1 =3;

%%  Values of initial parameters are determined for class-1.
dataTransposeForClass2 = dataSet.class2_data(:,1:1800)';

weight2 =[1/2,1/2];

covariance2(:,:,1)=[1,0;0,1];
covariance2(:,:,2)=[1,0;0,1];

mu2_y_init=(max(dataTransposeForClass2(:,2))+min(dataTransposeForClass2(:,2)))/2;
mu2_x1_init = max(dataTransposeForClass2(:,1))/2 + 3*min(dataTransposeForClass2(:,1))/2;
mu2_x2_init = 2*max(dataTransposeForClass2(:,1))/2 + 2*min(dataTransposeForClass2(:,1))/2;
meanClass2 =[mu2_x1_init,mu2_x2_init; mu2_y_init,mu2_y_init ];

[rowClass2,columnClass2]=size(dataTransposeForClass2);
numberOfGaussForClass2 =2;

%% EM algorithm is started for datas of class-1 and class2

numberOfIteration=50;

for i=1:numberOfIteration
    
 [pdfValuesOfEachGaussOfClass1] = pdfOfGauss(dataSet.class1_data(:,1:1800), rowClass1, ...
                                           numberOfGaussForClass1, meanClass1, ...
                                           covariance);
 [pdfValuesOfEachGaussOfClass2] = pdfOfGauss(dataSet.class2_data(:,1:1800), rowClass2, ...
                                           numberOfGaussForClass2, meanClass2, ...
                                           covariance2);
 [wik_Class1] = calcWik(numberOfGaussForClass1, rowClass1, weight, pdfValuesOfEachGaussOfClass1);
 
 [wik_Class2] = calcWik(numberOfGaussForClass2, rowClass2, weight2, pdfValuesOfEachGaussOfClass2);
 
 [Nk_Class1] = calcNk(rowClass1, numberOfGaussForClass1, wik_Class1);
 
 [Nk_Class2] = calcNk(rowClass2, numberOfGaussForClass2, wik_Class2);
 
 [meanClass1] = calcMean(rowClass1, columnClass1, numberOfGaussForClass1, ...
                         Nk_Class1, wik_Class1, dataSet.class1_data(:,1:1800));
 [meanClass2] = calcMean(rowClass2, columnClass2, numberOfGaussForClass2, ...
                         Nk_Class2, wik_Class2, dataSet.class2_data(:,1:1800));
 
 [weight] = calcWeight(Nk_Class1, rowClass1, numberOfGaussForClass1);
 
 [weight2] = calcWeight(Nk_Class2, rowClass2, numberOfGaussForClass2);
 
 [covariance] = calcCovariance(Nk_Class1, wik_Class1, dataSet.class1_data(:,1:1800), ...
                            meanClass1, rowClass1, numberOfGaussForClass1 );
 [covariance2] = calcCovariance(Nk_Class2, wik_Class2, dataSet.class2_data(:,1:1800), ...
                            meanClass2, rowClass2, numberOfGaussForClass2);      
end

%% We calculate the discriminant function values of the classes we model as GMM.(For Training )

dataTotal=[dataSet.class1_data(:,1:1800),dataSet.class2_data(:,1:1800)];
[rowTotalData,~] =  size(dataTotal');

pdfWithNewParamForClass1 = pdfOfGauss(dataTotal, rowTotalData, numberOfGaussForClass1, meanClass1...
                                        ,covariance);
pdfWithNewParamForClass2 = pdfOfGauss(dataTotal, rowTotalData, numberOfGaussForClass2, meanClass2...
                                      ,covariance2);

discriminantVectorForClass1 =calcDiscriminant(numberOfGaussForClass1, rowTotalData, weight, ...
                                               pdfWithNewParamForClass1);
discriminantVectorForClass2 =calcDiscriminant(numberOfGaussForClass2, rowTotalData, weight2, ...
                                               pdfWithNewParamForClass2);

figure(2),hold on,
[class1 , class2] = bayesClassifier(discriminantVectorForClass1, discriminantVectorForClass2, ...
                                    rowTotalData , dataTotal);
title('Training result.'),
xlabel('x point'), ylabel('y label'),

%% Calculate the success rate of the training set

[errRateForTraining, err]=calcClassificationError(class1, class2, rowClass1, rowClass2, dataTotal, ...
                                              rowTotalData);

%% Testing
% To calculate the discriminant function values of test
% data and to determine success rate of the test set

testData = [dataSet.class1_data(:,1801:2000), dataSet.class2_data(:,1801:2000)];
[numberOfSampleForTestData,~]= size(testData');

pdfTestDataForClass1 = pdfOfGauss(testData, numberOfSampleForTestData, numberOfGaussForClass1, ...
                                        meanClass1, covariance);

                                
pdfTestDataForClass2 = pdfOfGauss(testData, numberOfSampleForTestData, numberOfGaussForClass2, ...
                                  meanClass2, covariance2 );

discVecForTestClass1 =calcDiscriminant(numberOfGaussForClass1, numberOfSampleForTestData, weight, ...
                                               pdfTestDataForClass1);
discVecForTestClass2 =calcDiscriminant(numberOfGaussForClass2, numberOfSampleForTestData, weight2, ...
                                               pdfTestDataForClass2);

figure(3), hold on,

[tClass1 , tClass2]= bayesClassifier(discVecForTestClass1, discVecForTestClass2, ...
                                     numberOfSampleForTestData, testData);
title('Test result'),
xlabel('x point'), ylabel('y label'),                               
                                
%% Calculate the success rate of the training set

[errRateForTest, errTest]=calcClassificationError(tClass1, tClass2, 200, 200, testData, ...
                                              numberOfSampleForTestData);
