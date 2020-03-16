
for p=1:2

    if p==1
        %first time: 10 points training set and 100 points test set
        N=[10,100];
    else 
        %second time: 100 points training set and 1000 points test set
        N=[100,1000];
    end

    %target function
    targetFLine = 2*rand(1,2)-1;
    
    
    figure(p);

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
            W = -1 +2*rand(3,1);
            W(1,:) = 0;

            xl = min(X(:,2)):0.1:max(X(:,2));
            yl = -(W(2)*xl+W(1))/W(3);

            % plot initial hypothesis line
            plot(xl,yl,'Color',[.8 .8 .8],'LineStyle','--','LineWidth',2);
            y_hyp = zeros(n,1);
         %   
          for m = 1:n
            y_hyp(m) = sign(dot((W),X(m,:)));
          end

          for l = 1:10*n
            if all(y_hyp(:) == Y(:))
                plot(xl,yl,'color','blue','linewidth',1);
                break
            else
                v=find(y_hyp~=Y);
                W=W+Y(v(1))*X(v(1),:)';
                yl = -(W(2)*xl+W(1))/W(3);
            for o = 1:n
                y_hyp(o) = sign(dot((W),X(o,:)));
            end
            end
           
          end
        
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

    fprintf('In %d points test set, \n the number of error points is %d \n',n,count);
end

