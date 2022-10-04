%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Group raw pupil diamter data cases 

% Inputs
%   group  - cases(medication on and off and controls) --> on-ADHD and
%   off-ADHD
%   data   - raw pupil diameter data
%   tr_per    - Percentge of samples used for trainign 

% Outputs
%   GropuData - grouped pupil data into cases (on-ADHD and off-ADHD) and controls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function GroupData  = DataRead_New( group, data)
GroupData = zeros(length(group),8, 2^18);

for i = 1:length(group)
    id = group(i);
    TaskData = data(id).Task_data;
    Psize = TaskData.Diameter;
    Psize = Psize(~isnan(Psize));
    Psize = Psize(find(Psize));
   
    t = round(linspace(1, length(Psize), 9),0);
    for j = 1 : length(t) - 1
        p = t(j+1)-t(j);
        GroupData(i,j, 1:p+1) = Psize(t(j):t(j+1));
    end
end 