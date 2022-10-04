function slope = RemoveEmpty(data,ep)

A = [];
for i = 1:size(data,2)
    a = length(find(~data(:,i)))/size(data,1);
    if round(a,1) >= ep
       A = [A, i];
    end 
end 

data(:, A) = [];

A = [];
for i = 1:size(data,1)
    a = length(find(~data(i,:)))/size(data,2);
    if round(a,1) >= ep
       A = [A, i];
    end 
end 

data(A, :) = [];
slope = data;