function plotDataPoint(layers,x,y)
    

   
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    [n,~] = size(x);           %add z0 of 1's 
    x = [ones(n,1),x];  
    
     for i = 1:n
                %flag = true;
            %do forward Propagation
                layers(1).x = x(i,:)';
                Y = y(i);
                [FPoutput, ~] = ForwardPropagation(layers);
                Y_hyp = round(FPoutput);
                
          
                
              %if (0.1 < error)  ||  (0.09 > error) 
              %    flag = true;
              %else
              %    flag = false;
              %end
                
                %if the digit is 1 and with right of classifcation,
                % the color is blue
            if  Y_hyp == 1 && Y == 1
                scatter(x(i,2),x(i,3),8,'b','filled');
                %if the digit is 0,2,3,4,5,6,7,8,9 and with right of
                %classification, the color is green
            elseif Y_hyp == 0 && Y == 0
                scatter(x(i,2),x(i,3),8,'g','filled');
                %The points which is misclassfication is red.
            else 
                scatter(x(i,2),x(i,3),8,'r','filled');
            end
            
            
     end
       

end