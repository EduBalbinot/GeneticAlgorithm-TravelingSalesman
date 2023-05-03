function [parent, j] = selection(population, cumulativeProportions)
    switch randi([1 2])
        case 1
            [parent, j] = biasedRandomSelection(population, cumulativeProportions);
        case 2
            [parent, j] = tournamentSelection(population);
    end
return
end

function [parent, j] = biasedRandomSelection(population, cumulativeProportions)
    selectedValue = rand(1);
    for j = 1:numel(cumulativeProportions)
        if(selectedValue<=cumulativeProportions(j)); break; end
    end
    parent = population(j).cityOrder;
return
end

function [parent, j] = tournamentSelection(population)
    r1 = randi([1 numel(population)]);
    r2 = randi([1 numel(population)]);
    while r1==r2
        r2 = randi([1 numel(population)]);
    end
    if population(r1).totalPathDistance > population(r2).totalPathDistance
        parent = population(r2).cityOrder;
        j = r2;
    else
        parent = population(r1).cityOrder;
        j = r1;
    end
return
end