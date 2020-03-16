function [X,Y] = generate(N,targetFLine)

%training data set
X = -1 + 2*rand(N,3);
X(:,1)=1;
Y = zeros(N,1);



for i=1:N
    if X(i,3)-targetFLine(1)*X(i,2)-targetFLine(2)<0
        Y(i,1)=1;
    else
        Y(i,1)=-1;
    end
end