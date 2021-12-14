%devuelve intensidad (photometría)
function I = fi(cosalf,n,m)
  
  I=atan((cosalf.^n-0.5)*m)/pi+0.5;
  I=max(I,0)/1.4010;
  %I=max(I,0).*(sign(cosalf)+1)/2/1.4010;
  
  
end