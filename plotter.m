postes=reshape(x_ga, 3, Np)';

[X,Y] = meshgrid(-l/2:1:l/2,-w/2:1:w/2);

f_I = @(x,y) 0;

for poste = postes'
    poste=poste';
    chi=poste(1);
    th=poste(2);
    g=poste(3);

    [xa ya] = coord_postes(chi,w,l,h,R);
    f_I = @(x,y) (f_I(x,y) + foco(x,y,xa,ya,th,g,h,m1,m2));
end

%% plots de iluminación
%figure(1)
Z=f_I(X,Y);

surf(X,Y,Z);