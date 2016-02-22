function PoissonTrain = generatePoisson()
p = 1*10^-3;    
temp = rand(1,1);
if temp<p
    PoissonTrain = 1;
else
    PoissonTrain = 0;
end
    
end