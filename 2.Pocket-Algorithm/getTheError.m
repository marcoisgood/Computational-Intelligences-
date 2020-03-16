function [error]=getTheError(W,X,Y,s)


    error = 0;
    for z = 1:s
        Y_hyp_test = sign(dot((W),X(z,:)));
        if Y(z) ~= Y_hyp_test
            error = error + 1;
        end
    end
    
    