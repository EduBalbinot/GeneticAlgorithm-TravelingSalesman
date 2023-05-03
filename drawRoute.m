function drawRoute(cities, cityOrder)
    delete(findall(gca, 'type', 'line'));
    for i = 1:numel(cityOrder)-1
        j = cityOrder(i);
        k = cityOrder(i+1);
    	line([cities(j).x, cities(k).x],[cities(j).y, cities(k).y], 'LineWidth', 0.7, 'Color', 'red'); 
    end
    line([cities(cityOrder(1)).x, cities(cityOrder(numel(cityOrder))).x],...
         [cities(cityOrder(1)).y, cities(cityOrder(numel(cityOrder))).y], 'LineWidth', 1, 'Color', 'red'); 
end