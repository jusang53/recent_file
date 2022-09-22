writeValue(bSimStart,1); 
writeValue(bSimStop,0); 

while readValue(Engine_speed) < 890
    pause(1);
end
pause(5);