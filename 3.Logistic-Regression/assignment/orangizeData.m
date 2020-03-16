function [Xtrain,Ytrain, Xtest, Ytest] = orangizeData(X,Y)


Xtrain = zeros(4000,3);
Xtrain(:,1) = 1;

Ytrain = zeros(4000,1);

Xtest = zeros(1000,3);
Ytest = zeros(1000,1);

index = 1;

for i = 0:9
    for j= 1:400
        p =randi([(i*500+1),(i+1)*500],1,1);
        Xtrain(index,2:3) = X(p,:);
        if Y(p) == 1
        Ytrain(index,:)= 1;
        else
        Ytrain(index,:)= -1;   
        end 
        index = index+1;
    end    
end

indexT = 1;
for i = 0:9
    for j = 1:100
        q = randi([(i*500+1),(i+1)*500],1,1);
        Xtest(indexT,2:3) = X(q,:);
        if Y(q) == 1
            Ytest(indexT)= 1;
        else
            Ytest(indexT)= -1; 
        end
        indexT = indexT+1;
    end
end
    