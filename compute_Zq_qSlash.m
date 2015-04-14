function Zq = compute_Zq(jackknifed_leg_p1,p1)
	persistent gamma;
	if isempty(gamma)
		load GammaMatrix; 
		fprintf('compute_Zq::GammaMatrix loaded.\n');
	end

	nConf = size(jackknifed_leg_p1,2) / 12;
	Zq = zeros(nConf,1);
	normP = norm(p1);

	for i = 1:nConf
		Sinv = inv(jackknifed_leg_p1(:,12*(i-1)+[1:12]));
		for dir = 1:4
			Zq(i) = Zq(i) + trace(Sinv * toSCMatrix(gamma{dir,1})) * p1(dir);
		end
		Zq(i) = Zq(i) / (12 * normP^2 * complex(0,1));
	end
			
	clearvars -except Zq gamma;
end
