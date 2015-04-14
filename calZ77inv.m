function [Z77inv_mean, Z77inv_std] = calZ77inv(M77,scheme)

	load F77Matrix;
	if strcmp(scheme,'GammaMu')
		F77 = F77_gammaMu;
	elseif strcmp(scheme,'QSlash')
		F77 = F77_qSlash;
	else 
			fprintf('calZ77::scheme %s not supported.\n',scheme);
	end

	n = size(M77,1); 

	Z77inv = cell(n,2);
	Z77inv_mean = cell(1,2);
	Z77inv_std  = cell(1,2);
	for eo = 1:2
		Z77inv_mean{1,eo} = zeros(7,7);
		Z77inv_std{1,eo}  = zeros(7,7);
		for i = 1:n
			Z77inv{i,eo} = real(M77{i,eo} * inv(F77));
		end
		for i = 1:7
			for j = 1:7
				elem_array = [];
				for conf = 1:n
					elem_array = [elem_array, Z77inv{conf,eo}(i,j)];
				end
				Z77inv_mean{1,eo}(i,j) = mean(elem_array);
				Z77inv_std{1,eo}(i,j) = std(elem_array,1) * sqrt(n-1);
			end
		end

		fprintf('%s scheme, eo=%d, Z77-inverse:\n', scheme, eo);
		Z77inv_mean{1,eo}
		Z77inv_std{1,eo}
	end
end
