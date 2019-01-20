function [ errorRate ,err ] = calcClassificationError( class1, class2, rowClass1, ...
                                        rowClass2, dataTotal , numberOfSampleTotalData)
%calcClassificationError : Calculation of classification error
% Calculates the error rate of classes and returns the error rate as output.

% class1 = class -1 data specified by bayes classifier 
% class2 = class -2 data specified by bayes classifier
% rowClass1 = Number of data belonging to class-1 (known from dataset)
% rowClass2 = Number of data belonging to class-2 (known from dataset)
% dataTotal = Total data sample (2xnumberOfSampleTotalData)
% numberOfSampleTotalData = number of total data sample
%

counter = 0;

[~,sizeOfClass1] = size(class1);
[~,sizeOfClass2] = size(class2);

for r=1:sizeOfClass1
    for y=1:rowClass1
        if(class1(:,r) == dataTotal(:,y))
            counter = counter+1;
        end
    end
end

for w=1:sizeOfClass2
    for q=1:(rowClass1+rowClass2)
        if(class2(:,w) == dataTotal(:,q))
            counter = counter+1;

        end
    end
end

err = counter;          % Number of accurately classified data 
errorRate = ((numberOfSampleTotalData - counter)/numberOfSampleTotalData) * 100;


end

