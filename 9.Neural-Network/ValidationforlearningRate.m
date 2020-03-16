function [lr] = ValidationforlearningRate(layers,x,y)

    learningRate = [0.1, 0.25, 0.5, 0.75, 1];
    compareArray = zeros(5,3);
    num_layers = length(layers);
    
    
    for i = 1:5 %each learning rate
        lr = learningRate(i);
        Ein = 0;
        Eout = 0;
        for j=1:10 % 10 times validation
            Eintemp = 0;
            Eouttemp = 0;
            
            
            % 20% for test 80% for train
           [Xtrain, Xtest, Ytrain, Ytest] = splitData(x,y); 
           [k,~] = size(Xtrain);
           [N,~] = size(Xtest);
           
           for l=1:k
               layers(1).x = Xtrain(i,:)';
               yi = Ytrain(i);
               %calculate the error in average
               [FPoutput,layers] = ForwardPropagation(layers);
               temp2 = ((1/(2*k))*((FPoutput - yi)^2));
               Eintemp = Eintemp + temp2;
                  
               %do back-propagation 
               [layers] = backPropagation(layers,yi);
                
                %calculate the gradient in average
                for lay = 2:num_layers  
            
                    if l == 1
                        layers(lay).gradinavrage = (1/k)*layers(lay).grad;   
                    else
                        layers(lay).gradinavrage = layers(lay).gradinavrage + (1/k)*layers(lay).grad;    
                    end
                end
           end
            
            lr = learningRate(i);
            [layers] = WeightUpdate(lr,layers);
            
             %calculation of Eout to compare which learning is the best
            for o = 1:N
           
                %do Forward Propagation
                layers(1).x = Xtest(j,:)';
                yi = Ytest(j);
                [FPoutput,layers] = ForwardPropagation(layers);
                %calculate the error in average
                temp = ((1/(2*N))*((FPoutput - yi)^2));
                Eouttemp = Eouttemp + temp;
                
            end
            
            Ein = Ein + Eintemp;
            Eout = Eout + Eouttemp;
            
            
        end
            Ein = Ein/10;
            Eout = Eout/10;
            compareArray(i,1) = lr;
            compareArray(i,2) = Ein;
            compareArray(i,3) = Eout;   
        
    end 

            [~,I] = min(compareArray(:,3));
            %disp("The minimum Error out of sample is: " + M + "%");
            %disp("The Error in of sample is: " + compareArray(I,2) + "%");
            %disp("The best learning rate is: " + compareArray(I,1));
            lr = compareArray(I,1);



end