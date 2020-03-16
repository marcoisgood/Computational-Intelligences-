function grad= gradientSignal(W, X, Y)

    y = (Y*dot(W,X));
   
    logisticFuntion = 1/(1+exp(y));

    grad = -(Y*X*logisticFuntion);

end
    
    
    

