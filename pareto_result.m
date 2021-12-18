load('pareto_result_sym.mat')
figure(1)
f_vals=[];
for i=[1:11]
    %%results
    subplot(3,4,i)
    plotter(pareto(i,:))
    view([0 0 1])
    title("p=" + 0.1*(i-1))
    f_vals=[f_vals;modelito(pareto(i,:),0),modelito(pareto(i,:),1)];
end
figure(2)
for i=[1:11]
    plot(f_vals(:,1),f_vals(:,2))
    ylabel('$$\tilde{Im}$$','Interpreter','Latex', 'FontSize', 16)
    xlabel('$$\tilde{\epsilon}$$','Interpreter','Latex', 'FontSize', 16)
end