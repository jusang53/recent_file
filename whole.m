clc;
% clear;
% close all;

% Connect to OPC UA server
addpath('C:\Windows\System32\drivers\etc');

s=opcuaserverinfo('172.16.9.101');
uaClient=opcua(s);
connect(uaClient);

T1 = readtable('Safetylist.xlsx'); % Test case
T2 = readtable('Alarm.xlsx'); % variable
% T1 = readtable('Safetylist_full.xlsx'); % Test case
% T2 = readtable('Alarm.xlsx'); % variable

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

[var_num, ~] = size(T2);

% for Test_number = 1:13
for Test_number = 3:3
    if Test_number == 3 || Test_number == 5 || Test_number == 7 || Test_number == 9 || Test_number == 11
        continue;
    end
    
    Alarm = T1(Test_number+1,24);

    for i = 1:var_num
        if table2array(T2(i,22)) == table2array(Alarm)
    %     if table2array(T2(i,22)) == Alarm{1,1}
            Alarm_type = table2array(T1(Test_number+1,11));
            Alarm_type = Alarm_type{1,1};
            if Alarm_type == '-'
                Alarm_type = table2array(T1(Test_number+1,12));
                Alarm_type = Alarm_type{1,1};
            end
            if Alarm_type == '-'
                Alarm_type = table2array(T1(Test_number+1,13));
                Alarm_type = Alarm_type{1,1};
            end
            Alarm_sig = table2array(T2(i,21));
            Alarm_sig = Alarm_sig{1,1};
            test_var = table2array(T2(i,18));
            test_var = test_var{1,1};
            break
        end
    end
    
    test_var = "P_" + test_var;

    for i = 1:var_num
        if table2array(T2(i,18)) == test_var
            en_sig = table2array(T2(i,21));
            en_sig = en_sig{1,1};
            ref_sig = table2array(T2(i+1,21));
            ref_sig = ref_sig{1,1};
            time_sig = table2array(T2(i+2,21));
            time_sig = time_sig{1,1};
            break
        end
    end

    % Alarm_sig = sscanf(Alarm_sig, strcat("[","%s","]"));.
    AA = abMemAICode;
    if Alarm_type == 'AL'
        alarm_num = sscanf(Alarm_sig, strcat("abMemAlCode[","%d","]"));
        AA = abMemAICode;
    elseif Alarm_type == 'GT'
        alarm_num = sscanf(Alarm_sig, strcat("abMemGtCode[","%d","]"));
        AA = abMemGtCode;
    elseif Alarm_type == 'PT'
        alarm_num = sscanf(Alarm_sig, strcat("abMemPtCode[","%d","]"));
        AA = abMemPtCode;
    end
    input_num = sscanf(en_sig, strcat("abSf_En[","%d","]"));

    Test_type = 0; % 0 : none / 1 : low / 2 : high
    code = T1(Test_number+1,6:7);
    for i = 1:2
        A = code{1,i};
        isempty(A{1,1});
        if A{1,1} ~= 0
            Test_type = i;
            break;
        end
    end

    scale = T1(Test_number+1,27);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
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


    % Run OTS
    writeValue(Active_OTS,1); writeValue(bSimMode,1); writeValue(dEngineSpeed,10);
    pause(2)
    for i = 1:3
        writeValue(bSimReset, 1);
        pause(2)
        writeValue(bSimReset, 0);
        pause(2)
    end
    writeValue(bSimStart,1);

    while readValue(Engine_speed) < 890
        clc;
        pause(1);
    end
    Test_number
    % Initialization
    Alarm1 = readValue(AA.Children(alarm_num+1));
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
%         dt = toc
    end
%     pause(delay+0.2)
    dt = toc;
    Alarm2 = readValue(AA.Children(alarm_num+1));

%     assert(Alarm1 == 0 && Alarm2 == 1 && dt < 2 * delay);
    assert(Alarm1 == 0 && Alarm2 == 1)

    % Reset
%     if (Alarm1 == 0 && Alarm2 == 1 && dt < 2 * delay)
    if (Alarm1 == 0 && Alarm2 == 1)
        writeValue(abSf_En.Children(input_num+1),0);
        writeValue(bSigForceMode, 0);
        writeValue(Forcing_Val, 0);
        writeValue(Forcing_En, 0);
    end
    pause(2)
    for i = 1:3
        writeValue(bSimReset, 1);
        pause(2)
        writeValue(bSimReset, 0);
        pause(2)
    end
end