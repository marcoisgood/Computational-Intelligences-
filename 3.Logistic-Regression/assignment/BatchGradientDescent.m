function  [BG]= BatchGradientDescent(Xtrain, Ytrain, Xtest, Ytest, learnRate)


% initial weight
w = rand(1,3);



iter=1;
previousError = -1;
errorSimilarity = 0;
threshold = 60 ;
grad = zeros(1,3);
limitation = 0; %for endless loop, when the value up to 1000, it stops

%error is similar in last 60 times
while errorSimilarity < threshold
    
   
    limitation = limitation + 1;
     
    
    %calculate the gradient
    for i = 1:4000
        grad = grad + gradientSignal(w, Xtrain(i,:), Ytrain(i));

    end

    vector = -grad/4000;

    %update weight vector
    w = w + learnRate*vector;
    
    %calculate the error
    errors = 0;
    for i = 1:1000
        signaltest = dot(w,Xtest(i,:));
        targetY = Ytest(i);
        errors = errors + ((signaltest - targetY)^2);
    end
    error = errors/1000;
   
    %if error and previous error similar.
    if abs(error - previousError)<10
        errorSimilarity = errorSimilarity + 1;
    else
        errorSimilarity = 0;
    end
    
    
    if limitation == 1000
       break
    end
    iter = iter +1;
    previousError = error;
end


fprintf("Batch gradient descent completed in: %d \n", iter);
BG = w;

end
