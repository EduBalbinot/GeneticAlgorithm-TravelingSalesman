function population = mutation(cities, population, MUTATION_CHANCE, N_CITIES, CASES, ...
    ANNEALING_TEMPERATURE, ANNEALING_COOLING_RATE, ANNEALING_STOP_CRITERION )
    for i = 1:numel(population)
        if(rand(1)<MUTATION_CHANCE)
            r1 = randi([1 N_CITIES]);
            r2 = randi([1 N_CITIES]);
            while isequal(r1,r2)
                r2 = randi([1 N_CITIES]);
            end 

            randomIndividual = randi([1 numel(population)]);
            switch randi([1 CASES])
                case 1
                    % SWAP
                    population = swap(r1, r2, population, randomIndividual);
                case 2
                    % REVERSE
                    population = reverse(r1, r2, population, randomIndividual);
                case 3
                    % SHUFFLE
                    population = shuffle(population, randomIndividual, N_CITIES);
                case 4
                    % SIMULATED ANNEALING
                    population = simulatedAnnealing(cities, population, randomIndividual, N_CITIES,...
                                 ANNEALING_TEMPERATURE, ANNEALING_COOLING_RATE, ANNEALING_STOP_CRITERION);
            end
        end
    end
return
end

function population = swap(r1, r2, population, randomIndividual)
    temp = population(randomIndividual).cityOrder(r1);
    population(randomIndividual).cityOrder(r1)= population(randomIndividual).cityOrder(r2);
    population(randomIndividual).cityOrder(r2) = temp;
end

function population = reverse(r1, r2, population, randomIndividual)
	population(randomIndividual).cityOrder(r1:r2)= flip(population(randomIndividual).cityOrder(r1:r2));
end

function population = shuffle(population, randomIndividual, N_CITIES)
    numElementsToShuffle = randi([1, N_CITIES]);
    permIndices = randperm(N_CITIES);
    indicesToShuffle = permIndices(1:numElementsToShuffle);
    shuffledElements = population(randomIndividual).cityOrder(indicesToShuffle);
    shuffledElements = shuffledElements(randperm(length(shuffledElements)));
    population(randomIndividual).cityOrder(indicesToShuffle) = shuffledElements;
end

function population = simulatedAnnealing(cities, population, randomIndividual, N_CITIES,...
    ANNEALING_TEMPERATURE, ANNEALING_COOLING_RATE, ANNEALING_STOP_CRITERION)

    while ANNEALING_TEMPERATURE > ANNEALING_STOP_CRITERION
        neighbor = mutation(cities, population(randomIndividual), 1, N_CITIES, 3, ...
                    ANNEALING_TEMPERATURE, ANNEALING_COOLING_RATE, ANNEALING_STOP_CRITERION );
        cityFitness = getTotalPathDistance(cities, population(randomIndividual));
        neighborFitness = getTotalPathDistance(cities, neighbor);
        deltaFitness = neighborFitness - cityFitness;
        acceptanceProbability = exp(-deltaFitness / ANNEALING_TEMPERATURE);
        if rand() < acceptanceProbability
            population(randomIndividual) = neighbor;
            population(randomIndividual).totalPathDistance = neighborFitness;
        end
        ANNEALING_TEMPERATURE = ANNEALING_COOLING_RATE * ANNEALING_TEMPERATURE;
    end
return 
end

function neighbor_fitness = getTotalPathDistance(cities, neighbor)
        neighbor_fitness=0;
        for j = 1:numel(cities)-1
            neighbor_fitness= neighbor_fitness + cities(neighbor.cityOrder(j)).distance(neighbor.cityOrder(j+1));
        end
        neighbor_fitness = neighbor_fitness + cities(neighbor.cityOrder(1)).distance(neighbor.cityOrder(numel(cities)));
return
end