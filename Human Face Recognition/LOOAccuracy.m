function result = LOOAccuracy(k, data, labels)
TestAcu = zeros(200,1);
Y = knearest(k, data(1,:), data((2:200),:), labels(2:200));
if Y == labels(1)
    TestAcu(1) = 1;
end
for i = 2:199
    Y = knearest(k, data(i,:), data([1:i-1,i+1:200],:), labels([1:i-1,i+1:200]));
    if Y == labels(i)
        TestAcu(i) = 1;
    end
end;
Y = knearest(k, data(200,:), data((1:199),:), labels(1:199));
if Y == labels(200)
    TestAcu(200) = 1;
end
result = TestAcu;