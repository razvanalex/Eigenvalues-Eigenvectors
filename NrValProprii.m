function numvp = NrValProprii(d, s, val_lambda)
  numvp = 0;
  n = length(d);
  % Generare valori P(val_lambda)
  P = ValoriPolinoame(d,s,val_lambda);
  for i=1:n
    % stabilire semn pentru P(i+1) = 0
    if P(i) > 0 && P(i + 1) == 0
      % P(i) > 0 => P(i+1) < 0
      P(i+1)--;
    elseif P(i) < 0 && P(i + 1) == 0
      % P(i) < 0 => P(i+1) > 0
      P(i+1)++;
    endif
    % comparare semne
    if ((P(i) > 0 && P(i + 1) < 0) ||
        (P(i) < 0 && P(i + 1) > 0))
      numvp++;
    endif 
  endfor
endfunction