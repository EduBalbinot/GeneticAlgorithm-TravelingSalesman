%traveling salesman problem
clear, clc

%screen
X_MAX = 2000;
Y_MAX = 1000;

%configs
N_POP = 100;
N_CITIES = 30;
MAX_NOREPEAT = 1000;
MUTATION_CHANCE = 0.2;



%setup
CITY_SIZE = floor(X_MAX/N_CITIES);
NUMBER_SIZE = 0.1*CITY_SIZE;
if NUMBER_SIZE<7; NUMBER_SIZE=7; end
generation = 0;
fitnessTotal = 0; 
fitnnesAverage = 0;
bestDistanceGraph = [0 0];
noChangeCounter = 0;
lastBest = 0;

%Berlin52

[cities, N_CITIES, Y_MAX] = berlin52();

% cities = createCities(N_CITIES, Y_MAX, X_MAX, CITY_SIZE, NUMBER_SIZE);
population = createInitialPopulation(N_POP, N_CITIES);

[population, totalDistance, averageDistance] = calculateDistance(population, cities);

while noChangeCounter<MAX_NOREPEAT
    cumulativeProportions = getCumulativeProportions(population, totalDistance);
    
    currentBest = DrawBest(population, cities, generation, Y_MAX);
    bestDistanceGraph(generation + 1,1:2)=[generation; currentBest];
    
    offspring = crossover(population, cumulativeProportions);
    offspring = mutation(population, MUTATION_CHANCE, N_CITIES);
    [offspring, totalDistance, averageDistance] = calculateDistance(offspring, cities);
    population = cat(1, population, offspring);
    
    population = selectParents(population, N_POP);
    
    fprintf('  Best Value: %f \n',currentBest);
    fprintf('Generation: %d \n', generation); 
    fprintf(repmat('-',1,100))
    fprintf('\n\n')
    
    if lastBest == currentBest
        noChangeCounter = noChangeCounter + 1;
    else
        noChangeCounter = 0;
    end
    lastBest = currentBest;
    
    generation = generation + 1;
end

figure(2)
plot(bestDistanceGraph(:,1), bestDistanceGraph(:,2))

function currentBest = DrawBest(population, cities, generation, Y_MAX)
    bestIndividual = find([population.totalPathDistance] == min([population.totalPathDistance]));
    figure(1)
    drawRoute(cities, [population(bestIndividual(1)).cityOrder]);
    delete(findobj(gca, 'DisplayName', 'Distance'));
    text(0, Y_MAX+20,['Generation:' num2str(generation) ' - ' num2str(population(bestIndividual(1)).totalPathDistance) ' Km'], 'DisplayName', 'Distance', 'FontSize', 20)
    currentBest = population(bestIndividual(1)).totalPathDistance;
return
end

function population = selectParents(population, N_POP)
     [~, indices] = sort([population.totalPathDistance],'ascend');
     orderedParents = population(indices);
     population = orderedParents(1:N_POP);
return
end
