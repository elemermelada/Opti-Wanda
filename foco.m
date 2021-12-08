%devuelve intensidad final
function z = foco(x,y,xa,ya,th,g,h,n,m)
  
  d2=h^2+(x-xa).^2+(y-ya).^2;

  cosalf=fca(x,y,xa,ya,th,g,h);
  I=fi(cosalf,n,m);
  
  z=I*h./(sqrt(d2)).^3;
  
end