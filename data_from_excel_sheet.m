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