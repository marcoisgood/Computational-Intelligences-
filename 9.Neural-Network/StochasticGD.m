function [Errors, Ein, Eout, lr, layers] = StochasticGD(xtrain, xtest, ytrain, ytest, layers)

    
    iter=1;
    previousEout = -1;
    Ein = 0.3;
    errorSimilarity = 0;
    Errors = zeros(10,1);
    
while errorSimilarity < 20 && iter < 100 && Ein >= 0.2
    %calculate the gradient
    i = randi([1 3999],1);
    
    %do Forward Propagation
    layers(1).x = xtrain(i,:)';
    y = ytrain(i);
    [FPoutput,layers] = ForwardPropagation(layers);
    
    Ein = 0;
    %calculate the error 
    temp2 = ((1/2)*((FPoutput - y)^2));
    Ein = Ein + temp2;
    Errors(iter) = Ein;
    
    %do back-propagation 
    [layers] = backPropagation(layers,y);
    
    %validation to find the best parameter
    [lr] = ValidationforlearningRate(layers,xtrain,ytrain);

    %update weight vector
    [layers] = WeightUpdate(lr,layers);
    
    %calculate the error
    error = 0;
    
    [M,~] = size(xtest);
    for j = 1:M
        %do Forward Propagation
            layers(1).x = xtest(j,:)';
            y = ytest(j);
            [FPoutput,layers] = ForwardPropagation(layers);
            %calculate the error in average
            temp = ((1/(2*M))*((FPoutput - y)^2));
            error = error + temp;
    end
    
    Eout = error;
 
    
       
    %stopping criteria
    
    if abs(Eout - previousEout) <  0.001
        errorSimilarity = errorSimilarity + 1;
    else
        errorSimilarity = 0;
    end
    
    previousEout = Eout;
    
    iter = iter + 1;
    
    
   
 
    
end

   %disp("Stochastic Gradient completed in: " + iter);

end
