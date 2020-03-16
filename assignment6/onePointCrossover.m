function [newCandidate] = onePointCrossover(newCandidate, mu, precision, lambda)


   
        i = 1;
    while i <= lambda
        ParentIndex1 = 0;
        ParentIndex2 = 0;
        crosspoint1 = randi([1 precision], 1, 1); %the cross point
        crosspoint2 = randi([1 precision], 1, 1);
        %pick up the parent in random
        
     
        
        while ParentIndex1 == ParentIndex2 
            ParentIndex1 = randi([1 mu], 1, 1);
            ParentIndex2 = randi([1 mu], 1, 1);
        end
        
        
        Parent1x = newCandidate.binx(ParentIndex1,:);
        Parent1y = newCandidate.biny(ParentIndex1,:);

        Parent2x = newCandidate.binx(ParentIndex2,:);
        Parent2y = newCandidate.biny(ParentIndex2,:);
      
        
        newCandidate.binx(mu+i,:) = [Parent1x(1:crosspoint1),Parent2x(crosspoint1+1:precision)];
        newCandidate.biny(mu+i,:) = [Parent1y(1:crosspoint2),Parent2y(crosspoint2+1:precision)];
        i = i+1;
        newCandidate.binx(mu+i,:) = [Parent2x(1:crosspoint1),Parent1x(crosspoint1+1:precision)];
        newCandidate.biny(mu+i,:) = [Parent2y(1:crosspoint2),Parent1y(crosspoint2+1:precision)]; 
        i = i+1;
        
        
    end
        

end
