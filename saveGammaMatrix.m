% This file generates five \gamma matrix and save to the file fn
% all gamma matrix are in CPS convention

fn = 'GammaMatrix';
gamma = cell(5,1);

clear i;

% gamma1 (X)
gamma{1,1} = [ 0, 0, 0, i ;
               0, 0, i, 0 ;
               0,-i, 0, 0 ;
              -i, 0, 0, 0 ] ;
            
% gamma2 (Y)
gamma{2,1} = [ 0, 0, 0,-1 ;
               0, 0, 1, 0 ;
               0, 1, 0, 0 ;
              -1, 0, 0, 0 ] ;

% gamma3 (Z)
gamma{3,1} = [ 0, 0, i, 0 ;
               0, 0, 0,-i ;
              -i, 0, 0, 0 ;
               0, i, 0, 0 ] ;

% gamma4 (T)
gamma{4,1} = [ 0, 0, 1, 0 ;
               0, 0, 0, 1 ;
               1, 0, 0, 0 ;
               0, 1, 0, 0 ] ;

% gamma5 (5)
gamma{5,1} = [ 1, 0, 0, 0 ;
               0, 1, 0, 0 ;
               0, 0,-1, 0 ;
               0, 0, 0,-1 ] ;
							 
save(fn,'gamma');
