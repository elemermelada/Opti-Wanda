m1=3;
m2=30;
h=10;

th = [0:0.01:2*pi];
%polarplot(th,fi(cos(th),m1,m2));

postes=[0	0	0	pi/2];
%dimensiones del campo
[X,Y] = meshgrid(-l/2:1:l/2,-w/2:1:w/2);


    f_I = @(x,y) 0;
    
    for poste = postes'
        poste=poste';
        xa=poste(1);
        ya=poste(2);
        th=poste(3);
        g=poste(4);
        f_I = @(x,y) (f_I(x,y) + foco(x,y,xa,ya,th,g,h,m1,m2));
    end

%% plots de iluminación
%figure(1)
Z=f_I(X,Y);

surf(X,Y,Z);
integral2(f_I,-100000000,100000000,-100000000,10000000)/n

y=[]
for i =[0:0.02:pi]
postes=[0	0	0	i];
    f_I = @(x,y) 0;
    
    for poste = postes'
        poste=poste';
        xa=poste(1);
        ya=poste(2);
        th=poste(3);
        g=poste(4);
        f_I = @(x,y) (f_I(x,y) +foco(x,y,xa,ya,th,g,h,m1,m2));
    end
y=[y integral2(f_I,-10000,10000,-10000,10000,Method="iterated")]
end

plot(0:0.02:pi,y)