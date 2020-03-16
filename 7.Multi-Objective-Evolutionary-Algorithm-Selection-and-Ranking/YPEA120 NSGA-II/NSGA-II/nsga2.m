%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA120
% Project Title: Non-dominated Sorting Genetic Algorithm II (NSGA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;



%time for kung's method and NonDominatedSorting.
TimeKun = [];
TimeNor = [];

%1 for kung's method, 2 for NonDominatedSorting
for T = 1:2
    %for each number of canafdies
    for m = 1:5
        TimeofKung = 0;
        TimeofNormal = 0;
        
        %for 200 trials
        for g = 1:200
            
            
            %% Problem Definition
            
            CostFunction=@(x) MOP4(x);      % Cost Function
            
            nVar=3;             % Number of Decision Variables
            
            VarSize=[1 nVar];   % Size of Decision Variables Matrix
            
            VarMin=-5;          % Lower Bound of Variables
            VarMax= 5;          % Upper Bound of Variables
            
            % Number of Objective Functions
            nObj=numel(CostFunction(unifrnd(VarMin,VarMax,VarSize)));
            %%
            
            %% NSGA-II Parameters
            
            MaxIt=1;      % Maximum Number of Iterations
            
            nPop=m*40;        % Population Size
            
            pCrossover=0.7;                         % Crossover Percentage
            nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)
            
            pMutation=0.4;                          % Mutation Percentage
            nMutation=round(pMutation*nPop);        % Number of Mutants
            
            mu=0.02;                    % Mutation Rate
            
            sigma=0.1*(VarMax-VarMin);  % Mutation Step Size
            
            
            %% Initialization
            
            empty_individual.Position=[];
            empty_individual.Cost=[];
            empty_individual.Rank=[];
            empty_individual.DominationSet=[];
            empty_individual.DominatedCount=[];
            empty_individual.CrowdingDistance=[];
            
            pop=repmat(empty_individual,nPop,1);
            
            for i=1:nPop
                
                pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
                
                pop(i).Cost=CostFunction(pop(i).Position);
                
            end
            
            % Non-Dominated Sorting
            [pop, F]=NonDominatedSorting(pop);
            
            % Calculate Crowding Distance
            pop=CalcCrowdingDistance(pop,F);
            
            % Sort Population
            [pop, F]=SortPopulation(pop);
            
            
            %% NSGA-II Main Loop
            
            for it=1:MaxIt
                
                % Crossover
                popc=repmat(empty_individual,nCrossover/2,2);
                for k=1:nCrossover/2
                    
                    i1=randi([1 nPop]);
                    p1=pop(i1);
                    
                    i2=randi([1 nPop]);
                    p2=pop(i2);
                    
                    [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position);
                    
                    popc(k,1).Cost=CostFunction(popc(k,1).Position);
                    popc(k,2).Cost=CostFunction(popc(k,2).Position);
                    
                end
                popc=popc(:);
                
                % Mutation
                popm=repmat(empty_individual,nMutation,1);
                for k=1:nMutation
                    
                    i=randi([1 nPop]);
                    p=pop(i);
                    
                    popm(k).Position=Mutate(p.Position,mu,sigma);
                    
                    popm(k).Cost=CostFunction(popm(k).Position);
                    
                end
                
                % Merge
                pop=[pop
                    popc
                    popm]; %#ok
                
             
%%
                
                if T == 1 
                    % Kung's method
                    tic;
                    [pop, F]=kungMethod(pop);
                    Tone = toc;
                

                else
                % Non-Dominated Sorting #########
                    tic;
                    [pop, F]=NonDominatedSorting(pop);
                    Ttwo = toc;
                end
                
 %%               
                % Calculate Crowding Distance
                %pop=CalcCrowdingDistance(pop,F);
                % Sort Population
                %pop=SortPopulation(pop);
                
                % Truncate
                %pop=pop(1:nPop);
                
                % Non-Dominated Sorting
                %[pop, F]=NonDominatedSorting(pop);
                
                % Calculate Crowding Distance
                %pop=CalcCrowdingDistance(pop,F);
                
                % Sort Population
                %[pop, F]=SortPopulation(pop);
                
                % Store F1
                F1=pop(F{1});
                
                % Show Iteration Information
                %disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
                
                % Plot F1 Costs
                figure(1);
                PlotCosts(F1);
                
                pause(0.01);
                
            end
            
            if T == 1
                TimeofKung = Tone + TimeofKung;
            else
                TimeofNormal = Ttwo + TimeofNormal;
            end
            
        end
        
        xlabel('1^{st} Objective');
        ylabel('2^{nd} Objective');
        title('Non-dominated Solutions (F_{1})');

        
        
        
        if T == 1
            
            TimeofKung = TimeofKung/g;
            TimeKun = [TimeKun;TimeofKung];

        else
            TimeofNormal = TimeofNormal/g;
            TimeNor = [TimeNor;TimeofNormal];

        end
        
    end
    

end
%% Results

figure(2);
hold on;
%axis([1 5 0.001 0.05]);
title("result of average execution time on 200 trials at each population size");
xlabel = ("population: 40,80,120,160,200");
ylable = ("Time(s)");
ylim([0.001 inf]);
%set(gca,'YScale','log');

a = 40:40:200;
plot(a,TimeKun,'color','r','DisplayName','Kung');
plot(a,TimeNor,'color','b','DisplayName','NonDominatedSorting');
legend('Location','southwest')

hold off;
