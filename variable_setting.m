define_Node();
n_excel
T1(n_excel,26)
Alarm = T1(n_excel,26);
Alarm = table2array(Alarm);
Alarm = str2num(Alarm{1,1});
global Alarm_type;
for i = 4000:var_num
    T2_Alarm = table2array(T2(i,22));
    T2_Alarm = T2_Alarm{1,1};
    T2_Alarm = str2num(T2_Alarm);
    if T2_Alarm == Alarm
        Alarm_type = table2array(T1(n_excel,15));
        Alarm_type = Alarm_type{1,1};
        if Alarm_type == '-'
            Alarm_type = table2array(T1(n_excel,14));
            Alarm_type = Alarm_type{1,1};
        end
        if Alarm_type == '-'
            Alarm_type = table2array(T1(n_excel,13));
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

for i = 5200:var_num
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

% Alarm variables
AA = "abMemAICode";
if Alarm_type == 'AL'
    alarm_num = sscanf(Alarm_sig, strcat("abMemAlCode[","%d","]"));
    AA = abMemAICode;
elseif Alarm_type == 'GT'
    alarm_num = sscanf(Alarm_sig, strcat("abMemGtCode[","%d","]"));
    AA = abMemGtCode;
elseif Alarm_type == 'PT'
    alarm_num = sscanf(Alarm_sig, strcat("abMemPtCode[","%d","]"));
    AA = abMemPtCode;
    alarm_num = alarm_num + 1;
end
input_num = sscanf(en_sig, strcat("abSf_En[","%d","]"));

% Test type (failure , Low , High)
Test_type = 0; % 0 : failure / 1 : low / 2 : high
code = T1(n_excel,8:9);
for i = 1:2
    A = code{1,i};
    A = A{1,1};
    if A > 0
        Test_type = i;
        break;
    end
end

scale = T1(n_excel,30);
scale = table2array(scale);

code = T1(n_excel,35); code = table2array(code); code = code{1,1}; code = str2num(code);
AcmMod = findNodeByName(uaClient.Namespace,'::AcmMod');
Physical_val = AcmMod.Children(code+1);
