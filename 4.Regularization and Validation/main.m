load("usps_modified.mat");
[X,Y] = getfeatures(data);


% digit 1 = 1 & others  = -1
Y(Y ~= 1) = -1;

%randomize the data
[x,y] = randmizeData(X,Y);



% transferming the 2-dimensional features into 
% 3rd order polynomial feature space
[Z] = transform(x);
lambdaParameter = [0.001,0.01,0.1,0.25,0.5,0.75,1];
%The array for comparing the results
compareArray = zeros(7,13);
for i = 1:7 %for different lambda prarameter
        Errout = 0;
        Errin = 0;
        averageW = zeros(10,1);
    for j = 1:10 % 10 times Validation for each parameter
        
        [xtrain, xtest, ytrain, ytest] = splitData(Z,y,j); %10% for test, 90% for train
        lambda = lambdaParameter(i);
        
        
        [w] = linreg(xtrain,ytrain,lambda);
        
        [n,~] = size(xtrain);  
        xtrain = [ones(n,1),xtrain]; 
        % validation is for calculating the value of error in and error out
        [Errouttemp,Errointemp,w] = validation(w , xtest, ytest, xtrain, ytrain);
        
        Errin = Errointemp + Errin;
        Errout = Errouttemp + Errout;
        
        averageW = w + averageW;
        
        
    end
        averageW = averageW/10;
        Errout = Errout/10;
        Errin = Errin/10;
        
        disp("Lambada Parameter: " +lambda);
        disp("Error in of sample: " +Errin + "%");
        disp("Error out of sample: " +Errout + "%");

        compareArray(i,1) = Errin;
        compareArray(i,2) = Errout;
        compareArray(i,3) = lambda;
        compareArray(i,4:13) = averageW;
end 

[M,I] = min(compareArray(:,2));
disp("The minimum Error out of sample is: " + M + "%");
disp("The Error in of sample is: " + compareArray(I,1) + "%");
disp("The best value of parameter is: " + compareArray(I,3));
weightvector = compareArray(I,4:13);
plotfigures(weightvector,x,y,Z);



