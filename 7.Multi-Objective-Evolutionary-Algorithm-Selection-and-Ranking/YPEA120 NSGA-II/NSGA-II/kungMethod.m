function [pop, F]=kungMethod(pop)

    %size of the population
    [popsize,~] = size(pop);
    
    %split the data to new col
    for i = 1: popsize
        pop(i).objectOne = pop(i).Cost(1,1);
        pop(i).objectTwo = pop(i).Cost(2,1);
    end
    
    
    %sorting based on first objective
    [~,sortIndex] = sort([pop.objectOne]);
    
    %comparing based on second objective
    %[minArray] = front(pop,sortIndex);
    
    
    %for different level of front
    k = 1;
    F{1} = [];
    while true
        
        [minArray] = front(pop,sortIndex);
        F{k} = minArray;
        k = k + 1;
        %delete the previous index. 
        sortIndex = sortIndex(~ismember(sortIndex,minArray));
        %if sortIndex is out, done!
        if isempty(sortIndex)
            break;
        end
    end
end
    
    
    
    

