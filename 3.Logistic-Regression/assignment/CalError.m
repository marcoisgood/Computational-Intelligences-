function [ClassificationEin, ClassificationEout, likehoodEout, likehoodEin] = CalError(G, Xtrain, Ytrain, Xtest, Ytest)


%Likelihood error out of the sample
AlikelihoodEout = 0 ;
for j = 1:1000
    
    tempA = Ytest(j)*(dot(G,Xtest(j,:)));

    AlikelihoodEout = AlikelihoodEout + log(1+exp(-tempA));
    
end

likehoodEout = AlikelihoodEout/1000;



%Likelihood error in of the sample
AlikelihoodEin = 0;

for k = 1:4000
    
    tempB = Ytrain(k)*(dot(G,Xtrain(k,:)));

    AlikelihoodEin = AlikelihoodEin + log(1+exp(-tempB));
    
end

likehoodEin = AlikelihoodEin/4000; 




%classification error

errors = 0;
for i = 1:4000
    s = dot(G,Xtrain(i,:));
    errors = errors + ((Ytrain(i) - s)^2);
end

ClassificationEin = errors / 8000;

errors = 0;

for i = 1:1000
    s = dot(G, Xtest(i,:));
    errors = errors + ((Ytest(i) - s)^2);
end


ClassificationEout = errors / 2000;



end