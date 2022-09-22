function y = Operation_Condition(check_condition)
    
    define_Node();
    
    engine_mode = IF_MONITOR.Children(2);
    a = readValue(engine_mode); % state

    Eng_stop = T1(n_excel, 13);
    Eng_stop = Eng_stop{1,1};
    Eng_stop = Eng_stop{1,1};
%     Eng_start = T1(n_excel, 14);
%     Eng_start = Eng_start{1,1};
%     Eng_start = Eng_start{1,1};
    Eng_run = T1(n_excel, 15);
    Eng_run = Eng_run{1,1};
    Eng_run = Eng_run{1,1};
    
    if a == 1 % Stop
        if length(Eng_stop) > 1
        elseif length(Eng_stop) == 1 && length(Eng_run) > 1
            writeValue(bSimStart,1);
            writeValue(bSimStop,0);
            while readValue(Engine_speed) < 890
                pause(1);
            end
            pause(5);
        end
    elseif a == 4 % Start
        if length(Eng_run) > 1
        elseif length(Eng_run) == 1 && length(Eng_stop) > 1
            writeValue(bSimStart,0);
            writeValue(bSimStop,1);
            while readValue(Engine_speed) > 10
                pause(1);
            end
            pause(5);
        end
    end
            

    if (a == 1 && length(Eng_stop) > 1) || (a == 4 && length(Eng_run) > 1)
        check_condition = check_condition + 1;
        fprintf('    - Operation mode check success!  \n')
    else
        fprintf('    - Operation mode check fail!  \n')
    end
    y = check_condition;
    
end