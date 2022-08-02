clc;
clear;
close all;

% Connect to OPC UA server
addpath('C:\Windows\System32\drivers\etc');

s=opcuaserverinfo('172.16.9.101');
uaClient=opcua(s);
connect(uaClient);
Testnum();
