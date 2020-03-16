clear;
clc;
load("usps_modified.mat");
[X,Y]=getfeatures(data);


Y(Y~=1) = 0;

%randomize the data points
[x,y]=randmizeData(X,Y);


%show user the optiion
disp("1-Batch Gradient Descent");
disp("2-Stochastic Gradient Descent");
disp("3-Variable Learning Rate Gradient Descent");
disp("4-Steepest Descent (Gradient Descent with Line Search");
Gradient = 'Please choose one algorithm for weight update: ';
C = input(Gradient);

%initialize layer
num_layers = 3;
layers(1:num_layers,1) = struct;
layers(2).w = rand(3,5);
layers(3).w = rand(6,1);


%J for choose the dataset. 
j = randi([1 7],1);
[xtrain, xtest, ytrain, ytest] = splitData(x,y,j); %20% for test, 80% for train

Errout = 0;
Erroin = 0;
Ein = 0;
Eout = 0;
times = 1;

%run 50 times
for i = 1:times
    switch C
        case {1}
             [EinArray,Erroin, Errout,lr,layers] = BatchGD(xtrain, xtest, ytrain, ytest, layers);
             m=1:100;
        case {2}
             [EinArray,Erroin,Errout,lr,layers] = StochasticGD(xtrain, xtest, ytrain, ytest, layers);
             m=1:10;
        case {3}
            [EinArray,Erroin, Errout,lr,layers] = VariableLearningRateGD(xtrain, xtest, ytrain, ytest, layers);
             m=1:100;
        case {4}
            [EinArray,Erroin,Errout,lr,layers] = steepestD(xtrain, xtest, ytrain, ytest, layers);
             m=1:100;
    end
    Ein = Erroin + Ein;
    Eout = Errout + Eout;
    
end

Ein = Ein/times;
Eout = Eout/times;

disp("Ein: " + Ein);
disp("Eout: " + Eout);

%plot Error of each iter
k = EinArray(m);

figure();
hold on;
T = ['Graph of result of Errout with learning rate: ', num2str(lr)];
title(T);

plot(m,k, 'color','r');
hold off;

%plot the classification of point
figure();
hold on;
T = ('Graph of result of data point');
title(T);
plotDataPoint(layers,x,y);
hold off;



    
    
    
