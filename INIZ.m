function y = INIZ()
    define_Node();
    y = 1;
    if Alarm_type == 'GT'
        fprintf('Initializing ... \n')
        writeValue(Gas_mode,0);
        tic;
        dt = toc;
        fuel_state = IF_MONITOR.Children(3);
        a = readValue(fuel_state); % 0 : Diesel , 9 : Gas , 11 : GT (Backup)
        fuel_state = IF_MONITOR.Children(1);
        b = readValue(fuel_state); % 0 : Blackout , 1 : Backup , 2 : Diesel , 3 : Gas
        while dt < 30
            if (a == 0 && b == 2)
                break;
            end
            fuel_state = IF_MONITOR.Children(3);
            a = readValue(fuel_state); % 0 : Diesel , 9 : Gas , 11 : GT (Backup)
            fuel_state = IF_MONITOR.Children(1);
            b = readValue(fuel_state); % 0 : Blackout , 1 : Backup , 2 : Diesel , 3 : Gas
        end
%         for i = 1:3
%             writeValue(bSimReset, 1);
%             pause(2)
%             writeValue(bSimReset, 0);
%             pause(2)
%         end
%         pause(30);
    elseif Alarm_type == 'PT'
        fprintf('Initializing ... \n')
%         tic;
%         dt = toc;
%         fuel_state = IF_MONITOR.Children(3);
%         a = readValue(fuel_state); % 0 : Diesel , 9 : Gas , 11 : GT (Backup)
%         fuel_state = IF_MONITOR.Children(1);
%         b = readValue(fuel_state); % 0 : Blackout , 1 : Backup , 2 : Diesel , 3 : Gas
%         while dt < 30
%             if (a == 0 && b == 2)
%                 break;
%             end
%             fuel_state = IF_MONITOR.Children(3);
%             a = readValue(fuel_state); % 0 : Diesel , 9 : Gas , 11 : GT (Backup)
%             fuel_state = IF_MONITOR.Children(1);
%             b = readValue(fuel_state); % 0 : Blackout , 1 : Backup , 2 : Diesel , 3 : Gas
%         end
%         for i = 1:3
%             writeValue(bSimReset, 1);
%             pause(2)
%             writeValue(bSimReset, 0);
%             pause(2)
%         end
        writeValue(bSimStart, 0);
        writeValue(bSimStop, 1);
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
    elseif Alarm_type == 'SD'
        fprintf('Initializing ... \n')
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
end