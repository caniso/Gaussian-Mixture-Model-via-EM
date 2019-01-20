function [  ] = showEachGauss( wik )

%  This function shows the GMM components whose parameters are estimated 
%  using the EM algorithm.
%  If there is more or less gauss in your model, the index value must be
%  added and plotted.

   figure(2),hold on
   title('EM algorithm result for GMM')
   xlabel('x'),ylabel('y'),

    for i=1:row
        [max_value , index] = max(wik(:,i));
        
        if index ==1
            plot(data(1,i),data(2,i),'.','Color','red')
        end
            
        if index ==2
            plot(data(1,i),data(2,i),'.','Color','blue')
        end
        
        if index ==3
            plot(data(1,i),data(2,i),'.','Color','green')
        end
    end


end

