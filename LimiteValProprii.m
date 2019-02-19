function [limita_inf, limita_sup] = LimiteValProprii(d, s)
  n = length(d);
  
  % supradiagonala si subdiagonala sunt
  % aduse la aceeasi dimensiune cu diagonala
  ds = [s; 0];
  di = [0; s];
  
  % calculare ti ca fiind suma elementelor de pe 
  % aceeasi linie ale ds si di luate in valoare absoluta
  ti(1:n) = abs(ds(1:n)) + abs(di(1:n));
  
  % calulare limina minima si maxina
  limita_inf = min(d(1:n) - ti(1:n)');
  limita_sup = max(d(1:n) + ti(1:n)');
endfunction