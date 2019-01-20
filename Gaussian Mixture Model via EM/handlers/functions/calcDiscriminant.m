function [ discriminantVector ] = calcDiscriminant( numberOfGauss , numberOfSample, weight, ...
                                                    pdfValueOfEachGauss)
% 

discriminantMatrix = zeros (numberOfGauss , numberOfSample);

for k=1:numberOfGauss
   discriminantMatrix (k,:) = weight(k)*pdfValueOfEachGauss(k,:); 
end

discriminantVector=sum(discriminantMatrix);


end

