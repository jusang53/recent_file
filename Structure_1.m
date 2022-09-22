function Alarm_asrt = Structure_1

    define_Node();
    variable_setting();
    fprintf(' \n'); fprintf(' \n');
    fprintf('Test[%d] Start! \n', Test_number)
    fprintf(' \n');
    fprintf('Variables setting ... \n')

    forcing_bool = T1(n_excel,31);
    forcing_bool = forcing_bool{1,1};
    forcing_bool = forcing_bool{1,1};
    forcing_bool = str2num(forcing_bool);
    if abs(forcing_bool) > 0
        Forcing_variable();
    end

    remark_bool = T1(n_excel,33);
    remark_bool = remark_bool{1,1};
    remark_bool = remark_bool{1,1};
    remark_bool = str2num(remark_bool);
    if abs(remark_bool) > 0
        Remark_variable();
    end
    
    ch = 0;
    check_condition = 0;
    fprintf('Checking Condition ... \n')
    ch = Test_Condition(check_condition);
%     ch = 2;

    if ch == 2
        fprintf('Testing ... \n')
        if readValue(AA.Children(alarm_num+1)) == 1
            Alarm_asrt(1) = 1;
        else
            Alarm_asrt(1) = 0;
        end    
        writeValue(abSf_En.Children(input_num+1),1);
     
        % Condition 2
        writeValue(bSigForceMode, 1);
    %     if strcmp(remark, 'HFO') == 1
        if abs(remark_bool) > 0
            writeValue(Remark_1, 1);
            writeValue(Remark_2, 1);
%             pause(120);
        end
        scale = str2num(scale{1,1});
        if Test_type == 0
            forcing_value = -1 * scale;
        elseif Test_type == 1
            forcing_value = 0.9 * scale * readValue(afRef.Children(input_num+1));
        elseif Test_type == 2
            forcing_value = 1.1 * scale * readValue(afRef.Children(input_num+1));
        end
        writeValue(Forcing_Val, forcing_value);
        pause(3);
        writeValue(Forcing_En, 1);
        delay = T1(n_excel,12); delay = delay{1,1}; delay = delay{1,1}; delay = sscanf(delay,'%f');
        
        stop_dt = 10;
        tic
        dt = toc;

        if Alarm_type ~= 'PT'
            Value_check = 0;
            while dt < stop_dt
                Value_check = readValue(Physical_val);
                minv = min(0.95 * forcing_value, 1.05 * forcing_value);
                maxv = max(0.95 * forcing_value, 1.05 * forcing_value);
                if minv < Value_check && maxv > Value_check
                    break
                end
                dt = toc;
            end
        end
        
        if dt > 9.9
            fprintf('Forcing Timeout! \n')
        end
%         pause(delay);
        
        stop_dt = max(delay, 0.5)+delay;
        tic
        dt = toc;
        
        Alarm_check = 0;
        while dt < stop_dt
            Alarm_check = readValue(AA.Children(alarm_num+1));
            if Alarm_check == 1
                break
            end
            dt = toc;
        end
        dt;
        if readValue(AA.Children(alarm_num+1)) == 1
            Alarm_asrt(2) = 1;
        else
            Alarm_asrt(2) = 0;
        end
        Alarm_asrt;
%         Alarm_asrt(3) = 1;
        if Alarm_check == 1
            Alarm_asrt(3) = 1;
        else
            Alarm_asrt(3) = 0;
        end
        Alarm_asrt;
        pause(1);
    
        if abs(remark_bool) > 0
            writeValue(Remark_1, 0);
            writeValue(Remark_2, 0);
%             pause(120);
        end
        
        if Alarm_asrt == [0 1 1]
            fprintf('Test Success! \n')
        else 
            fprintf('Test Failed! \n')
        end
        fprintf(' \n');
        fprintf('Reset ... \n')
        Reset();
        
        if Alarm_type == 'SD'
            tic;
            dt = toc;
            while dt < 60
                speed = readValue(Engine_speed);
                if speed < 1
                    break;
                end
                dt = toc;
                pause(1);
            end

            for i = 1:3
                writeValue(bSimReset, 1);
                pause(2)
                writeValue(bSimReset, 0);
                pause(2)
            end
        end
        
        if readValue(AA.Children(alarm_num+1)) == 1
            Alarm_asrt(4) = 1;
        else
            Alarm_asrt(4) = 0;
        end
%         IN = INIZ();
        INIZ();
        for i = 1:2
            writeValue(bSimReset, 1);
            pause(1)
            writeValue(bSimReset, 0);
            pause(1)
        end
        
        pause(3);
        
        Run_again();
    else
        Alarm_asrt = [0 0 0 0];
        fprintf('Test Failed! \n')
    end
    fprintf(' \n');
    fprintf('Test Finish! \n')
    %fprintf('\n');fprintf('\n');fprintf('\n');
end