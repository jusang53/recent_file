function final_state = stabilize2ref(args)
% stabilize2ref : 제한 시간 내에 상태변수가 초기상태값에서 나중상태값으로 수렴하는지 체크
% arg1 -> kind of state (y1 or y2)
% arg2 -> ref
% arg3 -> time limit

global uaClient
global resetNode startNode refNode yNode 

state_kind = args(1);
ref = args(2);
time_limit = args(3);
  
% Start Simulation
writeValue(uaClient,startNode,1);

% Write Value on Inverted Pendulum System in Target System
writeValue(uaClient,refNode,ref);

% Pause for time_limit 
pause(time_limit);

[y,~,~] = readValue(uaClient,yNode);

% Choose the State
if(state_kind == 1)
    final_state = y(1);
elseif(state_kind == 2)
    final_state = y(2);
else
    final_state = -1;
end

% Reset and Stop Simulation
writeValue(uaClient,resetNode,1);

end

