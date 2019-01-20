function [ class1 , class2 ] = bayesClassifier(discriminantValueForClass1, ... 
                            discriminantValueForClass2 , numberOfTotalData ,dataTotal)
%bayesClassifier : Classifier function.
% Discriminant function was used and classification was made.
% The results are plotted.

class1 = [];
class2 = [];

for i=1 : numberOfTotalData
    if(discriminantValueForClass1(1,i) > discriminantValueForClass2(1,i))
        plot(dataTotal(1,i),dataTotal(2,i),'.','Color','red');
        class1=[class1,dataTotal(:,i)];
        
    end
    if(discriminantValueForClass2(1,i) > discriminantValueForClass1(1,i))
        plot(dataTotal(1,i),dataTotal(2,i),'x','Color','blue');
        class2 = [class2,dataTotal(:,i)];
    end   
end

legend('Class:One' , 'Class:Two')

end

