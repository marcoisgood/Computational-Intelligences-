function [x,ytemp] = randmizeData(X,Y)
     
    D = [X,Y];
    
    r = randperm(size(D,1));
    
    d = D(r,:);

    x = d(:,1:2);
    ytemp = d(:,3);

end