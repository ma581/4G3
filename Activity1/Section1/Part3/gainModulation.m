%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3b i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setup
N = 10;
dt = 0.001;
T = 10;
lamda = 1;

%% Noisy Input
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