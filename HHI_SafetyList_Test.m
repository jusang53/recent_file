classdef HHI_SafetyList_Test < matlab.unittest.TestCase
     methods(Test, TestTags = {'Setting'})
        function Setting(testCase)
            actSolution = Setting();
            expSolution = 1;
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'SE11'})
        function Test1(testCase)
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'SE113'})
        function Test2(testCase)
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'SE12'})
        function Test3(testCase)
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'SE14'})
        function Test4(testCase)
            actSolution = Test_Structure;
            expSolution = [0 1 1];
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
%         function Test28(testCase)
%             global Test_number;
%             Test_number = 28;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1 0];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
     end
     methods(Test, TestTags = {'PT51'})
        function Test29(testCase)
            Test_number = 29;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end  
     methods(Test, TestTags = {'PT51-PT52'})
        function Test30(testCase)
            Test_number = 30;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end     
     methods(Test, TestTags = {'TE52'})
        function Test31(testCase)
            Test_number = 31;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function Test32(testCase)
            Test_number = 32;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function Test33(testCase)
            Test_number = 33;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function Test34(testCase)
            Test_number = 34;
            actSolution = Test_Structure;
            expSolution = [0 1 1];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'PT57'})
%         function Test35(testCase)
%             Test_number = 35;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
%         function Test36(testCase)
%             Test_number = 36;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
        function PT57_Lower_than_set_point(testCase)
            global Test_number;
            Test_number = 37;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
     end
     methods(Test, TestTags = {'PT32'})
%         function Test54(testCase)
%             global Test_number;
%             Test_number = 54;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1 0];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
%         function Test55(testCase)
%             global Test_number;
%             Test_number = 55;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1 0];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
%         function Test56(testCase)
%             global Test_number;
%             Test_number = 56;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1 0];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
        function PT32_Higher_than_set_point(testCase)
            global Test_number;
            Test_number = 57;
            actSolution = Test_Structure;
            expSolution = [0 1 1 0];
            testCase.verifyEqual(actSolution,expSolution)
        end
%         function Test58(testCase)
%             global Test_number;
%             Test_number = 58;
%             actSolution = Test_Structure;
%             expSolution = [0 1 1 0];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
     end
end