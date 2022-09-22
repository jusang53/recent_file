function y = Setting()
    
    fprintf('\n')
    fprintf('Connecting to PLC ... \n')
    
    define_Node();

    addpath('C:\Windows\System32\drivers\etc');
    addpath('C:\Users\PC\Desktop\HHI_220923\code');
    
    %% Connect to PLC and Call Node
%     Connect to PLC
    s=opcuaserverinfo('172.16.9.101');
    uaClient=opcua(s);
    connect(uaClient);

    % import excel files (Safetylist , MemMapInfo)
    T1 = readtable('C:\Users\PC\Desktop\HHI_220923\code\safetylist_auto.xlsx');
    T2 = readtable('C:\Users\PC\Desktop\HHI_220923\code\MemMapInfo.xlsx');
    
    % Call Node (OTS mode , Input variables , Output variables ...)
    dEngineSpeed = findNodeByName(uaClient.Namespace,'::dEngineSpeed');
    Active_OTS = findNodeByName(uaClient.Namespace,'::Active_OTS');
    bSimMode = findNodeByName(uaClient.Namespace,'::bSimMode');
    
    modbus123 = findNodeByName(uaClient.Namespace,'::Modbus_hold123_2');
    bSimReset = modbus123.Children(2);
    bSimStart = modbus123.Children(3);
    bSimStop = modbus123.Children(4);
    Diesel_mode = modbus123.Children(5);
    Gas_mode = modbus123.Children(6);
    Backup_mode = modbus123.Children(7);
    
    abMemAICode = findNodeByName(uaClient.Namespace,'::abMemAlCode');
    abMemPtCode = findNodeByName(uaClient.Namespace,'::abMemPtCode');
    abMemGtCode = findNodeByName(uaClient.Namespace,'::abMemGtCode');
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

    [var_num, ~] = size(T2);
    pause(5);
    fprintf('Connected ! \n')
    fprintf('Run OTS mode \n')
    
    %% Run OTS
    % Set OTS mode
    writeValue(Active_OTS,1); writeValue(bSimMode,1); writeValue(dEngineSpeed,10);
    
    pause(2)
    
    % Reset
    for i = 1:3
        writeValue(bSimReset, 1);
        pause(2)
        writeValue(bSimReset, 0);
        pause(2)
    end
    pause(2)
    
    % Run Engine (Start button)
    writeValue(bSimStart,1);
    
    % OTS
    while readValue(Engine_speed) < 890
        pause(1);
    end
    pause(5);

    y = 1;
    fprintf('Finish Setting ! \n')
    fprintf('\n')
end
