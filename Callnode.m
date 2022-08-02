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

% Forcing for test
% Forcing Value
code = T1(Test_number+1,25); code = code{1,1}; Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceEnable = findNodeByName(uaClient.Namespace,str);
Forcing_En = Modbus_ForceEnable.Children(Digit2+1);
% Enable signal
code = T1(Test_number+1,26); code = code{1,1}; Digit3 = fix(code/100); Digit2 = rem(code,100);
str = sprintf('::Modbus_hold%d_2',Digit3);
Modbus_ForceValue = findNodeByName(uaClient.Namespace,str);
Forcing_Val = Modbus_ForceValue.Children(Digit2+1);

IF_MONITOR = findNodeByName(uaClient.Namespace,'::IF_MONITOR');
op_mode = IF_MONITOR.Children(1);
IF_ICP_MONITOR = findNodeByName(uaClient.Namespace,'::IF_ICP_MONITOR');
Engine_speed = IF_ICP_MONITOR.Children(83);

% Initialization
AA = abMemAICode;
if Alarm_type == 'AL'
    AA = abMemAICode;
elseif Alarm_type == 'GT'
    AA = abMemGtCode;
elseif Alarm_type == 'PT'
    AA = abMemPtCode;
end
Alarm1 = readValue(AA.Children(alarm_num+1));
% Run OTS
%     writeValue(Active_OTS,1); writeValue(bSimMode,1); writeValue(dEngineSpeed,10);
% pause(2)
% for i = 1:3
%     writeValue(bSimReset, 1);
%     pause(2)
%     writeValue(bSimReset, 0);
%     pause(2)
% end
%     writeValue(bSimStart,1);

%     while readValue(Engine_speed) < 890
%         clc;
%         pause(1);
%     end

% Condition 1
writeValue(abSf_En.Children(input_num+1),1);
% Condition 2
writeValue(bSigForceMode, 1);
if Test_type == 0
    writeValue(Forcing_Val, -1 * scale{1,1});
elseif Test_type == 1
    writeValue(Forcing_Val, 0.9 * scale{1,1} * readValue(afRef.Children(input_num+1)));
elseif Test_type == 2
    writeValue(Forcing_Val, 1.1 * scale{1,1} * readValue(afRef.Children(input_num+1)));
end
writeValue(Forcing_En, 1);
delay = T1(Test_number+1,10); delay = delay{1,1}; delay = delay{1,1}; delay = sscanf(delay,'%f');
% Check the Result
tic
while readValue(AA.Children(alarm_num+1)) == 0
end
%     pause(delay+0.2)
dt = toc;
Alarm2 = readValue(AA.Children(alarm_num+1));
Assert_and_Reset();