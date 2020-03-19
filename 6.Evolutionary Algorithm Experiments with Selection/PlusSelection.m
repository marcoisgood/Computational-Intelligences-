function [newCandidate,bestGenArray] = PlusSelection(candidate, bestGenArray, mu, i)

    [~,I]=sort(candidate.fit,'descend');
    
    %best value for each generation
    bestGenArray(i)= candidate.fit(I(1,:),:);
    
    newCandidate.binx(1:mu,:) = candidate.binx(I(1:mu),:);
    newCandidate.biny(1:mu,:) = candidate.biny(I(1:mu),:);

end