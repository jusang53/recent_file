clear all
close all
clc

% Search OPC UA Server
uaClient=opcua('10.74.23.221',4840);

% Connect OPC UA Client with OPC UA Server
connect(uaClient);

% Find Node by Name
% When Variable is Global Variable
FNode = findNodeByName(uaClient.Namespace,'::F');
refNode = findNodeByName(uaClient.Namespace,'::ref');
yNode =  findNodeByName(uaClient.Namespace,'::y');
startNode = findNodeByName(uaClient.Namespace,'::start');

% Write Value on Inverted Pendulum System in Target System
ref = 0.1;
writeValue(uaClient,startNode,true);
writeValue(uaClient,refNode,ref);

% Read Variables from Inverted Pendulum System in Target System
F_val = [];
y_val = [];
for i=1:100
    [F,t,q] = readValue(uaClient,FNode);
    [y,t,q] = readValue(uaClient,yNode);
    F_val = [F_val F];
    y_val = [y_val y(1)];
    pause(0.1);
end

writeValue(uaClient,refNode,0.0);

%% Test 1
tol = 0.01;
for i = 0.5*length(y_val):length(y_val)
    scatter(i-0.5*length(y_val)+1,y_val(i)); hold on;
    c = y_val(i) - ref;
    assert(-tol < c && c < tol)
end
