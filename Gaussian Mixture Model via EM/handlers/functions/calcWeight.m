function [ weight ] = calcWeight( Nk , numberOfSample , numberOfGauss )
%UNT�TLED2 Summary of this function goes here
%   Detailed explanation goes here

weight= zeros(1, numberOfGauss);

for k=1: numberOfGauss
    weight(k)= Nk(k)/numberOfSample;
end

end

