%devuelve el coseno de desviación del chorro
function cosalf = fca(x,y,xa,ya,th,g,h)
  
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