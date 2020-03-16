clc; clear;

       
    N=[100,10000];
    

    %target function
    targetFLine = 2*rand(1,2)-1;
    
 
    %generate the data set and plot data points
    for i=1:2
        [X,Y]=generate(N(i),targetFLine);
   
    
        n = size(X,1);
        hold on;
    
        for j = 1:n
            if Y(j) == 1
                scatter(X(j,2),X(j,3),'r','+','LineWidth',2);
            else
                scatter(X(j,2),X(j,3),'g','o','LineWidth',2);
            end
        end    
    
    
    axis([-1 1 -1 1]);
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    count=0;

            %find the G line
        if i==1
            W = -1 +2*rand(1,3);
            W(:,1) = 0;

            xl = min(X(:,2)):0.1:max(X(:,2));
            yl = -(W(2)*xl+W(1))/W(3);

            % plot initial hypothesis line
            plot(xl,yl,'Color',[.8 .8 .8],'LineStyle','--','LineWidth',2);
            y_hyp = zeros(n,1);
         %   
         
          for l = 1:1000
              k = randi([1,100],1,1);
              
              
            if Y(k)*dot((W),X(k,:))<=1
                t=X(k,:);
                W=W+100*(Y(k)-dot((W),X(k,:)))*t;
                
            
           end
          end
        
           yl = -(W(2)*xl+W(1))/W(3);
           %plot(xl,yl,'color','blue','linewidth',1);

        else
            y_hyp_test = zeros(n,1);
            for k = 1:n
                y_hyp_test(k) = sign(dot((W),X(k,:)));
                if Y(k) ~= y_hyp_test(k)
                    count= count+1;
                end
         
            end
        end
        
    end
    
    plot(xl,yl,'color','black','linewidth',2);
    fprintf('In %d points test set, \n the number of error points is %d \n',n,count);
 

