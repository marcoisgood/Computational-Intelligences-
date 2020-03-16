function [Ein] = errorMeasure(layers, target)

    [output,~] = ForwardPropagation(layers);
    Ein = ((1/2)*((output - target)^2));

    
end


