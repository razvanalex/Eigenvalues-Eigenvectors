function Tema2MN(nume)
	% Functie in care sunt apelate cerintele 1-6 iar rezultatele cerintelor sunt scrise in fisierul nume.out
	% Intrari:
	% -> nume: numele fisierului de intrare/iesire.

	% deschidere fisier de intrare
	fid_in = fopen(strcat('in/', strcat(nume, '.in')), 'r');

	%%% citire dimensiune matrice tridiagonala simetrica
	n = fscanf(fid_in, '%d', 1);
	%%% citire diagonala principala asociata matricei tridiagonale simetrice
	d = fscanf(fid_in, '%f', n);
	%%% citire supradiagonala asociata matricei tridiagonale simetrice
	s = fscanf(fid_in, '%f', n-1);
	
	%%% citire numar de valori lambda considerate
	dim_vector_lambda = fscanf(fid_in, '%d', 1);
	%%% citire vectori de valori lambda
	vector_lambda = fscanf(fid_in, '%f', dim_vector_lambda);
	
	%%% citire dimensiune vector ce contine valori pentru limita m considerata la Cerintele 4 si 5
	dim_vector_m = fscanf(fid_in, '%d', 1);
	%%% citire vector cu valori pentru limita m considerata la Cerintele 4 si 5
	vector_m = fscanf(fid_in, '%d', dim_vector_m);
	
	%%% citire valori de deplasare utilizate la Cerinta 6
	dim_vector_deplasare = fscanf(fid_in, '%d', 1);
	vector_deplasare = fscanf(fid_in, '%f', dim_vector_deplasare);
			
	%%% constanta utilizata la Cerintele 5 si 6
	epsilon = 0.00000001;

	%%% constanta utilizata la Cerinta 6
	max_iter = 100;
	
	% inchidere fisier de intrare
	fclose(fid_in);

	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 1
	%%% ------------------------------------------------------------------------------------------------------------
	if (fid_aux = fopen('ValoriPolinoame.m', 'r')) ~= -1
		fclose(fid_aux);

		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta1', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 1\n');

		% afisare dimensiune matrice tridiagonala simetrica
		fprintf(fid_out, '%d ', n);

		% afisare numar de valori lambda considerate
		fprintf(fid_out, '%d\n', dim_vector_lambda);

		for i = 1 : dim_vector_lambda
			% apelare cerinta 1
			P = ValoriPolinoame(d, s, vector_lambda(i));

			% afisare valoare lambda curenta
			fprintf(fid_out, '%f\n', vector_lambda(i));

			% afisare vector P
			for j = 1 : length(P)
				if j == 1
						fprintf(fid_out, '%f', P(j));
				else
					fprintf(fid_out, ' %f', P(j));
				endif
			endfor
			
			fprintf(fid_out, '\n');
		endfor
		
		% inchidere fisier de iesire
		fclose(fid_out);
	endif
	
	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 2
	%%% ------------------------------------------------------------------------------------------------------------

	if (fid_aux = fopen('NrValProprii.m', 'r')) ~= -1
		fclose(fid_aux);
	
		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta2', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 2\n');

		%%% afisare numar de valori lambda considerate
		fprintf(fid_out, '%d\n', dim_vector_lambda);

		for i = 1 : dim_vector_lambda
			% apelare cerinta 2
			numvp = NrValProprii(d, s, vector_lambda(i));
			
			% afisare valoare lambda curenta si rezultat functie NrValProprii
			
			fprintf(fid_out, '%f\n%d\n', vector_lambda(i), numvp);
		endfor
		
		% inchidere fisier de iesire
		fclose(fid_out);
	endif
	
	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 3
	%%% ------------------------------------------------------------------------------------------------------------

	if (fid_aux = fopen('LimiteValProprii.m', 'r')) ~= -1
		fclose(fid_aux);

		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta3', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 3\n');

		% apelare cerinta 3
		[limita_inf, limita_sup] = LimiteValProprii(d, s);
		
		% afisare limite incadratoare pentru valorile proprii ale matricei tridiagonale simetrice 
		fprintf(fid_out, '%f %f\n', limita_inf, limita_sup);
		
		% inchidere fisier de iesire
		fclose(fid_out);
	endif

	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 4
	%%% ------------------------------------------------------------------------------------------------------------

	if (fid_aux = fopen('IntervaleValProprii.m', 'r')) ~= -1
		fclose(fid_aux);
	
		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta4', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 4\n');
		fprintf(fid_out, '%d\n', dim_vector_m);

		for i = 1 : dim_vector_m
			% apelare cerinta 4
			r = IntervaleValProprii(d, s, vector_m(i));
			
			% afisare valoare curenta pentru m
			fprintf(fid_out, '%d ', vector_m(i));
			
			% afisarea dimensiunii sirului numeric r  
			fprintf(fid_out, '%d\n', length(r));

			% afisarea sirului numeric r
			for j = 1 : length(r)
				if j == 1
					fprintf(fid_out, '%f', r(j));
				else
					fprintf(fid_out, ' %f', r(j));
				endif
			endfor
			
			fprintf(fid_out, '\n');
		endfor	

		% inchidere fisier de iesire
		fclose(fid_out);
	endif
	
	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 5
	%%% ------------------------------------------------------------------------------------------------------------

	if (fid_aux = fopen('CalculezValProprii.m', 'r')) ~= -1
		fclose(fid_aux);

		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta5', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 5\n');
		fprintf(fid_out, '%d\n', dim_vector_m);

		for i = 1 : dim_vector_m
			% apelare cerinta 5
			vp = CalculezValProprii(d, s, vector_m(i), epsilon);
			
			% afisare valoare curenta pentru m
			fprintf(fid_out, '%d ', vector_m(i));

			% afisare numar de valori proprii
			fprintf(fid_out, '%d\n', length(vp));

			% afisarea celor mai mici vector_m(i) valori proprii
			for j = 1 : length(vp)
				if j == 1
					fprintf(fid_out, '%f', vp(j));
				else
					fprintf(fid_out, ' %f', vp(j));
				endif
			endfor
			
			fprintf(fid_out, '\n');
		endfor
	
		% inchidere fisier de iesire
		fclose(fid_out);
	endif
	
	%%% ------------------------------------------------------------------------------------------------------------
	%%% Cerinta 6
	%%% ------------------------------------------------------------------------------------------------------------

	if (fid_aux = fopen('PutereInv.m', 'r')) ~= -1
		fclose(fid_aux);

		% deschidere fisier de iesire
		fid_out = fopen(strcat('out/', strcat(nume, strcat('_cerinta6', '.out'))), 'w');

		fprintf(fid_out, '#Rezultate Cerinta 6\n');
		fprintf(fid_out, '%d\n', length(vector_deplasare));

		% generare vector propriu initial y
		for j = 1 : n
			y(j) = j;
		endfor
		
		for i = 1 : length(vector_deplasare)
			% apelare cerinta 6
			[valp, vecp] = PutereInv(d', s', vector_deplasare(i), (y)', max_iter, epsilon);

			% afisare vector_deplasare(i) si valoare proprie
			fprintf(fid_out, '%f %f', vector_deplasare(i), valp);

			% afisare vector propriu 
			for j = 1 : length(vecp)
				fprintf(fid_out, ' %f', vecp(j));
			endfor

			fprintf(fid_out, '\n');
		endfor

		% inchidere fisier de iesire
		fclose(fid_out);
	endif
endfunction