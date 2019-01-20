function [ covariance ] = calcCovariance( Nk, wik, data, mean, ... 
                                            numberOfSample, numberOfGauss)
% Covariance is calculated using EM

covariance =zeros(2,2,numberOfGauss);

for k=1:numberOfGauss    
    sumOfFirstExpression=0;  
    for i=1: numberOfSample
 
        sumOfFirstExpression = sumOfFirstExpression + wik(k,i) * ...
                                    (data(:,i)-mean(:,k)) * (data(:,i)-mean(:,k))'; 
    end
    
    covariance(:,:,k) = sumOfFirstExpression / Nk(k);
    
end

end

