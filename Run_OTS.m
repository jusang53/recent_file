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