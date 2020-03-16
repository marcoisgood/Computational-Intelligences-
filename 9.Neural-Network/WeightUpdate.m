function [layers]=WeightUpdate(eta, layers)

    
    num_layers = length(layers);

    for l = 2:num_layers
        layers(l).w = layers(l).w-(eta*layers(l).grad);
    end


end
