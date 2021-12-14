function eps = intensidad_s(I_0,I_m,postes,R,h,w,l,m1,m2)

    f_I = @(x,y) 0;
    
    for poste = postes'
        poste=poste';
        chi=poste(1);
        th=poste(2);
        g=poste(3);

        [xa ya] = coord_postes(chi,w,l,h,R);
        
        f_I = @(x,y) (f_I(x,y) + I_0*foco(x,y,xa,ya,th,g,h,m1,m2));
    end

    f2=@(x,y) I_m;
    %f2=@(x,y) 1.218797480267127e+06;
    f_I=@(x,y) (f_I(x,y)-f2(x,y));
    f_I=@(x,y) f_I(x,y).*f_I(x,y);

    eps=integral2(f_I,-l/2,l/2,-w/2,w/2,"Method","iterated");
    eps=sqrt(eps);

end