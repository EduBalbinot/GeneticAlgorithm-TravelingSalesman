function [cities, N_CITIES, Y_MAX] = test(CITY)
fid = fopen(['tests/' CITY '.tsp'], 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', ' ', 'HeaderLines', 6, 'TreatAsEmpty', 'EOL');
fclose(fid); 

data=[data{1}(~isnan(data{1})) data{2}(~isnan(data{2})) data{3}(~isnan(data{3}))];

X_MAX = ceil(max([data(:,2)/100]))*100;
Y_MAX = ceil(max([data(:,3)/100]))*100;
NUMBER_SIZE = 7;
CITY_SIZE = ceil((X_MAX*Y_MAX)/100000);
N_CITIES = size(data, 1);

for i =1:N_CITIES
    cities(i) = struct('i', data(i,1), 'x', data(i,2), 'y', data(i,3));
end
    
    s = get(0, 'ScreenSize');
    figure(1);
    set(gcf, 'Position', [0 40 s(3) s(4)-120], 'NumberTitle', 1);
    hold on
    for i = 1:N_CITIES
        drawCities(cities(i).x, cities(i).y, CITY_SIZE, i, X_MAX, Y_MAX, NUMBER_SIZE)
    end
    cities = citiesDistance(cities, N_CITIES);
end

function cities = citiesDistance(cities, N_CITIES)
    for i = 1:N_CITIES
        for j = 1:N_CITIES
            cities(i).distance(j)= sqrt((cities(i).x-cities(j).x)^2+(cities(i).y-cities(j).y)^2);
        end
    end
    return
end