% classdef PLCTest < matlab.unittest.TestCase
%     methods(Test)
%         function realSolution(testCase)
%             actSolution = Structure_A(T1, alarm_num, AA, Test_type, input_num, abSf_En, bSigForceMode, Forcing_Val, scale, afRef, Forcing_En, Test_number);
%             expSolution = [0 1];
%             testCase.verifyEqual(actSolution,expSolution)
%         end
%     end
% end

actSolution = Structure_A(T1, alarm_num, AA, Test_type, input_num, abSf_En, bSigForceMode, Forcing_Val, scale, afRef, Forcing_En, Test_number);
expSolution = [0 1];
verifyEqual(actSolution,expSolution)