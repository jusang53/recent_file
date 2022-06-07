%% Main function to generate tests
function tests = InvertedPendulumTest
    tests = functiontests(localfunctions);
end

%% Test Functions
function testQuick(testCase)
test_quick = [1 0.5 5];
actSolution = stabilize2ref(test_quick);
expSolution = 0.5;
verifyLessThanOrEqual(testCase,abs(actSolution-expSolution),0.05)
end

function testProper(testCase)
test_proper = [1 0.5 10];
actSolution = stabilize2ref(test_proper);
expSolution = 0.5;
verifyLessThanOrEqual(testCase,abs(actSolution-expSolution),0.05)
end

function testSlow(testCase)
test_slow = [1 0.5 15];
actSolution = stabilize2ref(test_slow);
expSolution = 0.5;
verifyLessThanOrEqual(testCase,abs(actSolution-expSolution),0.05)
end

%% File fixtures  
function setupOnce(testCase)  % do not change function name

clear; close all;clc;
% ------------------------ OPC UA Setting --------------------------------%
global uaClient
global resetNode startNode FNode refNode yNode xNode

% Connect OPC UA 
% uaClient=opcua('10.64.146.121',4841);
uaClient=opcua('10.74.23.169',4840);

% Connect OPC UA Client with OPC UA Server
connect(uaClient);

% Find Node by Name
% When Variable is Global Variable


resetNode = findNodeByName(uaClient.Namespace,'::reset');
startNode = findNodeByName(uaClient.Namespace,'::start');
FNode = findNodeByName(uaClient.Namespace,'::F');
refNode = findNodeByName(uaClient.Namespace,'::ref');
yNode =  findNodeByName(uaClient.Namespace,'::y');
xNode =  findNodeByName(uaClient.Namespace,'::x');


end

function teardownOnce(testCase)  % do not change function name
% Disconnect OPC UA
global uaClient
disconnect(uaClient);
end
