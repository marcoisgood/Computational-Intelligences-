function  [M] = front(pop,sortIndex)


    %check the size of the sortIndex
    [~,popsize] = size(sortIndex);
    
    half = floor(popsize/2);
    M = [];
    
    if popsize == 0
        return;
    elseif popsize == 1
        M = sortIndex;
    else
        %for T set
        [TIndex ] = front(pop,sortIndex(:,1:half));
        % for B set
        [BIndex] = front(pop,sortIndex(:,(half+1):popsize));
        [~,k] = size(TIndex);
        [~,l] = size(BIndex);
        
        
        for i = 1:l
            %flag for checking the domination
            isDominated = false;
            for j = 1:k
                B = pop(BIndex(i)).objectTwo;
                T = pop(TIndex(j)).objectTwo;
                if B > T %if any points from T set dominate B point, B is dominated
                    isDominated = true;
                    break;
                end
            end
            if isDominated == false
                M = [M;BIndex(i)];
            end
            
        end
        
        M = [M; TIndex];
       
    end

end
