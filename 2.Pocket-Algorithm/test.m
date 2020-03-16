load("assignment2/usps_modified.mat");
[x,y] = getfeatures(data);

%get the number one and five
[X,Y] = getOneToFive(x,y);


%train set N=50 & 200
N=[50,200];

%initial value
b = randi([1,1000],1,1);
errorinsampleA=0;
errorinsampleB=0;
literationCountA=0;
literationCountB=0;
erroroutsampleA = 0;
erroroutsampleB = 0;

%test 1000 times
for a=1:1000
    
    %initial hypothesis line
    w = -1 +2*rand(1,3);
    w(:,1) = 0;
    xl = min(X(:,2)):0.1:max(X(:,2));
    yl = -(w(2)*xl+w(1))/w(3);
    
        
    %1 for N=50, 2 for N=200
    for n=1:2
    
        Ytrainset = zeros(N(n),1);
        Xtrainset = zeros(N(n),3);
        W=w;
        
       %depend on the number of data to create trainset
        for m=1:N(n)
            k = randi([1,1000],1,1);        
            Xtrainset(m,:)= X(k,:);
            Ytrainset(m) = Y(k);        
        end
        
        
        countliter = 0;
        WTNEW = zeros(1,3);
        countErrorinsample = 0;
        s = size(Xtrainset,1);
        t=0;
      
        %test in t times
        while t<300
             t=t+1;
             
             %cal the Error of W
             

             for x = 1:s
                 Y_hyp_test = sign(dot((W),Xtrainset(x,:)));
                if Ytrainset(x) ~= Y_hyp_test
                    countErrorinsample = countErrorinsample + 1;
                end
             end
             
             ErrorInputW = countErrorinsample/s;
             
             K = randi([1,s],1,1);
             
             %cal the new weight
             
             if (Ytrainset(K)*dot((W),Xtrainset(K,:)))<=0
                 WTNEW=W+Ytrainset(K)*Xtrainset(K,:);
                 
                 %cal the Error of W(t+1)
                 
                 
                 for z = 1:s
                    Y_hyp_test = sign(dot((WTNEW),Xtrainset(z,:)));
                    if Ytrainset(z) ~= Y_hyp_test
                       countErrorT1 = countErrorT1 + 1;
                   end
                 end
                 
                 
                 
                 if (countErrorT1 < countErrorinsample)
                    W = WTNEW;
                    countliter = countliter+1;
          
                 end
                 
             end
             
        end
        
        
        
        if a == b
            figure(n);
            hold on;
    
            for j = 1:s
                if Ytrainset(j) == 1
                    scatter(Xtrainset(j,2),Xtrainset(j,3),'r','+','LineWidth',2);
                else
                    scatter(Xtrainset(j,2),Xtrainset(j,3),'g','o','LineWidth',2);
                end
            end    
    
    
            axis([-1 1 -1 1]);
            xlabel('x_1'); ylabel('x_2');
            ax = gca;
            ax.XAxisLocation = 'origin';
            ax.YAxisLocation = 'origin';
    
            %plot initial hypothesis line
            plot(xl,yl,'Color',[.8 .8 .8],'LineStyle','--','LineWidth',4);
            xl = min(Xtrainset(:,2)):0.1:max(Xtrainset(:,2));
            yl = -(W(2)*xl+W(1))/W(3);
            plot(xl,yl,'color','blue','linewidth',2);
        end
        
        %cal the out of the sample
        countErrorOutsample = 0;

        for x = 1:1000
            Y_hyp_test = sign(dot((W),X(x,:)));
              if Y(x) ~= Y_hyp_test
                 countErrorOutsample = countErrorOutsample + 1;
              end  
        end
            ErrorOutSample = countErrorOutsample;
        
        
        if n == 1
           erroroutsampleA = erroroutsampleA + ErrorOutSample;
           errorinsampleA = ErrorInputW + errorinsampleA;
           literationCountA = countliter + literationCountA;
        elseif n ==2
           erroroutsampleB = erroroutsampleB + ErrorOutSample;
           errorinsampleB = ErrorInputW + errorinsampleB;
           literationCountB = countliter + literationCountB;

        end
       
            
    end
    
end
EoutA = round(erroroutsampleA/1000);
EoutB = round(erroroutsampleB/1000);
EinA = errorinsampleA/1000;
EinB = errorinsampleB/1000;
literA = round(literationCountA/1000);
literB = round(literationCountB/1000);
fprintf('In average,\nThe literation with \n 50 points is %d \n 200 points is %d \nThe error in sample \n with 50 points is %d\n with 200 points is %d\nThe error out of sample \n with 50 points training is %d\n with 200 points training is %d\n  ',literA,literB,round(EinA),round(EinB),EoutA,EoutB);


                 

             
             

             
             
             
             
                 
             
             

        
        


