options = optimoptions('fmincon');
options = optimoptions(options,'Display', 'iter-detailed');

x0=[0.01,4.712389007179587,1.0,1.0471976,3.1415927000000003,1.0,2.0943951,3.1415927000000003,1.0,3.1415927,1.5707962999999996,1.0,4.1887902,0.01,1.0,5.2359878,0.01,1.0];

x = fmincon(@modelito,x0,[],[],[],[],res(:,1),res(:,2),[],options)