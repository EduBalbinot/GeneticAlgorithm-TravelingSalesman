function population = mutation(population, MUTATION_CHANCE, N_CITIES)
    if(rand(1)>MUTATION_CHANCE)
        r1 = randi([1 N_CITIES]);
        r2 = randi([1 N_CITIES]);
        while isequal(r1,r2)
            r2 = randi([1 N_CITIES]);
        end
        randomIndividual = randi([1 numel(population)]);
        if(rand(1)>0.5)
            %SWAP
            temp = population(randomIndividual).cityOrder(r1);
            population(randomIndividual).cityOrder(r1)= population(randomIndividual).cityOrder(r2);
            population(randomIndividual).cityOrder(r2) = temp;
        else
            %ROTATE
            population(randomIndividual).cityOrder(r1:r2)= flip(population(randomIndividual).cityOrder(r1:r2));
        end
        
    end
return
end