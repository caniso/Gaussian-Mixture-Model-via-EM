function [ mean ] = calcMean( numberOfSample, numberOfFeature, numberOfGauss, Nk, wik, data )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

mean= zeros(numberOfFeature , numberOfGauss);

    for k=1:numberOfGauss
        sumOfFirstExpression = 0;
       for i=1:numberOfSample
           sumOfFirstExpression= sumOfFirstExpression + wik(k,i)*data(:,i);
       end
       mean(:,k)= sumOfFirstExpression/Nk(k);
    end

end

