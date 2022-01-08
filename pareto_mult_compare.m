%% INIT

close all
load('pareto_result_sym (n,p).mat')
pareto_ext = [];
leg=pareto(:,[1,2]);
pareto_simp=pareto(:,3:end);

pareto_ga=load('pareto_result_sym (n,p,ga).mat').pareto;
pareto_ga=pareto_ga(:,[1,2,3,13,14,15]);

%% LUMINARIAS
% for el=pareto_simp'
%     postes=reshape(el', 3, [])';
%     postes_sym=[];
%     for poste=postes'   %añadir los simétricos
%         tmp=symm(poste',w,l,h,R);
%         tmp=reshape(tmp, 3, 4)';
%         postes_sym=[postes_sym;tmp];
%     end
%     postes=reshape(postes_sym',1,[]);  %aquí no ha pasado nada
%     pareto_ext=[pareto_ext;postes];
% end
% 
% for n=100:10:200
%     figure(n)
%     for p=0:0.1:1
%         subplot(3,4,p*10+1)
%         %(n-100)*11+p*10+1
%         plotter(pareto_ext(round((n-100)/10*11+p*10+1),:))
%         title("p=" + p)
%     end
% end

%% PARETO
figure(101)
for n=100:10:180
    f_val=[];
    f_val_ga=[];
    for p=0:0.1:1
        f_val=[f_val;modelito_sym(pareto_simp(round((n-100)/10*11+p*10+1),:),[1,0,0,0],n),modelito_sym(pareto_simp(round((n-100)/10*11+p*10+1),:),[0,1,0,0],n)];
        f_val_ga=[f_val_ga;modelito_sym(pareto_ga(round((n-100)/10*11+p*10+1),:),[1,0,0,0],n),modelito_sym(pareto_ga(round((n-100)/10*11+p*10+1),:),[0,1,0,0],n)];
    end
    f_val
    figure(101)
    subplot(3,4,round((n-100)/10)+1)
    plt=plot(f_val(:,1),f_val(:,2));
    row = dataTipTextRow('p=',[0:0.1:1]);
    plt.DataTipTemplate.DataTipRows(1).Label = 'Im';
    plt.DataTipTemplate.DataTipRows(2).Label = 'eps';
    plt.DataTipTemplate.DataTipRows(end+1) = row;
    hold on
    subplot(3,4,round((n-100)/10)+1)
    plt=plot(f_val_ga(:,1),f_val_ga(:,2));
    row = dataTipTextRow('p=',[0:0.1:1]);
    plt.DataTipTemplate.DataTipRows(1).Label = 'Im';
    plt.DataTipTemplate.DataTipRows(2).Label = 'eps';
    plt.DataTipTemplate.DataTipRows(end+1) = row;

    title("n="+n)
    xticks(-0.5:0.25:1)
    yticks(0:0.25:1)
    xlabel('$$\tilde{Im}$$','Interpreter','Latex', 'FontSize', 16)
    ylabel('$$\tilde{\epsilon}$$','Interpreter','Latex', 'FontSize', 16)
    axis equal
    xlim([-0.5,1])
    ylim([0,1])
    plot([0,0],[0,1],"LineStyle","--","Color",[0.5,0.5,0.5])
    drawnow
end