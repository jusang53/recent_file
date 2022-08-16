clc;

define_Node();

Test_idx = [1:24];

Connect_and_CallNode();
Run_OTS();
for idx = 1:length(Test_idx)
    
    global remark;
    global Remark_var_1;
    global Remark_var_2;
    
    Test_number = Test_idx(idx);
    if Test_number == 5 || Test_number == 11
        continue;
    end
    
    data_from_excel_sheet();
    Call_Forcing_var();
%     
%     Run_OTS();
    
    Testing = "Test" + Test_number;
    Testing = convertStringsToChars(Testing);
    results = run(PLCTest0816,Testing);
    
    Reset();
end
