function [ X,Y ] = getOneToFive( x,y )


Y = zeros(1000,1);
Xb = zeros(1000,2);
Xa = zeros(1000,1);


%get the number 1 & 5
for i =1:2500
    if y(i) == 1   
       Y(i)=-1;
       Xb(i,:)= x(i,:);
    
    elseif y(i) == 5
       Y(i-1500)=1;
       Xb(i-1500,:)= x(i,:);
 
    end
end
X = [Xa,Xb];
