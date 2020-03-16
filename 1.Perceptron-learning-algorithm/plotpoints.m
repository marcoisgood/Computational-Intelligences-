function plotpoints(w,X)

    xl = min(X(:,2)):0.1:max(X(:,2));
    yl = -(w(2)*xl+w(1))/w(3);
    
    
    
