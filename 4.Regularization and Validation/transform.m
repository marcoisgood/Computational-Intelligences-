function [Z] = transform(X)
% a 3rd order polynomial set.
% Z = (x_1,x_2,x_1^2,x_1x_2,x_2^2,x_1^3,x_1^2x_2,x_1x_2^2,x_2^3)
    
    Z = zeros(5000, 9);

    for i = 1:5000
        for j = 1:9
            switch j
                case {1}
                    Z(i,j) = X(i,1);
                case {2}
                    Z(i,j) = X(i,2);
                case {3}
                    Z(i,j) = (X(i,1))^2;
                case {4}
                    Z(i,j) = X(i,1)*X(i,2);
                case {5}
                    Z(i,j) = (X(i,2))^2;
                case {6}
                    Z(i,j) = (X(i,1))^3;
                case {7}
                    Z(i,j) = ((X(i,1))^2)*X(i,2);
                case {8}
                    Z(i,j) = X(i,1)*(X(i,2))^2;
                case {9}
                    Z(i,j) = (X(i,2))^3;
            end
            
        
        end 
    
    end 


end 