function [Errout,Errin,w] = validation(w, xtest, ytest, xtrain, ytrain)

        %for errorout
        Errout = 0;
    for k = 1:500
        
        tempErrorout = (( ytest(k) - ( sign( dot( w,xtest(k,:)))))^2) /2;
        Errout = tempErrorout + Errout;
    end 
        Errout = Errout/500;

        %for errorin
        Errin = 0;
    for m = 1:4499
        
        tempErrorin = (( ytrain(m) - ( sign( dot( w,xtrain(m,:)))))^2) /2;
        Errin = tempErrorin + Errin;
    end 
        Errin = Errin/4499;




end