% n=[1:100]
% h=30

% plot(n, f_t(n,h,r,R,rho,Cd,V,S_1,W_1,rho_acero,Rp02))

function t = visibilidad(n,h,r,R,rho,Cd,V,S_1,W_1,rho_acero,Rp02)

    D = 0.5*rho*(n*S_1)* V^2 * Cd;
    M_y = W_1*n*R + D*(R+h);
    sigmax_max = 0.85*Rp02;

    syms t;
    W_p = pi*((r+t)^2 - r^2)*(h + pi/2*r) * rho_acero;
    eqn=[abs(-4/pi * M_y / ((t+r)^4 - r^4) *r + (W_p + W_1*n)/((r+t)^2 - r^2))==sigmax_max];

    sol=double(solve(eqn,t));
    t=0;

    for el=sol'
        if imag(el)==0
            if real(el)>t
                t=el;
            end
        end
    end
 
end