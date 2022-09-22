classdef HHI_SafetyList_Test < matlab.unittest.TestCase
     methods(Test, TestTags = {'Setting'})
        function Setting(testCase)
            actSolution = Setting();
            expSolution = 1;
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'PT52'})
        function PT52_Sensor_failure(testCase)
            global Test_number;
            Test_number = 26;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function PT52_Lower_than_set_point_MDO(testCase)
            global Test_number;
            Test_number = 27;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'PT57'})
        function PT57_Lower_than_set_point(testCase)
            global Test_number;
            Test_number = 37;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'PT32'})
        function PT32_Higher_than_set_point(testCase)
            global Test_number;
            Test_number = 57;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
end
