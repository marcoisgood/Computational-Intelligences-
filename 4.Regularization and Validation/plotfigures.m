function plotfigures(w,Xdata,Y,z)

    figure();
    hold on;
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    [n,~] = size(z); 
    z = [ones(n,1),z];          %add z0 of 1's

     for i = 1:5000
            
           Y_hypothsis = sign( dot( w,z(i,:)));
                %if the digit is 1 and with right of classifcation,
                % the color is blue
            if Y(i) == Y_hypothsis && Y(i) == 1
                scatter(Xdata(i,1),Xdata(i,2),'b','o','LineWidth',1);
                %if the digit is 0,2,3,4,5,6,7,8,9 and with right of
                %classification, the color is green
            elseif Y(i) == Y_hypothsis && Y(i) == -1
                scatter(Xdata(i,1),Xdata(i,2),'g','o','LineWidth',1);
                %The points which is misclassfication is red.
            else 
                scatter(Xdata(i,1),Xdata(i,2),'r','+','LineWidth',1);
            end
            
            
      end

end 