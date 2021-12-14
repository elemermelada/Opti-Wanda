options = optimoptions('fmincon');
options = optimoptions(options,'Display', 'iter-detailed');
x = fmincon(@modelito,x,[],[],[],[],res(:,1),res(:,2),[],options)