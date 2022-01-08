%% INIT
clear
close all
clc

run("ctes.m");
x0=[0.01,4.712389007179587,1.0,1.0471976,3.1415927000000003,1.0,2.0943951,3.1415927000000003,1.0,3.1415927,1.5707962999999996,1.0,4.1887902,0.01,1.0,5.2359878,0.01,1.0];
x0_sym=[0.0100    4.7124    1.0000 1.0472    3.1416    1.0000];

PopulationSize_Data = 20; % numero de miembros que forman la poblacion
    
FunctionTolerance_Data = 1e-6; % tolerancia usada en la funcion
ConstraintTolerance_Data = 1e-4; %tolerancia usada en la constrain

options = optimoptions('fmincon');
options = optimoptions(options,'Display', 'iter-detailed');
options = optimoptions(options,'UseParallel', true);

options_ga = optimoptions('ga');
options_ga = optimoptions(options_ga,'PopulationSize', PopulationSize_Data);
options_ga = optimoptions(options_ga,'UseParallel', true);
options_ga = optimoptions(options_ga,'FunctionTolerance', FunctionTolerance_Data);
options_ga = optimoptions(options_ga,'ConstraintTolerance', ConstraintTolerance_Data);
options_ga = optimoptions(options_ga,'Display', 'diagnose');
options_ga = optimoptions(options_ga,'PlotFcn', {  @gaplotbestf @gaplotbestindiv @gaplotdistance @gaplotexpectation @gaplotgenealogy @gaplotrange @gaplotscorediversity @gaplotscores @gaplotselection @gaplotstopping @gaplotmaxconstr });

options_ps = optimoptions('paretosearch');
options_ps = optimoptions(options_ps,'UseParallel', true);
options_ps = optimoptions(options_ps,'Display', "diagnose");
options_ps = optimoptions(options_ps,'UseVectorized', true);

pareto = [];

%% FMINCON CASO GENERAL
for p = [0.75]
    f_param = @(x) modelito(x,p);
    x = fmincon(f_param,x0,[],[],[],[],res(:,1),res(:,2),[],options);
    pareto = [pareto;x];
end

%% FMINCON CASO SIMÉTRICO
tic
%x0=[0.352733063479383	4.49557244386181	0.862905273425334	1.12758970936535	3.24342681639821	0.867682254510807]; %n=150
for n_F=[150]
for p = [.0:.1:1]
    %n_F-100 + p*9                               %progreso
    f_param = @(x) modelito_sym(x,[p,1-p,0,0],n_F);
    x = fmincon(f_param,x0_sym,[],[],[],[],res_sym(:,1),res_sym(:,2),[],options);

%     postes=reshape(x, 3, [])';
%     postes_sym=[];
%     for poste=postes'   %añadir los simétricos
%         tmp=symm(poste',w,l,h,R);
%         %tmp=reshape(tmp, 3, 4)';
%         postes_sym=[postes_sym,tmp];
%     end
%     postes=postes_sym;  %aquí no ha pasado nada
% 
%     pareto = [pareto;postes];

    pareto=[pareto;n_F,p,x];

end
end
toc

%% GENETIC ALGORITHM
options_ga = optimoptions(options_ga,'MaxGenerations', 100*18);
options_ga = optimoptions(options_ga,'InitialPopulationMatrix', x0);
for p = [0:0.1:1]
    f_param = @(x) modelito(x,p);
    [x_ga,fval,exitflag,output,population,score] = ...
    ga(f_param,18,[],[],[],[],res(:,1),res(:,2),[],[],options_ga);
    pareto = [pareto;x];
end

%% GENETIC ALGORITHM CASO SIMÉTRICO
options_ga = optimoptions(options_ga,'MaxGenerations', 300);
options_ga = optimoptions(options_ga,'InitialPopulationMatrix', x0_sym);
for n_F=[100,110,130,140,160,180,190,200]
for p = [0:0.1:1]
    p*100 + "%"
    f_param = @(x) modelito_sym(x,[p,1-p,0,0],120);
    [x_ga,fval,exitflag,output,population,score] = ...
    ga(f_param,6,[],[],[],[],res_sym(:,1),res_sym(:,2),[],[],options_ga);

    postes=reshape(x_ga, 3, [])';
    postes_sym=[];
    for poste=postes'   %añadir los simétricos
        tmp=symm(poste',w,l,h,R);
        %tmp=reshape(tmp, 3, 4)';
        postes_sym=[postes_sym,tmp];
    end
    postes=postes_sym;  %aquí no ha pasado nada

    pareto = [pareto;postes];
end
save("autopareto" + n_F,"pareto");
end

%% PARETO SEARCH SIMÉTRICO (NOT WORKING)
f_param = @(x) [modelito_sym(x,[0,1,0,0]),modelito_sym(x,[1,0,0,0])];
x=paretosearch(f_param,6,[],[],[],[],res_sym(:,1),res_sym(:,2),[],options_ps);