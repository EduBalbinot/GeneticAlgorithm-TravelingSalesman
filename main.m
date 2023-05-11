%traveling salesman problem
clear, close, clc

%configs
N_POP = 5000;
IMPROVED_POP_ENABLE = true;

%stop criterion
MAX_NOREPEAT = 40;
MAX_GENERATION = 1000;
N_TESTS = 2;

%random city
RANDOM_ENABLE = false;
X_MAX = 2000;
Y_MAX = 1000;
N_CITIES = 20;

%set city
CITY = 'berlin52';

%mutation
MUTATION_CHANCE = 0.10;
ANNEALING_ENABLE = true;
ANNEALING_TEMPERATURE = 100;
ANNEALING_COOLING_RATE = 0.85;
ANNEALING_STOP_CRITERION = 1e-6;

%setup
CITY_SIZE = floor(X_MAX/N_CITIES);
NUMBER_SIZE = 0.1*CITY_SIZE;
if NUMBER_SIZE<7; NUMBER_SIZE=7; end

if RANDOM_ENABLE; cities = createCities(N_CITIES, Y_MAX, X_MAX, CITY_SIZE, NUMBER_SIZE);
else; [cities, N_CITIES, Y_MAX] = test(CITY); end
    
for iterations = 1:N_TESTS
    generation = 0;
    fitnessTotal = 0; 
    fitnnesAverage = 0;
    noChangeCounter = 0;
    lastBest = 0;
    
if IMPROVED_POP_ENABLE; population = createImprovedInitialPopulation(cities, N_POP, N_CITIES); 
else; population = createInitialPopulation(N_POP, N_CITIES);end


    [population, totalFitness, averageFitness] = calculateDistance(population, cities);

    while generation<MAX_GENERATION && noChangeCounter<MAX_NOREPEAT
        cumulativeProportions = getCumulativeProportions(population, totalFitness);
        currentBest = DrawBest(population, cities, generation, Y_MAX);
        bestDistanceGraph(generation + 1,1:2)=[generation; currentBest];
        averageDistanceGraph(generation + 1,1:2)=[generation; averageFitness];

        offspring = crossover(population, cumulativeProportions);
        offspring = mutation(cities, offspring, MUTATION_CHANCE, N_CITIES, (3 + ANNEALING_ENABLE), ...
                             ANNEALING_TEMPERATURE, ANNEALING_COOLING_RATE, ANNEALING_STOP_CRITERION);
        [offspring, totalFitness, averageFitness] = calculateDistance(offspring, cities);
        population = cat(2, population, offspring);

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
    %     figure(2)
    %     plot(bestDistanceGraph(1:generation,1), bestDistanceGraph(1:generation,2))
    %     hold on
    %     plot(averageDistanceGraph(1:generation,1), averageDistanceGraph(1:generation,2))
    %     hold off
        generation = generation + 1;
    end

    figure(2)
    hold on
    plot(bestDistanceGraph(:,1), bestDistanceGraph(:,2))
    plot(averageDistanceGraph(:,1), averageDistanceGraph(:,2))
    best(iterations) = currentBest;
end
disp(best)
disp(['Média = ' num2str(sum(best)/numel(best))])

function currentBest = DrawBest(population, cities, generation, Y_MAX)
    bestIndividual = find([population.totalPathDistance] == min([population.totalPathDistance]));
    figure(1)
    drawRoute(cities, [population(bestIndividual(1)).cityOrder]);
    delete(findobj(gca, 'DisplayName', 'Distance'));
    text(0, Y_MAX+20,['Generation:' num2str(generation) ' - ' ...
                      num2str(population(bestIndividual(1)).totalPathDistance)...
                      ' Km'], 'DisplayName', 'Distance', 'FontSize', 20)
    currentBest = population(bestIndividual(1)).totalPathDistance;
return
end

function population = selectParents(population, N_POP)
     [~, indices] = sort([population.totalPathDistance],'ascend');
     orderedParents = population(indices);
     population = orderedParents(1:N_POP);
return
end
