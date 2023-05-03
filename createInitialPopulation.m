function population = createInitialPopulation(N_POP, N_CITIES)
    population = repmat(struct('cityOrder',[]), 1, N_POP);
    for i = 1:N_POP
        population(i).cityOrder = randperm(N_CITIES);
    end
return
end