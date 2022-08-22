function Alarm_asrt = Test_Structure

global Test_number;
global T1;
% Alarm_asrt = logical([0 0 ])
if table2array(T1(Test_number+1,28)) == 1
    Alarm_asrt = Structure_A;
elseif table2array(T1(Test_number+1,28)) == 2
    Alarm_asrt = Structure_B;
end
end