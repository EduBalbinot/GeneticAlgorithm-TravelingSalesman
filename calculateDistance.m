function [population, totalDistance, averageDistance] = calculateDistance(population, cities)
    totalDistance = 0;
    for i = 1:numel(population)
        distance=0;
        for j = 1:numel(cities)-1
            distance= distance + cities(population(i).cityOrder(j)).distance(population(i).cityOrder(j+1));
        end
        population(i).totalPathDistance = distance;
        totalDistance = totalDistance + distance;
    end
    averageDistance = totalDistance/numel(population);
return
end