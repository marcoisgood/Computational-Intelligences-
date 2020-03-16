function [Erros, Ein, Eout,lr, layers] = steepestD(xtrain, xtest, ytrain, ytest, layers)


    
    [M,~] = size(xtrain);
    [N,~] = size(xtest);
    
   
    t = 0;
    prevError = -1;
    errorSimilarity = 0;
    Erros = zeros(1000,1);
    Ein = 0;
    Eout = 0;
    num_layers = length(layers);
    
    while errorSimilarity < 20 && t < 100
                t = t+1;
        %do forward propagation
        layers(1).x = xtrain(t,:)';
        y = ytrain(t);
        [FPoutput, layers] = ForwardPropagation(layers);
        
        %calculate the error 
        temp2 = ((1/2)*((FPoutput - y)^2));
        Erros(t) = temp2;
        
        %do back-propagation 
    	[layers] = backPropagation(layers,y);
        
        
        %line search for finding the learning rate
        [lr] = LineSearch(layers, y);
        %disp("lr: " + lr);
        
        %update weight vector
        for l = 2:num_layers
            layers(l).w = layers(l).w-(lr*layers(l).grad);
        end
        
     
        
        %calculate the error of in sample
        error = 0;
        for i = 1:M
             %do Forward Propagation
              layers(1).x = xtrain(i,:)';
              y = ytrain(i);
              [FPoutput,layers] = ForwardPropagation(layers);
              %calculate the error in average
              temp = ((1/(2*M))*((FPoutput - y)^2));
              error = error + temp;
        end
    
            Ein = error;
    
        %calculate the error of out sample
        error = 0;
        for j = 1:N
             %do Forward Propagation
              layers(1).x = xtest(j,:)';
              y = ytest(j);
              [FPoutput,layers] = ForwardPropagation(layers);
              %calculate the error in average
              temp = ((1/(2*N))*((FPoutput - y)^2));
              error = error + temp;
        end
    
            Eout= error;
            Erros(t)=Eout;
        % Determine if algorithm should stop
        if abs(error - prevError) < 0.01
            errorSimilarity = errorSimilarity + 1;
        else
            errorSimilarity = 0;
        end
            prevError = error;  
            
    end    
   Ein = Ein/t;
   Eout = Eout/t;
end






