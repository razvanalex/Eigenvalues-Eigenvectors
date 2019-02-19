function P = ValoriPolinoame(d, s, val_lambda)
  n = length(d);
  % initializare P0, P1
  P0 = 1;
  P1 = d(1) - val_lambda;
  
  % adaugare primele 2 valori in vectorul P
  P(1) = P0;
  P(2) = P1;
  
  % realizare recusivitate
  for i = 2:n
    P(i+1) = (d(i) - val_lambda) * P1 - s(i - 1)^2 * P0;
    P0 = P1;
    P1 = P(i+1);
  endfor
endfunction