function plotfigures(d, X, Y ,learnRate)


    figure(d);
    hold on;
       
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    if d ==1
        T = ['The graph of Batch Gradient Descent with learning rate: ', num2str(learnRate)];
    else
        T = ['The graph of Stocjastic Gradient Descent with learning rate: ', num2str(learnRate)];
     
    end
    title(T);
    
    
    
   
        
        for i = 1:1000
            if Y(i) == 1
                scatter(X(i,2),X(i,3),'r','+','LineWidth',2);
            else
                scatter(X(i,2),X(i,3),'g','o','LineWidth',2);
            end
        end

end