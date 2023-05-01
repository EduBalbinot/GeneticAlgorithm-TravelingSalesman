function [parent, j] = biasedRandomSelection(population, cumulativeProportions)
    selectedValue = rand(1);
    for j = 1:numel(cumulativeProportions)
        if(selectedValue<=cumulativeProportions(j)); break; end
    end
    parent = population(j).cityOrder;
return
end