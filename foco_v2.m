close all
clear

%% PARÁMETROS DEL FOCO
global h;
h=40;           %altura
I0=100;         %intensidad base

%% PARÁMETROS DEL CAMPO
w=70;           %ancho
l=100;          %largo

%% MAPA DE COLOR
cmap=[];
for i = [0:0.02:1]
    cmap =[cmap;ones(1,3)*i];
end

%% EJECUCIÓN DEL MODELO

%dimensiones del campo
[X,Y] = meshgrid(-l/2:1:l/2,-w/2:1:w/2);

%% plots de iluminación
figure(1)
Z=fz(X,Y,0,-w/2,0,0.9,1,1000);
Z2=fz(X,Y,0,w/2,pi,0.9,1,1000);
Z3=fz(X,Y,-l/2,0,pi/2,0.4,2,100);
Z4=fz(X,Y,+l/2,0,-pi/2,0.4,2,100);

Z5=fz(X,Y,+l/2,+w/2,-(pi/2+pi/6),0.9,1,1000);
Z6=fz(X,Y,+l/2,-w/2,-(pi/2-pi/6),0.9,1,1000);
Z7=fz(X,Y,-l/2,+w/2,+(pi/2+pi/6),0.9,1,1000);
Z8=fz(X,Y,-l/2,-w/2,(pi/2-pi/6),0.9,1,1000);

surf(X,Y,(Z+Z2+Z5+Z6+Z7+Z8));
%hold on
%x0=0+h*sin(0)/tan(0.9);
%y0=-w/2+h*cos(0)/tan(0.9);
%scatter3(x0,y0,0.0);

colormap(cmap);
caxis([0 max(max(Z+Z2+Z5+Z6+Z7+Z8))])
set(gca,'DataAspectRatio',[1 1 max(max(Z))/30])

figure(2)
range = [0:0.2:90];
[m,n] = size(range);
for i=[0.001:0.01:0.8]
plot(range,fz(zeros(1,n),range,0,0,0,i,1,100));
hold on
end

%% plots de la espectometría
figure(3)

subplot(2,2,1)
range=[0:0.01:2*pi];
for i=[8,100,10000]
  polar(range,fi(cos(range),1,i))
  hold on
end
legend(["m=8";"m=100";"m=10000"])
title("n=1")

subplot(2,2,2)
range=[0:0.01:2*pi];
for i=[0.5,1,3]
  polar(range,fi(cos(range),i,100))
  hold on
end
legend(["n=0.5";"n=1";"n=3"])
title("m=100")

subplot(2,2,3)
range=[0:0.01:2*pi];
for i=[2,100,1000]
  polar(range,fi2(cos(range),10,i))
  hold on
end
legend(["m=100";"m=1000";"m=10000"])
title("n=10")

subplot(2,2,4)
range=[0:0.01:2*pi];
for i=[1,2,5]
  polar(range,fi2(cos(range),i,1000))
  hold on
end
legend(["n=1";"n=2";"n=5"])
title("m=1000")


%% DEFINICIÓN DE FUNCIONES

%devuelve el coseno de desviación del chorro
function cosalf = fca(x,y,xa,ya,th,g)
  
  global h;
  
  x0=xa+h*sin(th)/tan(g);
  y0=ya+h*cos(th)/tan(g);
  
  d02=h^2+(x0-xa)^2+(y0-ya)^2;
  d2=h^2+(x-xa).^2+(y-ya).^2;
  r2=(x0-x).^2+(y0-y).^2;

  d02=d02;
  d2=d2;
  r2=r2;
  
  cosalf=(d2+d02-r2)./(2*sqrt(d02).*sqrt(d2));
  
end

%devuelve intensidad (photometría)
function I = fi(cosalf,n,m)
  
  I=atan((cosalf.^n-0.5)*m)/pi+0.5;
  I=max(I,0);
  
end

%devuelve intensidad (photometría)
function I = fi2(cosalf,n,m)
  
  I=(atan((cosalf.^n-0.5)*m)/pi+0.5);
  I=max(I./(cosalf+0.05),0);
  I=min(I,2);
  
end

%devuelve intensidad final
function z = fz(x,y,xa,ya,th,g,n,m)
  
  global h
  
  d2=h^2+(x-xa).^2+(y-ya).^2;
  d2=d2;

  cosalf=fca(x,y,xa,ya,th,g);
  I=fi2(cosalf,n,m);
  
  z=I*h./(sqrt(d2)).^3;
  
end