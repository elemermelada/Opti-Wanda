for i=[180]

    load("autopareto" + i + ".mat");
    pareto=pareto(end-10:end,:);
    save("pareto_result_sym (n=" + i + ",ga).mat","pareto")

end

%% Concat
con=[];
for i=[100:10:180]

    load("pareto_result_sym (n=" + i + ",ga).mat")
    con=[con;pareto];

end

pareto = con;