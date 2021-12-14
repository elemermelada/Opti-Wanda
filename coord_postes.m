function [xa,ya] = coord_postes(chi,w,l,h,R)

    deg2rad = pi/180;
    w_luces = w+2*(h+R)/tan(75*deg2rad);
    l_luces = l+2*(h+R)/tan(75*deg2rad);

    chi_esquina = atan(w_luces/l_luces);
        xa = l_luces/2;
        ya = xa*tan(chi);
    if (chi_esquina < chi)&&(chi <= pi - chi_esquina)
        ya = w_luces/2;
        xa = ya/tan(chi);
    elseif (pi - chi_esquina < chi)&&(chi <= pi + chi_esquina)
        xa = -l_luces/2;
        ya = xa*tan(chi);
    elseif (pi + chi_esquina < chi)&&(chi <= 2*pi - chi_esquina)
        ya = -w_luces/2;
        xa = ya/tan(chi);
    end

end
