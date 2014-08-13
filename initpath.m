% This script initialises the path to all the functions in the toolbox.
% Make sure you have these folders bk, fa, dm, pyd, ut, and msc.
% 
blockproc_path='bk';
fusionalg_path='fa';
dissimmet_path='dm';
pyramidfn_path='pyd';
utilities_path='ut';
miscfuncs_path='msc';
path(path, blockproc_path);
path(path, fusionalg_path);
path(path, dissimmet_path);
path(path, pyramidfn_path);
path(path, utilities_path);
path(path, miscfuncs_path);

disp 'Path Initialised';
