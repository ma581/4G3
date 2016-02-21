%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setup
V_th = 1;
dt = 0.1*10^-3;
tau = 20*10^-3;
N = 1000;
K = 100;
r_x = 10;

T = 2;
% POOL = parpool('local',2);
% Population X
S = zeros(N,T/dt);
for i = 1:N
    for j = 1:T/dt
        S(i,j) = binornd(1,r_x*dt);
    end
    if (rem(N,i) ==0)
        i
    end
end
delete(POOL);

check_sum = zeros(N,1);
for i = 1:N
    check_sum(i) = sum(S(i,:));
end

S_forPlots = zeros(N,T/dt);
S_forPlots = logical(S);
time_array = [0:dt:T-dt];

S_forPlots_2 = +S_forPlots;
for i=1:N
    S_forPlots_2(i,:) = i*S_forPlots_2(i,:);
    
end
figure;
for i=1:N
    h = plot(time_array,S_forPlots_2(i,:),'x');
    hold on;
    grid on;
end

