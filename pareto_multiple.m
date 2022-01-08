%% INIT

close all
load('pareto_result_sym (n,p).mat')
pareto_ext = [];
leg=pareto(:,[1,2]);
pareto_simp=pareto(:,3:end);

%% LUMINARIAS
for el=pareto_simp'
    postes=reshape(el', 3, [])';
    postes_sym=[];
    for poste=postes'   %añadir los simétricos
        tmp=symm(poste',w,l,h,R);
        tmp=reshape(tmp, 3, 4)';
        postes_sym=[postes_sym;tmp];
    end
    postes=reshape(postes_sym',1,[]);  %aquí no ha pasado nada
    pareto_ext=[pareto_ext;postes];
end

for n=100:10:200
    figure(n)
    for p=0:0.1:1
        subplot(3,4,p*10+1)
        %(n-100)*11+p*10+1
        plotter(pareto_ext(round((n-100)/10*11+p*10+1),:))
        title("p=" + p)
    end
end

%% PARETO
figure(101)
for n=100:10:200
    f_val=[];
    for p=0:0.1:1
        f_val=[f_val;modelito_sym(pareto_simp(round((n-100)/10*11+p*10+1),:),[1,0,0,0],100),modelito_sym(pareto_simp(round((n-100)/10*11+p*10+1),:),[0,1,0,0],100)];
    end
    f_val
    figure(101)
    subplot(3,4,round((n-100)/10)+1)
    plt=plot(f_val(:,1),f_val(:,2));
    row = dataTipTextRow('p=',[0:0.1:1]);
    plt.DataTipTemplate.DataTipRows(1).Label = 'eps';
    plt.DataTipTemplate.DataTipRows(2).Label = 'Im';
    plt.DataTipTemplate.DataTipRows(end+1) = row;
    title("n="+n)
    drawnow
end