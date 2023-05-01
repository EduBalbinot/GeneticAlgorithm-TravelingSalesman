function population = createInitialPopulation(N_POP, N_CITIES)
    population = repmat(struct('cityOrder',[]), N_POP, 1);
    for i = 1:N_POP
        population(i).cityOrder = randperm(N_CITIES);
    end
return
end