%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3c i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup
N = 10;
dt = 0.001;
T = 50;
lamda = 1;

%% Noisy Input
d_theta = pi/60;
% eta = normrnd(0,1,[(2*pi)/d_theta+1 1]);
h = zeros(2*pi/d_theta+1,1);

theta = [-pi:d_theta:pi]';
for i=1:2*pi/d_theta+1
    h(i) = 5*exp(-2*(theta(i)-pi/2)^2) + 2.5*exp(-2*(theta(i)+pi/2)^2);
end

p = plot(theta,h);
set(p,'LineWidth',2);
hold on;

xlabel('\theta (radians)');
ylabel('h(\theta)');
title('Noisy Input');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3c ii
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


%% Numerical integrator


for i = 2:T/dt+1
   r(:,i) = MyEuler3(r(:,i-1), dt, lamda, h, W);
end


%% Plotting
figure;
legendInfo = cell(length(theta),1);


% for i=1:length(theta)
%     p = plot(theta(i),r(i,end),'.-');
%     legendInfo{i} = ['r_{\theta =' num2str(theta(i)) '}'];
%     set(p,'LineWidth',2);
%     hold on;
% end

p = plot(theta,r(:,end));
set(p,'LineWidth',2);
xlabel('\theta (radians)');
ylabel('r(\theta)');
title('Equilibrium Population Firing Rate');
% legend(legendInfo);
grid on;



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3c iii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Numerical integrator

h_zero = zeros(length(h),1);
j = length(r)+1;
for i = T/dt+1:dt:(T+0.01)/dt+1
   r(:,j) = MyEuler3(r(:,j-1), dt, lamda, h_zero, W);
   j = j+1;
end

figure;
p = plot(theta,r(:,end));
set(p,'LineWidth',2);
xlabel('\theta (radians)');
ylabel('r(\theta)');
title('Equilibrium Population Firing Rate 10ms later with no input');
% legend(legendInfo);
grid on;
  
