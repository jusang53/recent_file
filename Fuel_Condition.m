function y = Fuel_Condition(check_condition)
    
    define_Node();
    
%     fuel_state = IF_MONITOR.Children(3);
%     b = readValue(fuel_state); % 0 : Diesel , 9 : Gas , 11 : GT (Backup)
    fuel_state = IF_MONITOR.Children(1);
    b = readValue(fuel_state); % 0 : Blackout , 1 : Backup , 2 : Diesel , 3 : Gas
    
    Eng_fuel = T1(n_excel, 16);
    Eng_fuel = Eng_fuel{1,1};
    Eng_fuel = Eng_fuel{1,1};
    Eng_fuel = abs(Eng_fuel);
    Eng_fuel = mat2num(Eng_fuel);
    
    ALL = abs('All');
    DIESEL = abs('Diesel');
    GAS = abs('Gas');
    BACKUP = abs('Backup');
    FSM = abs('FSM');
    
    ALL = mat2num(ALL);
    DIESEL = mat2num(DIESEL);
    GAS = mat2num(GAS);
    BACKUP = mat2num(BACKUP);
    
    
    Diesel_mode = modbus123.Children(5);
    Gas_mode = modbus123.Children(6);
    Backup_mode = modbus123.Children(7);
    if Eng_fuel == ALL
    elseif (b == 2 && Eng_fuel ~= DIESEL) || (b == 3 && Eng_fuel ~= GAS) || (b == 1 && Eng_fuel ~= BACKUP)
        if Eng_fuel == DIESEL
            writeValue(Diesel_mode,1);
            writeValue(Gas_mode,0);
            writeValue(Backup_mode,0);
        elseif Eng_fuel == GAS
            writeValue(Diesel_mode,0);
            writeValue(Gas_mode,1);
            writeValue(Backup_mode,0);
        elseif Eng_fuel == BACKUP
            writeValue(Diesel_mode,0);
            writeValue(Gas_mode,0);
            writeValue(Backup_mode,1);
        end     
        pause(30);
    end
    
    fuel_state = IF_MONITOR.Children(3);
    b = readValue(fuel_state);
    
    if (b == 0 && Eng_fuel == DIESEL) || (b == 9 && Eng_fuel == GAS) || (b == 11 && Eng_fuel == BACKUP) || (Eng_fuel == ALL)
        check_condition = check_condition + 1;
        fprintf('    - Fuel mode check success!  \n')
    else
        fprintf('    - Fuel mode check fail!  \n')
    end
    
    y = check_condition;
    
end