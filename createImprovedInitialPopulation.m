function population = createImprovedInitialPopulation(cities, N_POP, N_CITIES)
    population = repmat(struct('cityOrder',[]), 1, N_POP);
    for i = 1:N_POP
        switch randi([1 5])
            case 1
                population(i).cityOrder = nearestNeighborAlgorithm(cities, N_CITIES);
            case num2cell(2:5)
                population(i).cityOrder = randperm(N_CITIES);            
        end
    end
return
end

function order = nearestNeighborAlgorithm(cities, N_CITIES)
    order = zeros(1,N_CITIES);
    r1 = randi([1 N_CITIES]);
    order(1) = r1;
    for j=2:N_CITIES
        A = [cities(order(j-1)).distance];
        M = min(A(~ismember(1:length(A), [order j])));
        I = find(A== M);
        order(j) = I(numel(I));
    end
return
end