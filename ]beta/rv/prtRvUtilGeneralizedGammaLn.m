function lny = prtRvUtilGeneralizedGammaLn(x,d)
% prtRvUtilGeneralizedGammaLn  The natural log of the generalized gamma or 
%   multi-gamma function.
%
% Syntax: lny = generalizedGammaLn(x,d)
%
% Input:
%   x - The value at which to evaluate the function
%   d - Thhe degree of the function
%
% Outputs:
%   y - The answer you are looking for

% Copyright (c) 2013 New Folder
%
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.


lnprodTerm = 0;
for j = 1:d
    lnprodTerm = lnprodTerm + gammaln((2*x-j+1)/2);
end

lny = (d*(d-1)/4)*log(pi) + lnprodTerm;
