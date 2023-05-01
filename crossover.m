function offspring = crossover(population, cumulativeProportions)
    offspring= repmat(struct('cityOrder',{}), numel(population), 1);
    for i = 1:numel(population)/2
        [mother, m] = biasedRandomSelection(population, cumulativeProportions);
        [father, f] = biasedRandomSelection(population, cumulativeProportions);
        while isequal(m, f)
            [father, f] = biasedRandomSelection(population, cumulativeProportions);
        end
        crossoverPosition = randi([1 numel(mother)]);
        offspring(2*i).cityOrder = doCrossover(mother, father, crossoverPosition);
        offspring(2*i -1).cityOrder = doCrossover(father, mother, crossoverPosition);
    end
return
end

function offspring = doCrossover(mother, father, crossoverPosition)
    offspring = mother(1:crossoverPosition);
    offspring = horzcat(offspring, father(~ismember(father,offspring)));
return
end