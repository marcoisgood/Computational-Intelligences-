function [newCandidate] = CrossoverDie(newCandidate, mu, precision, lambda)
    
        Child1x = zeros(1,precision);
        Child2x = zeros(1,precision);
        Child1y = zeros(1,precision);
        Child2y = zeros(1,precision);
        i = 1;
        
        
    while i <= lambda
        
        dieOrLive = randi([0 1],1,1);
        
        %binary mask
        mask = randi([0 1], 1, precision); 
        
        % choose two parents in random
        ParentIndex1 = 0;
        ParentIndex2 = 0;
        
        %pick up the parent in random
        while ParentIndex1 == ParentIndex2
            ParentIndex1 = randi([1 mu], 1, 1);
            ParentIndex2 = randi([1 mu], 1, 1);
        end
        
        
        Parent1x = newCandidate.binx(ParentIndex1,:);
        Parent1y = newCandidate.biny(ParentIndex1,:);

        Parent2x = newCandidate.binx(ParentIndex2,:);
        Parent2y = newCandidate.biny(ParentIndex2,:);
        
       
        for j = 1 : precision
            if mask (j) == 1
                Child1x(j) = Parent1x(j);
                Child1y(j) = Parent1y(j);
                Child2x(j) = Parent2x(j);
                Child2y(j) = Parent2y(j); 
            else
                Child1x(j) = Parent2x(j);
                Child1y(j) = Parent2y(j);
                Child2x(j) = Parent1x(j);
                Child2y(j) = Parent1y(j); 
            end
        
        
        end
        
        if dieOrLive == 0
            newCandidate.binx(ParentIndex1,:) = rand(1,precision)>0.5;   %generate binary representation
            newCandidate.biny(ParentIndex1,:) = rand(1,precision)>0.5;
            newCandidate.binx(ParentIndex2,:) = rand(1,precision)>0.5;   %generate binary representation
            newCandidate.biny(ParentIndex2,:) = rand(1,precision)>0.5;
        end
            
        newCandidate.binx(mu+i,:) = Child1x(1,:);
        newCandidate.biny(mu+i,:) = Child1y(1,:);
        i = i+1;
        newCandidate.binx(mu+i,:) = Child2x(1,:);
        newCandidate.biny(mu+i,:) = Child2y(1,:);
        i = i+1;
    end



end
