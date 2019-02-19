function checker()
	total_points = 0;
	input_files = ['matrice1'; 'matrice2'; 'matrice3'; 'matrice4'; 'matrice5'];
	no_tests = 5;
	epsilon = 10^-4;

	printf('----------------------------------------------------------------------------\n');
	printf('----------------------------------------------------------------------------\n');
	printf('---------------------------- Testare Tema 2 MN -----------------------------\n');
	printf('----------------------------------------------------------------------------\n');
	printf('----------------------------------------------------------------------------\n');
	
	for i = 1 : no_tests
	
		printf('\nTest %d \n', i);
		
		%%% executie tema pentru un fisier de intrare
		file_name = input_files(i, 1:8);
		Tema2MN(file_name);

		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 1
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('ValoriPolinoame.m', 'r')) ~= -1
			fclose(fid_aux);
			
			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta1', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta1', '.ref'))), 'r');
		
			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out); 
			fgetl(fid_ref); 

			printf('Cerinta 1');
			
			success = 1;

			% citire dimensiune matrice tridiagonala simetrica
			n_out = fscanf(fid_out, '%d', 1);
			n_ref = fscanf(fid_ref, '%d', 1);
			if n_out(1) ~= n_ref(1)
				printf('\n  Dimensiune matrice tridiagonala simetrica: (obtinuta = %d, referinta = %d)\n', n_out(1), n_ref(1));
			endif
			
			%%% testare numar de valori lambda considerate
			dim_vector_lambda_out = fscanf(fid_out, '%d', 1);
			dim_vector_lambda_ref = fscanf(fid_ref, '%d', 1);
			if dim_vector_lambda_out(1) ~= dim_vector_lambda_ref(1)
				printf('\n  Numar de valori lambda considerate: (obtinut = %d, referinta = %d)\n', 
						dim_vector_lambda_out(1), dim_vector_lambda_ref(1));
			endif

			for k = 1 : dim_vector_lambda_ref(1)
				%%% testare valoare lambda curenta
				val_lambda_out = fscanf(fid_out, '%f', 1);
				val_lambda_ref = fscanf(fid_ref, '%f', 1);
				if val_lambda_out(1) ~= val_lambda_ref(1)
					printf('\n  Valoarea lambda: (obtinuta = %f, referinta = %f)\n', val_lambda_out(1), val_lambda_ref(1));
				endif
	
				%%% testare P = [P0(val_lambda) P1(val_lambda), ..., Pn(val_lambda)] 
				out_ex1 = fscanf(fid_out, '%f', n_ref + 1);
				ref_ex1 = fscanf(fid_ref, '%f', n_ref + 1);
				for j  = 1 : n_ref(1) + 1
					if abs(out_ex1(j) - ref_ex1(j)) > epsilon
						printf('\n  Valoare polinom de grad %d:(obtinuta = %f, referinta: %f)\n', j - 1, out_ex1(j), ref_ex1(j));
						success = 0;
					endif
				endfor
			endfor
			
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif

			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 1 nu a fost implementata \n');
		endif
		
		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 2
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('NrValProprii.m', 'r')) ~= -1
			fclose(fid_aux);
			
			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta2', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta2', '.ref'))), 'r');

			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out);
			fgetl(fid_ref);

			printf('Cerinta 2');
			
			success = 1;
			
			%%% testare numar de valori lambda considerate
			dim_vector_lambda_out = fscanf(fid_out, '%d', 1);
			dim_vector_lambda_ref = fscanf(fid_ref, '%d', 1);
			if dim_vector_lambda_out(1) ~= dim_vector_lambda_ref(1)
				printf('\n  Numar de valori lambda considerate: (obtinut = %d, referinta = %d)\n', dim_vector_lambda_out(1), dim_vector_lambda_ref(1));
			endif

			for k = 1 : dim_vector_lambda_ref(1)
				%%% testare valoare lambda curenta
				val_lambda_out = fscanf(fid_out, '%f', 1);
				val_lambda_ref = fscanf(fid_ref, '%f', 1);
				if val_lambda_out(1) ~= val_lambda_ref(1)
					printf('\n  Valoarea lambda: (obtinuta = %f, referinta = %f)\n', val_lambda_out(1), val_lambda_ref(1));
				endif
	
				%%% testare rezultat functie NrValProprii
				out_ex2 = fscanf(fid_out, '%d', 1);
				ref_ex2 = fscanf(fid_ref, '%d', 1);
				if abs(out_ex2(1) - ref_ex2(1)) > epsilon
					printf('\n  Numarul de valori proprii mai mici decat lambda = %f: (obtinut = %d, referinta: %d)\n', val_lambda_ref(1), out_ex2(1), ref_ex2(1));
					success = 0;
				endif
			endfor
			
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif
			
			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 2 nu a fost implementata \n');
		endif

		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 3
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('LimiteValProprii.m', 'r')) ~= -1
			fclose(fid_aux);
			
			printf('Cerinta 3');

			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta3', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta3', '.ref'))), 'r');
		
			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out);
			fgetl(fid_ref);
			
			success = 1;
	
			%%% testare rezultat functie LimiteValPropri
			out_ex3 = fscanf(fid_out, '%f', 2);
			ref_ex3 = fscanf(fid_ref, '%f', 2);
			if abs(out_ex3(1) - ref_ex3(1)) > epsilon
				printf('\n Limita inferioara: (obtinuta = %f, referinta: %f)\n', out_ex3(1), ref_ex3(1));
				success = 0;
			endif
			if abs(out_ex3(2) - ref_ex3(2)) > epsilon
				printf('\n Limita superioara: (obtinuta = %f, referinta: %f)\n', out_ex3(2), ref_ex3(2));
				success = 0;
			endif
			
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif
			
			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 3 nu a fost implementata \n');
		endif
		
		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 4
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('IntervaleValProprii.m', 'r')) ~= -1
			fclose(fid_aux);
			
			printf('Cerinta 4');

			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta4', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta4', '.ref'))), 'r');
		
			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out); 
			fgetl(fid_ref); 
			
			success = 1;

			dim_vector_m_out = fscanf(fid_out, '%d', 1);
			dim_vector_m_ref = fscanf(fid_ref, '%d', 1);
			if dim_vector_m_out(1) ~= dim_vector_m_ref(1)
				printf('\n  Dimensiune vector m: (obtinuta = %d, referinta = %d)\n', dim_vector_m_out(1), 
				dim_vector_m_ref(1));
			endif
			
			for i = 1 : dim_vector_m_ref(1)
				%%% testarea valoare curenta pentru m
				m_out = fscanf(fid_out, '%d', 1);
				m_ref = fscanf(fid_ref, '%d', 1);
				if m_out(1) ~= m_ref(1)
					printf('\n  Valoare curenta pentru m: (obtinuta = %d, referinta = %d)\n', m_out(1), m_ref(1));
				endif
				
				%%% testarea dimensiunii sirului numeric r 
				dim_vector_r_out = fscanf(fid_out, '%d', 1);
				dim_vector_r_ref = fscanf(fid_ref, '%d', 1);
				if dim_vector_r_out(1) ~= dim_vector_r_ref(1)
					printf('\n  Dimensiunea sirului numeric r: (obtinuta = %d, referinta = %d)\n', dim_vector_r_out(1),
					dim_vector_r_ref(1));
					success = 0;
				endif

				for k = 1 : dim_vector_r_ref(1)
					%%% testare rezultat functie SeparareValProprii
					out_ex4 = fscanf(fid_out, '%f', 1);
					ref_ex4 = fscanf(fid_ref, '%f', 1);
					if abs(out_ex4(1) - ref_ex4(1)) > epsilon
						printf('\n  Element din sirul r: (obtinut = %f, referinta: %f)\n', out_ex4(1), ref_ex4(1));
						success = 0;
					endif
				endfor
			endfor
			
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif
		
			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 4 nu a fost implementata \n');
		endif

		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 5
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('CalculezValProprii.m', 'r')) ~= -1
			fclose(fid_aux);
			
			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta5', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta5', '.ref'))), 'r');

			printf('Cerinta 5');

			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out); 
			fgetl(fid_ref); 
			
			success = 1;

			dim_vector_m_out = fscanf(fid_out, '%d', 1);
			dim_vector_m_ref = fscanf(fid_ref, '%d', 1);
			if dim_vector_m_out(1) ~= dim_vector_m_ref(1)
				printf('\n  Dimensiune vector m: (obtinuta = %d, referinta = %d)\n', dim_vector_m_out(1), 
				dim_vector_m_ref(1));
			endif
			
			for i = 1 : dim_vector_m_ref(1)
				%%% testarea valoare curenta pentru m
				m_out = fscanf(fid_out, '%d', 1);
				m_ref = fscanf(fid_ref, '%d', 1);
				if m_out(1) ~= m_ref(1)
					printf('\n  Valoare curenta pentru m: (obtinuta = %d, referinta = %d)\n', m_out(1), m_ref(1));
				endif
			
				%%% testarea numarului de valori proprii 
				nr_vp_out = fscanf(fid_out, '%d', 1);
				nr_vp_ref = fscanf(fid_ref, '%d', 1);
				if nr_vp_out(1) ~= nr_vp_ref(1)
					printf('\n  Numar de valori proprii: (obtinut = %d, referinta = %d)\n', nr_vp_out(1), nr_vp_ref(1));
					success = 0;
				endif

				for k = 1 : nr_vp_ref(1)
					%%% testare rezultat functie CalculezValProprii
					out_ex5 = fscanf(fid_out, '%f', 1);
					ref_ex5 = fscanf(fid_ref, '%f', 1);
					if abs(out_ex5(1) - ref_ex5(1)) > epsilon
						printf('\n  Valoare proprie: (obtinut = %f, referinta: %f)\n', out_ex5(1), ref_ex5(1));
						success = 0;
					endif
				endfor
			endfor	
				
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif

			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 5 nu a fost implementata \n');
		endif

		%%% ------------------------------------------------------------------------------------------------------------
		%%% Testare Cerinta 6
		%%% ------------------------------------------------------------------------------------------------------------

		if (fid_aux = fopen('PutereInv.m', 'r')) ~= -1
			fclose(fid_aux);
			
			%%% deschidere fisier de iesire, respectiv de referinta
			fid_out = fopen(strcat('out/', strcat(file_name , strcat('_cerinta6', '.out'))), 'r');
			fid_ref = fopen(strcat('out/', strcat(file_name, strcat('_cerinta6', '.ref'))), 'r');

			printf('Cerinta 6');

			%%% citire mesaj asociat cu aceasta cerinta 
			fgetl(fid_out); 
			fgetl(fid_ref); 
			
			success = 1;

			dim_vector_deplasare_out = fscanf(fid_out, '%d', 1);
			dim_vector_deplasare_ref = fscanf(fid_ref, '%d', 1);
			if dim_vector_deplasare_out(1) ~= dim_vector_deplasare_ref(1)
				printf('\n  Dimensiune vector deplasare: (obtinuta = %d, referinta = %d)\n', dim_vector_deplasare_out(1), 
				dim_vector_deplasare_ref(1));
			endif
			
			for i = 1 : dim_vector_deplasare_ref(1)
				%%% testarea deplasare
				h_out = fscanf(fid_out, '%f', 1);
				h_ref = fscanf(fid_ref, '%f', 1);
				if h_out(1) ~= h_ref(1)
					printf('\n  Valoare de deplasare: (obtinuta = %f, referinta = %f)\n', h_out(1), h_ref(1));
				endif
			
				%%% testare valoare proprie
				valp_out = fscanf(fid_out, '%f', 1);
				valp_ref = fscanf(fid_ref, '%f', 1);
				if valp_out(1) ~= valp_ref(1)
					printf('\n  Valoare proprie: (obtinut = %f, referinta = %f)\n', valp_out(1), valp_ref(1));
					success = 0;
				endif

				%%% testare vector propriu asociat valorii proprii
				vecp_out = fscanf(fid_out, '%f', n_ref);
				vecp_ref = fscanf(fid_ref, '%f', n_ref);
				for k = 1 : n_ref
					if norm(abs(vecp_out(k)) - abs(vecp_ref(k))) > epsilon
						printf('\n  Elementul v.p. de pe pozitia %d: (obtinut = %f, referinta: %f)\n', 
						k, vecp_out(k), vecp_ref(k));
						success = 0;
					endif
				endfor
			endfor	
				
			if success == 0 
				printf('  ................................................. Incorect [%d/%d]\n', 0, 3);
			else
				total_points += 3;
				printf('  .......................................... Corect [%d/%d]\n', 3, 3);
			endif

			%%% Inchidere fisier de iesire, respectiv de referinta
			fclose(fid_out);
			fclose(fid_ref);
		else
			printf('Cerinta 6 nu a fost implementata \n');
		endif
	
	endfor

	printf('\n                                      Punctaj total tema: [%d/%d]\n\n', total_points, 90);
endfunction