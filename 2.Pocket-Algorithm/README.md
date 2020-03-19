# Pocket Algorithm

### Introduction

In this assignment, we use a portion of a real data set: the USPS Handwritten Digit database. This database comprises of 1100 examples of the digits 0-9. Each example is an 8-bit gray-scale 16px X 16px image. For the purposes of classification, we will simplify this problem by extracting 2 features from each example. The reason to apply pocket algorithm is the data which is not linearly separable meaning there will always be a misclassified training example if we insist on using a linear hypothesis, and hence PLA will never terminate. Essentially, the pocket algorithm keeps 'in its pocket' the best weight vector encountered up to iteration t in PLA. At the end, the best weight vector will be reported as the final hypothesis. The original PLA only checks some of the examples using w(t) to identify (x(t) , y (t) ) in each iteration, while the pocket algorithm needs an additional step that evaluates all examples using w(t + 1) to get Ein(w(t + 1)). 

### Background

For this project I will be using a portion of a real data set: the USPS Handwritten Digit database. This database comprises of 1100 examples of the digits 0-9. Each example is an 8-bit gray-scale 16px X 16px image. For the purposes of classification, we will simplify this problem by extracting 2 features from each example.

The features intensity and symmetry are defined as follows:

***Intensity:***

Average intensity value in the image - intensity of each pixel is identified by the 8-bit unsigned number

***Symmetry:***

Mean of horizontal and vertical symmetry

- horizontal symmetry:
Negative of the difference between the original and horizontally flipped image.
- vertical symmetry: negative of the difference between the original and vertically flipped image.

A MATLAB function is provided to extract these features from the raw data. The raw data is given as a 256 x 1100 x 10 uint8 matrix, corresponding to the 'image in column major' x 'example' x 'digit'. Once you have extracted these features, you will have a d = 2 dimensional data set. 

We will then filter the data for the ***digits 1 and 5 only.***

Extraction code: getfeatures.mPreview the document

***Assignment***

Write MATLAB code for the pocket algorithm and use a portion of the data set to learn the weights - in sample. Use the rest of the data set to get a sense of the performance - a proxy for out-sample. Try N = 50 and N = 200. With the pocket algorithm, you need to set a maximum number of iterations - test your algorithm to find a good number of iterations (balance between speed and error).

Database in MATLAB format: usps_modified.mat (pre-processed: only 500 examples each)




### Implementation

```
%% main.m

load("assignment2/usps_modified.mat");
[x,y] = getfeatures(data);

%get the number one and five
[X,Y] = getOneToFive(x,y);


%train set N=50 & 200
N=[50,200];

%initial value
b = randi([1,1000],1,1);
errorinsampleA=0;
errorinsampleB=0;
literationCountA=0;
literationCountB=0;
erroroutsampleA = 0;
erroroutsampleB = 0;

%test 1000 times
for a=1:1000
    
    %initial hypothesis line
    w = -1 +2*rand(1,3);
    w(:,1) = 0;
    xl = min(X(:,2)):0.1:max(X(:,2));
    yl = -(w(2)*xl+w(1))/w(3);
    
        
    %1 for N=50, 2 for N=200
    for n=1:2
    
        Ytrainset = zeros(N(n),1);
        Xtrainset = zeros(N(n),3);
        W=w;
        
       %depend on the number of data to create trainset
        for m=1:N(n)
            k = randi([1,1000],1,1);        
            Xtrainset(m,:)= X(k,:);
            Ytrainset(m) = Y(k);        
        end
        
        
        countliter = 0;
        WTNEW = zeros(1,3);
        countErrorinsample = 0;
        s = size(Xtrainset,1);
        t=0;
      
        %test in t times
        while t<300
             t=t+1;
             
             %cal the Error of W
             for x = 1:s
                 Y_hyp_test = sign(dot((W),Xtrainset(x,:)));
                if Ytrainset(x) ~= Y_hyp_test
                    countErrorinsample = countErrorinsample + 1;
                end
             end
             
             ErrorInputW = countErrorinsample/s;
             
             K = randi([1,s],1,1);
             
             %cal the new weight
             
             if (Ytrainset(K)*dot((W),Xtrainset(K,:)))<=0
                 WTNEW=W+Ytrainset(K)*Xtrainset(K,:);
                 
                 %cal the Error of W(t+1)
                 countErrorT1 = 0;
                 for z = 1:s
                    Y_hyp_test = sign(dot((WTNEW),Xtrainset(z,:)));
                    if Ytrainset(z) ~= Y_hyp_test
                       countErrorT1 = countErrorT1 + 1;
                    end
                 end
                 
                 
                 ErrorInputWT1 = countErrorT1/s;
                 
                 if (countErrorT1 < countErrorinsample)
                    W = WTNEW;
                    countliter = countliter+1;
          
                 end
                 
             end
             
        end
        
        
        
        if a == b
            figure(n);
            hold on;
    
            for j = 1:s
                if Ytrainset(j) == 1
                    scatter(Xtrainset(j,2),Xtrainset(j,3),'r','+','LineWidth',2);
                else
                    scatter(Xtrainset(j,2),Xtrainset(j,3),'g','o','LineWidth',2);
                end
            end    
    
    
            axis([-1 1 -1 1]);
            xlabel('x_1'); ylabel('x_2');
            ax = gca;
            ax.XAxisLocation = 'origin';
            ax.YAxisLocation = 'origin';
    
            %plot initial hypothesis line
            plot(xl,yl,'Color',[.8 .8 .8],'LineStyle','--','LineWidth',4);
            xl = min(Xtrainset(:,2)):0.1:max(Xtrainset(:,2));
            yl = -(W(2)*xl+W(1))/W(3);
            plot(xl,yl,'color','blue','linewidth',2);
        end
        
        %cal the out of the sample
        countErrorOutsample = 0;

        for x = 1:1000
            Y_hyp_test = sign(dot((W),X(x,:)));
              if Y(x) ~= Y_hyp_test
                 countErrorOutsample = countErrorOutsample + 1;
              end  
        end
        
        
        if n == 1
           erroroutsampleA = erroroutsampleA + countErrorOutsample;
           errorinsampleA = ErrorInputW + errorinsampleA;
           literationCountA = countliter + literationCountA;
        elseif n ==2
           erroroutsampleB = erroroutsampleB + countErrorOutsample;
           errorinsampleB = ErrorInputW + errorinsampleB;
           literationCountB = countliter + literationCountB;

        end
       
            
    end
    
end
EoutA = round(erroroutsampleA/1000);
EoutB = round(erroroutsampleB/1000);
EinA = errorinsampleA/1000;
EinB = errorinsampleB/1000;
literA = round(literationCountA/1000);
literB = round(literationCountB/1000);
fprintf('In average,\nThe literation with \n 50 points is %d \n 200 points is %d \nThe error in sample \n with 50 points is %d\n with 200 points is %d\nThe error out of sample \n with 50 points training is %d\n with 200 points training is %d\n  ',literA,literB,round(EinA),round(EinB),EoutA,EoutB);

```

```
%%getTheError
function [error]=getTheError(W,X,Y,s)


    error = 0;
    for z = 1:s
        Y_hyp_test = sign(dot((W),X(z,:)));
        if Y(z) ~= Y_hyp_test
            error = error + 1;
        end
    end
    
```

### The average of error in and out of sample:


***With N = 50,***
<br/>
the average of error in of sample is: 5
<br/>
the average of error out of sample is: 17
<br/>
***With N = 200,***
<br/>
the average of error in of sample is: 6
<br/>
the average of error out of sample is: 19

### Example graphs of algorithm's results with the in-sample data:

N = 50:

![Fi](./READ_images/F1.png)

N = 200:

![F2](./READ_images/F2.png)

### Explanation of your choice of stopping criteria (i.e. fixed number of iterations, etc.).
According to the output, when training set with N = 50 (training points), the average (in 1000 times) of the number of iterations is 5. And, the training set with N= 200, the average of the number of iterations is 6. So, for making the balance between speed and accuracy, I found that 300 times to testing weight can decreased the error out of sample to around 19. 

### The difference or changes were necessary when the training set was set to N=50 and N=200?
According to my output, the iteration of the training set N=50 and N=200 are almost same, but in the error of in and out sample, N = 200 set had higher error value. So, for N=200, the test time should be increase to get more accurate line.
