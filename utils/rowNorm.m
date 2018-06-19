function v = rowNorm(A)

if nargin ~= 1
    error('Requires one input arguments.')
end

v = sqrt(sum(A.*A, 2));
