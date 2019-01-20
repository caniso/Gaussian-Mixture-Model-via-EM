function [ pdfEstimationForEachGauss ] = pdfOfGauss( dataset, numberOfSample, numberOfGauss, ...
                                                        meanMatrix, covariance )

 pdfEstimationForEachGauss = zeros(numberOfGauss , numberOfSample);
 
 for k=1:numberOfGauss
    for i=1:numberOfSample
        pdfEstimationForEachGauss(k,i)=exp(-1/2*(dataset(:,i)-meanMatrix(:,k))'...
                                      * inv(covariance(:,:,k))* (dataset(:,i)-meanMatrix(:,k)));
    end
    pdfEstimationForEachGauss(k,:) = pdfEstimationForEachGauss(k,:) / det(covariance(:,:,k)^(1/2));
 end
 
 pdfEstimationForEachGauss = pdfEstimationForEachGauss * (1/(2*pi));
 

end

