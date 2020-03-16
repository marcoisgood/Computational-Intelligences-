clear;
clc;

%get the data
load("usps_modified.mat");
[X,Y] = getfeatures(data);


%put 400 for each in train dataset, 100 for each in test dataset
[Xtrain,Ytrain, Xtest, Ytest] = orangizeData(X,Y);


%d=1, for Batch gradient; d=2, for stochastic gradient
for d = 1:2
            
        learnRate =50; % learning Rate: 0.1, 1, 10, 50
        disp("learning rate: " + learnRate);

        for r = 1:10   %Run 10 times

            if d == 1
                G = BatchGradientDescent(Xtrain, Ytrain, Xtest, Ytest, learnRate);    
            else
                G = StochasticGradientDecent(Xtrain, Ytrain, learnRate);    
            end
            
            
            if r == 1 %first run, plot the points
                plotfigures(d, Xtest, Ytest, learnRate);
            end
            
            xl = min(Xtrain(:,2)):0.1:max(Xtrain(:,2));
            yl = -(G(2)*xl+G(1))/G(3); 
            plot(xl,yl,'Color',[.8 .8 .8],'LineStyle','--','LineWidth',2);
        
            
            if r == 10 % last time plot the blue line                
    
                xl = min(Xtrain(:,2)):0.1:max(Xtrain(:,2));
                yl = -(G(2)*xl+G(1))/G(3); 
                plot(xl,yl,'color','blue','linewidth',2);
                
                %calculate the error
                [ClassificationEin, ClassificationEout, likehoodEout, likehoodEin] = CalError(G, Xtrain, Ytrain, Xtest, Ytest);
                disp("Classification Error in: " + ClassificationEin);
                disp("Classification Error out: " + ClassificationEout);
                disp("likehood Error in: " + likehoodEin);
                disp("likehood Error out: " + likehoodEout);
                

                
                hold off;
            end
        
        end
        
end


