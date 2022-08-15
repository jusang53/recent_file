classdef SolverTest < matlab.unittest.TestCase
    methods(Test)
%         Test_idx = [1 2 3 4 5 6 7 8 9 10];
%         Connect_and_CallNode();
%         for idx = 1:length(Test_idx)
%             Test_number = Test_idx(idx);
%             if Test_number == 5 || Test_number == 11
%                 continue;
%             end
%             data_from_excel_sheet();
%             Call_Forcing_var();
%             Run_OTS();
%         end
        function realSolution(testCase)
            actSolution = Structure_A();
            expSolution = [0 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
    end
end