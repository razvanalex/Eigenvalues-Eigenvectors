function vp = CalculezValProprii(d, s, m, tol)
  % verifica m <= length(d)
  if m > length(d);
    m = length(d);
  endif
  
  % se calculeaza intervalele in care se gasesc
  % valori proprii
  r = IntervaleValProprii(d, s, m);
  
  % se calculeaza valorile proprii prin metoda 
  % bisectiei
  for i = 1 : m
    vp(i) = Bisectie_ValP(r(i), r(i+1), d, s, @Pn, tol);
  endfor
endfunction

% functie ce calculeaza valoarea polinomului
% caracteristic in x.
function p = Pn(d, s, x)
  p = ValoriPolinoame(d, s, x);
  p = p(length(p));
endfunction

% Functie care calculeaza folosind metoda bisectiei
% valorile proprii dintr-un interval
function p = Bisectie_ValP(a, b, d, s, f, tol)
  p = a + (b - a)/2;
  while abs(f(d, s, p)) > tol && abs(b-a) > tol
    if f(d, s, a) * f(d, s, p) < 0
      b = p;
    else 
      a = p;
    endif
    p = a + (b - a) / 2;
  endwhile
endfunction
