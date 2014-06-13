function cplx_jackknife_ed = cplx_jackknife(orig, N)

	cplx_jackknife_ed = toComplex(jackknife(orig,N));

end
