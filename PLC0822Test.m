clc;

%Test_idx = [1:24];
Test_idx = [1,2,3,10,15,22];
Connect_and_CallNode();
Run_OTS();
for idx = 1:length(Test_idx)
%     i
    define_Node();
    Test_number = Test_idx(idx);
    if Test_number == 5 || Test_number == 21
        continue;
    end
    
    data_from_excel_sheet();
    Call_Forcing_var();
%     
%     Run_OTS();
    
    global remark;
    global Remark_var_1;
    global Remark_var_2;

    Testing = "Test" + Test_number;
    Testing = convertStringsToChars(Testing);
    results = run(PLCTestFunc,Testing);
    
    Reset();
end
