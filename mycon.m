% function [c,ceq]=mycon(x)
% %p=1
% n_F=100;
% f0=0.0952839; %0.343422 0.0952839,10.190785,1.08; 
% c=-(1.1*f0-modelito_sym(x,[0,1,0,0],n_F));
% ceq=[];
% end

function [c,ceq]=mycon(x)
% p=0
n_F=100;
f0=0.0952839; %0.343422 0.0952839,10.190785,1.08; 
c=modelito_sym(x,[0,1,0,0],n_F)-1.1*f0;
ceq=[];
end