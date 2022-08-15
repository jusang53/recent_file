code = T1(Test_number+1,25); code = code{1,1}; Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceEnable = findNodeByName(uaClient.Namespace,str);
Forcing_En = Modbus_ForceEnable.Children(Digit2+1);

% Enable signal
code = T1(Test_number+1,26); code = code{1,1}; Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceValue = findNodeByName(uaClient.Namespace,str);
Forcing_Val = Modbus_ForceValue.Children(Digit2+1);