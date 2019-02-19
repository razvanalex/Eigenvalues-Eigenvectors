function [valp vecp] = PutereInv(d, s, h, y, maxIter, tol)
  n = length(d);
  iter = maxIter;
  while maxIter > 0
    maxIter--;
    % se calculeaza noua diagonala
    d_h(1:n) = d(1:n) - h;
    % se aplica Thomas pentru a afla solutiile
    z = Thomas(s',d_h',s',y);
    % se normalizeaza rezultatul
    y = z / norm(z) ;
    
    % se calculeaza valorile proprii si valorile proprii prin y'* A * y
    suma =0;
    for i = 2:n-1
      suma += y(i) * (y(i-1) * s(i-1) + y(i) * d(i) + y(i + 1) * s(i));
    endfor
    valp =  y(1) * (y(1)*d(1) + y(2)*s(1)) + y(n) * (y(n-1) * s(n-1) + y(n) * d(n)) + suma;
    vecp = y;
    
    % se mareste viteza de convergenta a metodei
    h = valp;
    
    % se calculeaza A * y - lambda * y
    for i = 2:n-1
      a(i + 1) = y(i-1) * s(i-1) + y(i) * d(i) + y(i + 1) * s(i) - valp * y(i);
    endfor
    a(1) = y(1)*d(1) + y(2)*s(1) - valp * y(1);
    a(n) = y(n-1) * s(n-1) + y(n) * d(n) - valp * y(n);
    
    % contidia de atingere a preciziei
    if norm(a) < tol
      break;
    endif
    
  endwhile
  iter = iter - maxIter;
endfunction

function x = Thomas(a, b, c, d)
	n = length(d);
 
  %transform a astfel incat sa aiba n elemente, cu primul element 0
 	a = [0; a];

	% Operatiile la limita;
	c(1) = c(1)/b(1); 
	d(1) = d(1)/b(1);   
 	
 	% calculul coeficientilor pe caz general.
	for i = 2 : n-1
		temp = b(i)-a(i)*c(i-1);
		c(i) = c(i)/temp;
		d(i) = (d(i)-a(i)*d(i-1))/temp;
	endfor
	d(n) = (d(n)-a(n)*d(n-1))/(b(n)-a(n)*c(n-1));
 
	% Substitutia inapoi pentru rezolvarea sistemului de ecuatii
	x(n) = d(n);
	for i = n-1 : -1 : 1
		x(i) = d(i)-c(i)*x(i+1);
	endfor
  x=x';
endfunction

