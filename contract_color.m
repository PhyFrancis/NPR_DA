function y = contract_color(tensor)
	% contract the color indices of tensor,
	% and returns a tensor with four spin indices:
	% y = tensor^{s1,c1; s2,c1; s3,c2; s4,c2}
	
	y = zeros(16,16);
	for s1 = 1:4
		for s2 = 1:4 
			for s3 = 1:4
				for s4 = 1:4 
					for c1 = 1:3
						for c2 = 1:3
							y(ssMap(s1,s2),ssMap(s3,s4)) = y(ssMap(s1,s2),ssMap(s3,s4)) + tensor(scscMap(s1,c1,s2,c1),scscMap(s3,c2,s4,c2));
						end
					end
				end
			end
		end
	end

end
