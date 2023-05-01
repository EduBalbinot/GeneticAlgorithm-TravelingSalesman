function cumulativeProportions = getCumulativeProportions(population, totalDistance)
    cumulativeTotal = 0;
    cumulativeProportions = zeros(1,numel(population));
    for i = 1:numel(population)
        inversedProportions = totalDistance/population(i).totalPathDistance;
        cumulativeTotal = cumulativeTotal + inversedProportions;
        cumulativeProportions(i) = cumulativeTotal;
    end
    cumulativeProportions = cumulativeProportions/cumulativeTotal;
return
end