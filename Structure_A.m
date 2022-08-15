function Alarm_asrt = Structure_A

global Modbus_ForceEnable;
global Forcing_En;
global Modbus_ForceValue;
global Forcing_Val;
global alarm_num;
global AA;
global Alarm;
global Alarm_type;
global Alarm_sig;
global test_var;
global en_sig;
global ref_sig;
global time_sig;
global scale;
global input_num;
global s;
global uaClient;
global dEngineSpeed;
global Active_OTS;
global bSimMode;
global modbus123;
global bSimReset;
global bSimStart;
global abMemAICode;
global abMemPtCode;
global abSf_En;
global afRef;
global afSf_T;
global modbus15;
global bSigForceMode;
global IF_MONITOR;
global op_mode;
global IF_ICP_MONITOR;
global Engine_speed;
global var_num;
global T1;
global T2;
global Test_type;
global Test_number;
global remark;
global Remark_var_1;
global Remark_var_2;

    if readValue(AA.Children(alarm_num+1)) == 1
        Alarm_asrt(1) = 1;
    else
        Alarm_asrt(1) = 0;
    end    
    writeValue(abSf_En.Children(input_num+1),1);
 
    % Condition 2
    writeValue(bSigForceMode, 1);
%     if strcmp(remark, 'HFO') == 1
    if abs(remark) > 0
        writeValue(Remark_var_1, 1);
        writeValue(Remark_var_2, 1);
        pause(0.2);
    end       
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
%     while readValue(AA.Children(alarm_num+1)) == 0
%     %         dt = toc
%     end
    dt = max(delay*2, 2);
    pause(dt)
    dt = toc;

    if readValue(AA.Children(alarm_num+1)) == 1
        Alarm_asrt(2) = 1;
    else
        Alarm_asrt(2) = 0;
    end
    
    if dt < 2*delay
        Alarm_asrt(3) = 1;
    else
        Alarm_asrt(3) = 0;
    end
    
    if abs(remark) > 0
        writeValue(Remark_var_1, 0);
        writeValue(Remark_var_2, 0);
        pause(0.2);
    end
end