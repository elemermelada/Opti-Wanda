function postes = symm(p,w,l,h,R)

%     deg2rad = pi/180;
%     w_luces = w+2*(h+R)/tan(75*deg2rad);
%     l_luces = l+2*(h+R)/tan(75*deg2rad);
%     chi_esquina = atan(w_luces/l_luces);
    chi=p(1);
    th=p(2);
    g=p(3);

    %% para todo chi

    th3 = pi+th;
    p3 = [pi+chi,th3,g];

    th4 = pi-th;
    if th4 < 0
        th4=th4+2*pi;
    end
    p4 = [2*pi-chi,th4,g];

    th2 = pi+th4;
    p2 = [pi-chi,th2,g];

    postes=[p,p2,p3,p4];

end