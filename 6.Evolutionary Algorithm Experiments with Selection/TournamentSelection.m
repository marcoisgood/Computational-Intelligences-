function [newCandidate, bestGenArray]=TournamentSelection(candidate,bestGenArray,mu,i,pop)
    
    [~,I]=sort(candidate.fit,'descend');
    
    %best value for each generation
    bestGenArray(i)= candidate.fit(I(1,:),:);
    
    %Don't repeat to pick the same parents 
    checkNumber = [];
    
    for j = 1:mu
        
        pick1 = 0;
        pick2 = 0;
        
        while pick1 == pick2 || ismember(pick1,checkNumber) || ismember(pick2,checkNumber)
            pick1 = randi([1 pop],1,1);
            pick2 = randi([1 pop],1,1);
        end
        
        if candidate.fit(pick1,:) > candidate.fit(pick2,:)
            newCandidate.binx(j,:) = candidate.binx(pick1,:);
            newCandidate.biny(j,:) = candidate.biny(pick1,:);
            checkNumber = [checkNumber, pick2];
        else
            newCandidate.binx(j,:) = candidate.binx(pick2,:);
            newCandidate.biny(j,:) = candidate.biny(pick2,:);
            checkNumber = [checkNumber, pick1];

        end
        
    end


end