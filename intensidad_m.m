function I_m = intensidad_m(I_0,postes,h,w,l,m1,m2)

    f_I = @(x,y) 0;
    
    for poste = postes'
        poste=poste';
        xa=poste(1);
        ya=poste(2);
        th=poste(3);
        g=poste(4);
        f_I = @(x,y) (f_I(x,y) + I_0*foco(x,y,xa,ya,th,g,h,m1,m2));
    end
    
    I_m=integral2(f_I,-l/2,l/2,-w/2,w/2,"Method","iterated");

end