%classify the digit 1 and others. 
%others will be -1;

function [Y] = orangizeData (y)
    
    Y = y;
    Y(Y ~= 1) = -1;
   
end 