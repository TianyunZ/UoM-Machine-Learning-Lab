% A is a 1*40 matrix
function result = SortDist(A)
for i = 1:40
    d(i) = (A(i) - 1)^2;
end;
[~,I] = sort(d);
result = I(1);
