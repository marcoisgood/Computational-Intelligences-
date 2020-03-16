function [FPoutput,layers] = ForwardPropagation(layers)

    theta = @(x) 1./(1+exp(-1*x));     
    num_layers = length(layers);  
    
    for l = 2:num_layers
        layers(l).s = layers(l).w'*layers(l-1).x;       %calculate signal
        layers(l).x = vertcat(1,theta(layers(l).s)); 
    end
    
        FPoutput = layers(3).x(2);
    
  
end