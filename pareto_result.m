%load('pareto_result_sym (n=140,ga).mat')

%% CALC FVALS
figure(1)
f_vals=[];
for i=[1:1:11]%resp 11
    %%results
    subplot(3,4,i)%resp 3,4
    plotter(pareto(i,:))
    view([0 0 1])
    title("p=" + 0.1*(i-1))%resp 0.1
    f_vals=[f_vals;modelito(pareto(i,:),0),modelito(pareto(i,:),1)];
end

%% PLOT
figure(2)
plt=plot(f_vals(:,1),f_vals(:,2),"LineWidth", 2);

row = dataTipTextRow('p=',[0:0.1:1]);%resp 0.1
plt.DataTipTemplate.DataTipRows(1).Label = 'eps';
plt.DataTipTemplate.DataTipRows(2).Label = 'Im';
plt.DataTipTemplate.DataTipRows(end+1) = row;


ylabel('$$\tilde{Im}$$','Interpreter','Latex', 'FontSize', 16)
xlabel('$$\tilde{\epsilon}$$','Interpreter','Latex', 'FontSize', 16)
