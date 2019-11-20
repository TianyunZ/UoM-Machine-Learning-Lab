function result = CalculateAccuracy(k, B, m, p)
for i = 1:50
    Correct = 0;
    for j = 1:m
        Y = knearest(k, B{i,p}(j,:), B{i,1}, B{i,3});
        if Y == B{i,p+2}(j,1)
            Correct = Correct+1;
        end
    end;
    Acu(i,1) = Correct/m;
end;
result = Acu(:,1);