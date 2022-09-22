code = T1(n_excel,33); code = code{1,1}; code = code{1,1}; code = str2num(code); Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceValue = findNodeByName(uaClient.Namespace,str);
Remark_1 = Modbus_ForceValue.Children(Digit2+1);

code = T1(n_excel,34); code = code{1,1}; code = code{1,1}; code = str2num(code); Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceValue = findNodeByName(uaClient.Namespace,str);
Remark_2 = Modbus_ForceValue.Children(Digit2+1);
