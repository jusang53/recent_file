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
x_val = [];
y_val = [];
for i=1:100
    [F,t,q] = readValue(uaClient,FNode);
    [y,t,q] = readValue(uaClient,yNode);
    F_val = [F_val F];
    x_val = [x_val y(1)];
    y_val = [y_val y(2)];
    pause(0.1);
end

writeValue(uaClient,refNode,0.0);

%% Test 1 Controller & Model Test
tol = 0.01;
for i = 0.5*length(x_val):length(x_val)
    c = x_val(i) - ref;
    assert(-tol < c && c < tol)
end

%% Test 2 Stability Test
tol = 0.02;
tol2 = 1;
for i = 2:length(y_val)
    d1 = y_val(i-1);
    d2 = y_val(i);
    assert(-tol < d2-d1 && d2-d1 < tol)
    assert(-tol2 < d2 && d2 < tol2)
end
