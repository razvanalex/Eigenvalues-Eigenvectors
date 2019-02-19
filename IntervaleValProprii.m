function r = IntervaleValProprii(d, s, m)
  % verifica m <= length(d)
  if m > length(d);
    m = length(d);
  endif
  
  [limita_inf limita_sup] = LimiteValProprii(d,s);
  r(1) = limita_inf;
  r(m+2) = limita_sup;
  
  for k = m : -1 : 1
    % se calculeaza mijlocul
    mij = (r(k+2) + r(1))/2;
    % se calculeaza lungimea intervalului
    h = r(k+2) - mij;
    % se calculeaza nr de valori proprii mai mici ca mij
    numvp = NrValProprii(d, s, mij); 
    % se actualizeaza mijlocul
    while numvp != k 
        h = h / 2; 
      if numvp < k 
        mij = mij + h ;
      elseif numvp > k
        mij = mij - h;
      endif
      numvp = NrValProprii(d, s, mij);
    endwhile
    r(k+1) = mij;
  endfor
  
  % se returneaza vectorul r
  r = r(1:m+1);
endfunction
