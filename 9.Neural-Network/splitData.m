function [xtrain, xtest, ytrain, ytest] = splitData(X,Y,j)
    

    [M,~] = size(X);
    
    m = round(rand(1,1)*4)+1;
    
    a = (m-1)*round(M*0.2)+1;
    b = m*round(M*0.2);
    if b == 4000
        b = 3999;
    end
    
    temparray = [X,Y];
    
    temparrayTest = temparray(a:b,:);
    
    temparraytrain = setdiff(temparray,temparrayTest,'rows');
    
    
    xtest = temparrayTest(:,1:2);
    ytest = temparrayTest(:,3);
    
    xtrain = temparraytrain(:,1:2);
    ytrain = temparraytrain(:,3);
    
    [n,~] = size(xtest);  
    xtest = [ones(n,1),xtest];  
    
    [m,~] = size(xtrain);  
    xtrain = [ones(m,1),xtrain];  

end 
