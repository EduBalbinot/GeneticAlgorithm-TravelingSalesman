function cities = createCities(N_CITIES, Y_MAX, X_MAX, CITY_SIZE, NUMBER_SIZE)
    cities = repmat(struct('x',{},'y',{}), N_CITIES, 1);
    cityRadius= ceil(CITY_SIZE/2);
    
    s = get(0, 'ScreenSize');
    figure(1);
    set(gcf, 'Position', [0 40 s(3) s(4)-120], 'NumberTitle', 1);
    hold on
    
    for i = 1:N_CITIES
        while true
            xc = randi([cityRadius X_MAX-cityRadius-1]);
            yc = randi([cityRadius+1 Y_MAX-cityRadius]);
            isColliding = checkCollision1(cities, xc, yc, CITY_SIZE);
            if ~isColliding
                break;
            end
        end
        drawCities(xc, yc, CITY_SIZE, i, X_MAX, Y_MAX, NUMBER_SIZE);
        cities(i).x = xc;
        cities(i).y = yc;
    end
    
%     for i = 1:N_CITIES
%         for j = i+1:N_CITIES
%             line([cities(i).x, cities(j).x],...
%                  [cities(i).y, cities(j).y],'LineStyle', ':', 'LineWidth', 1, 'Color', 'red')
%         end
%     end
    
    cities = citiesDistance(cities, N_CITIES);
return
end

function isColliding = checkCollision1(cities, xc, yc, CITY_SIZE)
    for j = 1:length(cities)
        if abs(cities(j).x-xc)<CITY_SIZE && abs(cities(j).y-yc)<CITY_SIZE
            isColliding = true;
            return
        end
    end
    isColliding = false;
    return
end

function cities = citiesDistance(cities, N_CITIES)
    for i = 1:N_CITIES
        for j = 1:N_CITIES
            cities(i).distance(j)= sqrt((cities(i).x-cities(j).x)^2+(cities(i).y-cities(j).y)^2);
        end
    end
    return
end