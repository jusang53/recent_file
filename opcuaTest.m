clc;
clear;
close all;

% pyenv;
% systemCommand = ['python client.py'];
% % [status, result] = system(systemCommand)

% !C:\Users\PC\AppData\Local\Programs\Python\Python38\python.exe client.py

a = py.client_function.get_val();


%% Test 1: temp > 20
assert(a>=20)