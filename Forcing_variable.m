% Forcing signal
code = T1(n_excel,31); code = code{1,1}; code = code{1,1}; code = str2num(code); Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceEnable = findNodeByName(uaClient.Namespace,str);
Forcing_En = Modbus_ForceEnable.Children(Digit2+1);
% Forcing_En

code = T1(n_excel,32); code = code{1,1}; code = code{1,1}; code = str2num(code); Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceValue = findNodeByName(uaClient.Namespace,str);
Forcing_Val = Modbus_ForceValue.Children(Digit2+1);
% Forcing_Val