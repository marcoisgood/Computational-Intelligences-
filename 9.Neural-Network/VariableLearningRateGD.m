 function [Erros, Ein,Eout,lr, layers] = VariableLearningRateGD(xtrain, xtest, ytrain, ytest, layers)

    
    [M,~] = size(xtrain);
    [N,~] = size(xtest);
    
    a = 1.08; % 1.05<= a <= 1.1
    b = 0.7; % .5 <= b <= .8
    t = 0;
    prevError = -1;
    errorSimilarity = 0;
    lr = 0.1;
    Erros = zeros(100,1);
    num_layers = length(layers);
    Ein = 0;
    Eout = 0;
    while errorSimilarity < 20 && t < 100
               t = t+1;

        %do forward propagation
        layers(1).x = xtrain(t,:)';
        y = ytrain(t);
        [FPoutput, layers] = ForwardPropagation(layers);
        
        %calculate the error 
        temp2 = ((1/2)*((FPoutput - y)^2));
        EinPrev = temp2;
        
        %do back-propagation 
    	[layers] = backPropagation(layers,y);
        
        %copy the old weight
        for l = 2:num_layers
            layers(l).wPrev = layers(l).w;
        end
        
        %update weight vector
        for l = 2:num_layers
            layers(l).w = layers(l).w-(lr*layers(l).grad);
        end
        
        %calculate the error 
        [FPoutput, layers] = ForwardPropagation(layers);
        temp2 = ((1/2)*((FPoutput - y)^2));
        EinNew = temp2;
        
        
         if EinNew < EinPrev
             
               lr = a*lr;
               %Erros(t) = EinNew;
         else 
               lr = b*lr;
               %copy prev weight back 
                for l = 2:num_layers
                    layers(l).w = layers(l).wPrev;
                end
               %Erros(t) = EinPrev;
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
        
            Ein = Ein + error;
        
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
        Erros(t) = error;

        Eout = Eout + error;
    
   
    
        % Determine if algorithm should stop
        if abs(error - prevError) < 0.05
            errorSimilarity = errorSimilarity + 1;
        else
            errorSimilarity = 0;
        end
            prevError = error;  
    end    
    Ein = Ein/t;
    Eout = Eout/t;
 end