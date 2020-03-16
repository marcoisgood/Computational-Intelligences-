function  [G]= StochasticGradientDecent(Xtrain, Ytrain, learnRate)

w = -1 + 2*rand(1,3);
w(:,1) = 0;

run = true;
iter=1;
previousGradient = 0;


while run
    %calculate the gradient
    i = randi([1 4000],1);
    
    if iter > 1
        previousGradient = grad;
    end
    
    grad = gradientSignal(w, Xtrain(i,:), Ytrain(i));
    
    %update weight vector
    w = w - learnRate*grad;
    iter = iter +1;
    %calculate the error
   
    %stopping criteria: gradient is smaller than 0.01
    run = norm(grad) < 0.01 ;
    % or if error hasn't changed significantly, stop it.
    if round(grad, 5) == round(previousGradient, 5)
       run = false;
    end
    
end


fprintf("Stochastic Gradient descent completed in: %d \n", iter);
G = w;

end
