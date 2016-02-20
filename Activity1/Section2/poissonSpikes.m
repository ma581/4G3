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

T = 0.1*10^-2;
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
    i
end
figure;
for i=1:N
    h = plot(time_array,S_forPlots_2(i,:),'x');
    hold on;
    grid on;
end


d_theta = pi/60;
% eta = normrnd(0,1,[(2*pi)/d_theta+1 1]);
h = zeros(2*pi/d_theta+1,1);
j = 1;
theta = [-pi:d_theta:pi]';
for g=-1:1:1
    
    for i=1:2*pi/d_theta+1
        h(i) = 5*exp(-2*theta(i)^2) + g;
    end
    H(:,j)=h;
    j = j+1;
end

legendInfo = cell(3,1);
for i=1:3
    p = plot(theta,H(:,i));
    set(p,'LineWidth',2);
    hold on;
    legendInfo{i} = ['g = ' num2str(i-2)];
end

xlabel('\theta (radians)');
ylabel('h(\theta)');
title('Noisy Input');
legend(legendInfo);
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3b ii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Weight Matrix
W = zeros(length(theta));
for i = 1:length(theta)
    var = -pi;
    for j = 1:length(theta)
        W(i,j) = cos(theta(i)-var);
        var = var+d_theta;
    end
end

%% Initial
r = zeros(length(theta), T/dt+1);
r(1) = 0;
time = [0:dt:T];
F =  [-1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];
[x y] = size(r);
R = zeros(x,y,3);

%% Numerical integrator

for j = 1:3
    for i = 2:T/dt+1
       r(:,i) = MyEuler3(r(:,i-1), dt, lamda, H(:,j), W);
    end
    R(:,:,j) = r;
end

figure;
legendInfo = cell(3,1);
for i=1:3
    p = plot(theta,R(:,end,i));
    set(p,'LineWidth',2);
    hold on;
    legendInfo{i} = ['g = ' num2str(i-2)];
end

xlabel('\theta (radians)');
ylabel('R(\theta)');
title('Equilibrium Population Firing Rate');
legend(legendInfo);
grid on;