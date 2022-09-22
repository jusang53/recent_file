clc;
close all;
import matlab.unittest.TestSuite

define_Node();

% Test_case = ["Setting","PT52", "PT32", "PT57"];
Test_suite = [];
for i = 1:length(Test_case)
    suite = TestSuite.fromFile('HHI_SafetyList_Test.m','Tag',Test_case(i));
    Test_suite = [Test_suite suite];
end

results = run(Test_suite);
table(results)