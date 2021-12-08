%devuelve intensidad (photometría)
function I = fi2(cosalf,n,m)
  
  I=(atan((cosalf.^n-0.5)*m)/pi+0.5);
  I=max(I./(cosalf+0.05),0);
  I=min(I,2);
  
end