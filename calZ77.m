function [Z77_mean, Z77_std] = calZ77(M77,scheme)

	load F77Matrix;
	if strcmp(scheme,'GammaMu')
		F77 = F77_gammaMu;
	elseif strcmp(scheme,'QSlash')
		F77 = F77_qSlash;
	else 
			fprintf('calZ77::scheme %s not supported.\n',scheme);
	end

	n = size(M77,1); 

	Z77 = cell(n,2);
	Z77_mean = cell(1,2);
	Z77_std  = cell(1,2);
	for eo = 1:2
		Z77_mean{1,eo} = zeros(7,7);
		Z77_std{1,eo}  = zeros(7,7);
		for i = 1:n
			Z77{i,eo} = real(F77 * inv(M77{i,eo}));
		end
		for i = 1:7
			for j = 1:7
				elem_array = [];
				for conf = 1:n
					elem_array = [elem_array, Z77{conf,eo}(i,j)];
				end
				Z77_mean{1,eo}(i,j) = mean(elem_array);
				Z77_std{1,eo}(i,j) = std(elem_array,1) * sqrt(n-1);
			end
		end

		fprintf('%s scheme, eo=%d, Z77:\n', scheme, eo);
		Z77_mean{1,eo}
		Z77_std{1,eo}

	end
end
