%% CTES DEL PROBLEMA
%mecánicas
r = 0.1;                %m
R = 2.5;                %m
rho=1.225;              %kg/m^3
Cd=1.28;                %COEFICIENTE DE DRAG
V=52;                   %m/s
S_1 = 0.0675;           %m^2
W_1 = 3*9.81;           %N
rho_acero = 7850;       %kg/m^3
Rp02 = 235*10^6;        %Pa
%energéticas
P_1 = 150;              %W
eta_lum = 110;          %lm/W
eta_luz = 0.9;          %EFICIENCIA ENERGÉTICA
%dimensiones del campo
w = 70;                 %m
l = 100;                %m
%distribución intensidad lumínica
m1 = 3;
m2 = 30;

%% VALORES DE REFERENCIA
P_reff=100000;          %W
t_reff=0.005;           %m
I_reff=14*10^6;         %lm

%% PARÁMETROS
h=10;                   %m
Np=6;                   %Nº DE POSTES

%% VARIABLES
n=1;                  %Nº DE LUCES POR POSTE
postes=[0	0	0	1.5];

%% OBJETIVOS
t=visibilidad(n,h,r,R,rho,Cd,V,S_1,W_1,rho_acero,Rp02);
P=potencia(n,Np,P_1,eta_luz);
I_m=intensidad_m(eta_lum*P_1*n,postes,h,w,l,m1,m2);
eps=intensidad_s(eta_lum*P_1*n,I_m,postes,h,w,l,m1,m2);

t_adim = t/t_reff;
P_adim = P/P_reff;
I_adim = -(I_m/I_reff-1);
eps_adim = eps/I_reff;

%% OPTIMIZADOR