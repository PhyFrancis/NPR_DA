function y = scscMap(s1,c1,s2,c2)
	% s1,s2: 1~4
	% c1,c2: 1~3
	y = scMap(s1,c1) * 12 + scMap(s2,c2) - 12;
end
