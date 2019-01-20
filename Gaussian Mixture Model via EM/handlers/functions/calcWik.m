function [ wik ] = calcWik( numberOfGauss, numbOfSample ,weightOfEachGauss , pdf )
    
%   numberOfGauss = number of gauss for according to your data distribution 
%   numberOfData = number of data point
%   weightOfEachGauss 
%   pdf= PDF values for each gauss according to the current parameters
%        (mean(t) , sigma(t) , weight(t))    
%


wik = zeros(numberOfGauss, numbOfSample);

for i=1:numbOfSample
    for k=1:numberOfGauss
       wik(k,i)= weightOfEachGauss(k)*pdf(k,i); 
    end
wik(:,i)=wik(:,i) / sum(wik(:,i));
end

