writeValue(abSf_En.Children(input_num+1),0);
writeValue(bSigForceMode, 0);
writeValue(Forcing_Val, 0);
writeValue(Forcing_En, 0);

pause(2)
for i = 1:3
    writeValue(bSimReset, 1);
    pause(2)
    writeValue(bSimReset, 0);
    pause(2)
end

pause(2)
for i = 1:3
    writeValue(bSimReset, 1);
    pause(2)
    writeValue(bSimReset, 0);
    pause(2)
end