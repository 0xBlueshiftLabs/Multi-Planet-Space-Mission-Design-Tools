function j0 = J0(year, month, day)
% 
%
% Computes the Julian day number at 0 UT for any
% year between 1900 and 2100 using Equation 5.48.
%
% j0 - Julian day at 0 hr UT (Universal Time)
% year - range: 1901 - 2099
% month - range: 1 - 12
% day - range: 1 - 31

%
% User M-functions required: none
% ------------------------------------------------------------
j0 = 367*year - fix(7*(year + fix((month + 9)/12))/4)+ fix(275*month/9) + day + 1721013.5;


%%%%%% FROM D.12 - Orbital Mechanics for Engineering Students by Howard Curtis %%%%%%
