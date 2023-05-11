function offspring = crossover(population, cumulativeProportions)
    offspring= repmat(struct('cityOrder',{}), numel(population), 1);
    for i = 1:numel(population)/2
        [mother, m] = selection(population, cumulativeProportions);
        [father, f] = selection(population, cumulativeProportions);
        hammingDistance = GetHammingDistance(mother, father);
        while hammingDistance < numel(mother)/10
            hammingDistance = GetHammingDistance(mother, father);
            [father, f] = selection(population, cumulativeProportions);
        end
        if rand(1)>0.5
            offspring = singlePoint(offspring, mother, father, i);
        else
            offspring = orderCrossover(offspring, mother, father, i);
        end
    end
return
end

function hammingDistance = GetHammingDistance(mother, father)
    hammingDistance = 0;
    hammingDistance = sum((mother==father)==0);
return
end
function offspring = orderCrossover(offspring, mother, father, i)
        crossoverPosition1 = randi([1 numel(mother)]);
        crossoverPosition2 = randi([1 numel(mother)]);
        offspring(2*i).cityOrder = doCrossover(mother, father, crossoverPosition1, crossoverPosition2);
        offspring(2*i -1).cityOrder = doCrossover(father, mother, crossoverPosition2, crossoverPosition1);
return
end

function offspring = singlePoint(offspring, mother, father, i)
        crossoverPosition = randi([1 numel(mother)]);
        offspring(2*i).cityOrder = doCrossover(mother, father,1, crossoverPosition);
        offspring(2*i -1).cityOrder = doCrossover(father, mother,1, crossoverPosition);
return
end

function offspring = doCrossover(mother, father, crossoverPosition1, crossoverPosition2)
    offspring = mother(crossoverPosition1:crossoverPosition2);
    offspring = horzcat(offspring, father(~ismember(father,offspring)));
return
end