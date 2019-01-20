function [ Nk ] = calcNk( numberOfSample, numberOfGauss, wik )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

Nk=zeros(1,numberOfGauss);

for k=1:numberOfGauss 
    for i=1:numberOfSample
        Nk(k)=Nk(k)+ wik(k,i);
    end
end

