%% INIT
run("ctes.m");
nvars = 18; %numero de varibles que usa
PopulationSize_Data = 20; % numero de miembros que forman la poblacion
MaxGenerations_Data = nvars*100; % numero max de generaciones
FunctionTolerance_Data = 1e-6; % tolerancia usada en la funcion
ConstraintTolerance_Data = 1e-4; %tolerancia usada en la constrain

x0=[0.01,4.712389007179587,1.0,1.0471976,3.1415927000000003,1.0,2.0943951,3.1415927000000003,1.0,3.1415927,1.5707962999999996,1.0,4.1887902,0.01,1.0,5.2359878,0.01,1.0];

%% FMINCON
options = optimoptions('fmincon');
options = optimoptions(options,'Display', 'iter-detailed');
options = optimoptions(options,'UseParallel', true);

pareto = [];

for p = [0.75]
    f_param = @(x) modelito(x,p);
    x = fmincon(f_param,x0,[],[],[],[],res(:,1),res(:,2),[],options);
    pareto = [pareto;x];
end

%% GENETIC ALGORITHM
options_ga = optimoptions('ga');
options_ga = optimoptions(options_ga,'PopulationSize', PopulationSize_Data);
options_ga = optimoptions(options_ga,'MaxGenerations', MaxGenerations_Data);
options_ga = optimoptions(options_ga,'InitialPopulationMatrix', x0);
options_ga = optimoptions(options_ga,'UseParallel', true);
options_ga = optimoptions(options_ga,'FunctionTolerance', FunctionTolerance_Data);
options_ga = optimoptions(options_ga,'ConstraintTolerance', ConstraintTolerance_Data);
options_ga = optimoptions(options_ga,'Display', 'diagnose');
%options_ga = optimoptions(options_ga,'PlotFcn', {  @gaplotbestf @gaplotbestindiv @gaplotdistance @gaplotexpectation @gaplotgenealogy @gaplotrange @gaplotscorediversity @gaplotscores @gaplotselection @gaplotstopping @gaplotmaxconstr });

[x_ga,fval,exitflag,output,population,score] = ...
ga(@modelito,nvars,[],[],[],[],res(:,1),res(:,2),[],[],options_ga);