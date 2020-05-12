clear
global n
for n=1:30
 load D2 distance
 %load data_D data_D
 %distance=data_D;
 cities = max(size(distance));
%type create_permutations.m
%type crossover_permutation.m
%type mutate_permutation.m
%type D2_fitness.m
%type selectionroulette.m
  temp=zeros(cities+n);
  temp(1:cities,1:cities)=distance;
 for i=1:n
   temp(cities+i,:)=[distance(1,:),ones(1,n)*9999];
   temp(cities+i,1)=9999;
   temp(:,cities+i)=temp(cities+i,:)';
 end
  cities=cities+n-1; 
  distance=temp;
 FitnessFcn = @(x) D2_fitness(x,distance);
 %FitnessFcn = @(x) traveling_salesman_fitness(x,distance);
 options = gaoptimset('PopulationType', 'custom','PopInitRange',[1;cities]);
 options = gaoptimset(options,'CreationFcn',@create_permutations, ...
                             'CrossoverFcn',@crossover_permutation, ...
                             'MutationFcn',@mutate_permutation, ...
                             'SelectionFcn',@selection_roulette,...
                             'Generations',1000,'PopulationSize',100*cities, ...
                             'StallGenLimit',200,'StallTimeLimit', 100,...
                             'Vectorized','on');
 numberOfVariables = cities;
 [x,fval,reason,output] = ga(FitnessFcn,numberOfVariables,options);
 n
     if fval<9999
      x
      fval
   end
end

