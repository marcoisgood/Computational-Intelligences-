function [newCandidate, bestGenArray] = ProportionalSelection(candidate,bestGenArray,pop,mu,i)
  
  fitsum = sum(candidate.fit);       
  [cfit, I]= sort(candidate.fit,'descend');
  
  %the best value for each generation
  bestGenArray(i) = candidate.fit(I(1,:),:);
            
  candidate.p = cfit./fitsum;
  %[m,n] = size(candidate.p);
  candidate.sp = cumsum(candidate.p);
          
  %Selection
  for j = 1:mu
      sel=rand;
      for k = 1:pop
          if candidate.sp(k) >= sel
              newCandidate.binx(j,:) = candidate.binx(I(k),:);
              newCandidate.biny(j,:) = candidate.biny(I(k),:);
              break;
          end
      end
  end
  
  
end