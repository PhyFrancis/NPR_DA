function Zq_avg = compute_Zq(bilinear,jackknifed_leg_p1,jackknifed_leg_p2, Z_V, Z_A, scheme, q)

	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('compute_Zq_gammaMu:: GammaMatrix loaded.\n');
	end

	qslash = zeros(4,4);
	for dir = 1:4
		qslash = qslash + q(dir) * gamma{dir,1};
	end
	q2 = sum(q.^2);

	n = size(bilinear,2) / 24;

	bilinear_S = load_matrix_sub(bilinear,1);
	bilinear_P = load_matrix_sub(bilinear,2);
	S = amputate_2tensors(jackknife(bilinear_S, n),jackknifed_leg_p1,jackknifed_leg_p2);
	P = amputate_2tensors(jackknife(bilinear_P, n),jackknifed_leg_p1,jackknifed_leg_p2);

	bilinear_V = cell(4,1);
	bilinear_A = cell(4,1);
	V = cell(4,1);
	A = cell(4,1);
	for dir = 1:4
		bilinear_V{dir,1} = load_matrix_sub(bilinear, dir+2);
		bilinear_A{dir,1} = load_matrix_sub(bilinear, dir+6);
		V{dir,1} = amputate_2tensors(jackknife(bilinear_V{dir,1}, n),jackknifed_leg_p1,jackknifed_leg_p2);
		A{dir,1} = amputate_2tensors(jackknife(bilinear_A{dir,1}, n),jackknifed_leg_p1,jackknifed_leg_p2);
	end

	lambda_S = [];
	lambda_P = [];
	lambda_V = [];
	lambda_A = [];
	Zq_JACK = [];
	for conf = 1:n
		lambda_S = [lambda_S; real(trace(S(:,(conf-1)*12 + [1:12])))/12];
		lambda_P = [lambda_P; real(trace(toSCMatrix(gamma{5,1})*P(:,(conf-1)*12 + [1:12])))/12];
		V_tmp = 0.0;
		A_tmp = 0.0;
		if strcmp(scheme,'GammaMu')
			for dir = 1:4
				V_tmp = V_tmp + real(trace(toSCMatrix(gamma{dir,1})*V{dir,1}(:,(conf-1)*12+[1:12])));
				A_tmp = A_tmp + real(trace(toSCMatrix(gamma{dir,1}*gamma{5,1})*A{dir,1}(:,(conf-1)*12+[1:12])));
			end
			lambda_V = [lambda_V; V_tmp / 12 / 4];
			lambda_A = [lambda_A; A_tmp / 12 / 4];
			Zq_JACK = [Zq_JACK; (V_tmp * Z_V + A_tmp * Z_A) / 2 / 12 / 4];
		elseif strcmp(scheme, 'QSlash')
			for dir = 1:4
				V_tmp = V_tmp + real(trace(toSCMatrix(q(dir)*qslash)*V{dir,1}(:,(conf-1)*12+[1:12])));
				A_tmp = A_tmp + real(trace(toSCMatrix(q(dir)*qslash*gamma{5,1})*A{dir,1}(:,(conf-1)*12+[1:12])));
			end
			lambda_V = [lambda_V; V_tmp / 12 / q2];
			lambda_A = [lambda_A; A_tmp / 12 / q2];
			Zq_JACK = [Zq_JACK; (V_tmp * Z_V + A_tmp * Z_A) / 2 / 12 / q2];
		else 
			fprintf('compute_Zq::scheme %s or even-odd %d not supported.\n',scheme);
		end
	end

	Zq_avg = mean(Zq_JACK);

	% fprintf('Lambda Scaler: %12.6e $\\pm$ %12.6e\n',mean(lambda_S),std(lambda_S,1,1)*sqrt(n-1));
	% fprintf('Lambda Pseudo-Scaler: %12.6e $\\pm$ %12.6e\n',mean(lambda_P),std(lambda_P,1,1)*sqrt(n-1));
	fprintf('%s scheme, Lambda Vector:%12.6e $\\pm$ %12.6e\n',scheme, mean(lambda_V),std(lambda_V,1,1)*sqrt(n-1));
	fprintf('%s scheme, Lambda Axial-Vector: %12.6e $\\pm$ %12.6e\n',scheme, mean(lambda_A),std(lambda_A,1,1)*sqrt(n-1));
	fprintf('%s scheme, Zq: %12.6e $\\pm$ %12.6e\n',scheme, mean(Zq_JACK),std(Zq_JACK,1,1)*sqrt(n-1));

end
