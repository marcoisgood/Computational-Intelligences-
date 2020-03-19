function [newCandidate,bestGenArray] = LinearRankingSelection(candidate,bestGenArray,pop,mu,i)
    
    etaplus = 1.7;
    etaminus = 2 - etaplus;
    
    [~,I]=sort(candidate.fit,'descend');
    
    %best value for each generation
    bestGenArray(i)= candidate.fit(I(1,:),:);
    
    prop = zeros(pop,1);
    
    for j = 1:pop
       prop(j,:) = (etaplus - (((etaplus-etaminus)*(j-1))/(pop-1)))/pop;
    end
    
    prop = cumsum(prop);
   
    k = 1;
    while k <= mu
        sel = rand(1,1);
        for l = 1:pop
            if prop(l,:) >= sel
              newCandidate.binx(k,:) = candidate.binx(I(l),:);
              newCandidate.biny(k,:) = candidate.biny(I(l),:);
              k = k + 1;
              break;
            end
        end   
    end 
        
        
        
      %for k = 1:mu
    %    sel = 0.4;
    %    while sel > 0.375
    %        sel = rand(1,1);
    %    end
    %    for l = 1:pop
    %        if prop(l,:) >= sel
    %          newCandidate.binx(k,:) = candidate.binx(I(l),:);
    %          newCandidate.biny(k,:) = candidate.biny(I(l),:);
    %          break;
    %        end
    %    end
    %end

end
