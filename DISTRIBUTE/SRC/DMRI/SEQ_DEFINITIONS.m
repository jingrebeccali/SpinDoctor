global PGSE OGSEsin OGSEcos dPGSE

PGSE = 1;
OGSEsin = 2;
OGSEcos = 3;
dPGSE = 4;


global sym_s sym_ft sym_BDELTA sym_SDELTA
syms sym_s sym_BDELTA sym_SDELTA

assume(sym_SDELTA>0);
assume(sym_BDELTA>=sym_SDELTA);

displacement = sym_SDELTA + sym_BDELTA;
sym_ft = piecewise(sym_s >= 0      & sym_s <= sym_SDELTA,       1, ...
		   sym_s > sym_BDELTA & sym_s <= sym_BDELTA+sym_SDELTA, -1, ...
		   sym_s > 0 + displacement & sym_s <= sym_SDELTA + displacement, 1, ...
		   sym_s > sym_BDELTA + displacement & sym_s <= sym_BDELTA+sym_SDELTA + displacement, -1, 0);
