addpath('C:\Windows\System32\drivers\etc');

s=opcuaserverinfo('172.16.9.101');
uaClient=opcua(s);
connect(uaClient);

T1 = readtable('Safetylist.xlsx'); % Test case
T2 = readtable('Alarm.xlsx'); % variable

dEngineSpeed = findNodeByName(uaClient.Namespace,'::dEngineSpeed');
Active_OTS = findNodeByName(uaClient.Namespace,'::Active_OTS');
bSimMode = findNodeByName(uaClient.Namespace,'::bSimMode');

modbus123 = findNodeByName(uaClient.Namespace,'::Modbus_hold123_2');
bSimReset = modbus123.Children(2);
bSimStart = modbus123.Children(3);

abMemAICode = findNodeByName(uaClient.Namespace,'::abMemAlCode');
abMemPtCode = findNodeByName(uaClient.Namespace,'::abMemPtCode');
abSf_En = findNodeByName(uaClient.Namespace,'::abSf_En');
afRef = findNodeByName(uaClient.Namespace,'::afRef');
afSf_T = findNodeByName(uaClient.Namespace,'::afSf_T');
modbus15 = findNodeByName(uaClient.Namespace,'::Modbus_hold15_2');
bSigForceMode = modbus15.Children(3);

IF_MONITOR = findNodeByName(uaClient.Namespace,'::IF_MONITOR');
op_mode = IF_MONITOR.Children(1);
IF_ICP_MONITOR = findNodeByName(uaClient.Namespace,'::IF_ICP_MONITOR');
Engine_speed = IF_ICP_MONITOR.Children(83);

modbus130 = findNodeByName(uaClient.Namespace,'::Modbus_hold130_2');
modbus135 = findNodeByName(uaClient.Namespace,'::Modbus_hold135_2');
Remark_var_1 = modbus130.Children(55);
Remark_var_2 = modbus135.Children(55);

[var_num, ~] = size(T2);