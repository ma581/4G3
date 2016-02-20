%% Question 1
% Input amplification and integration with a feed-forward linear network



%% 1a
% syms r(t);
N = 10;
syms r(t)
lamda = 1;
R = cell(N,1);
legendInfo = cell(N,1);
%F = normrnd(0,1,[N 1]);
F =  [-1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];
I = 1;
figure(1);

for i=1:N
    R{i} = dsolve(diff(r) + lamda*r == F(i)*I, r(0) == 0);
    %Plotting
    h = ezplot(R{i},[0,5,-4 4]);
    legendInfo{i} = ['r' num2str(i) ' (F = ' num2str(F(i)) ')'];
    set(h,'LineWidth',2);
    hold on;
end
xlabel('Time(s)');
ylabel('Firing Rate(s^{-1})');
title('Firing Rates');
legend(legendInfo);
grid on;
% ezplot(R,[0,5])

%% 1d
prompt = 'Do you want to run 1d?';
hello = input(prompt);

syms x
dR = zeros(N,1);
r_at_t5 = zeros(N,1);
legendInfo2 = cell(N,1);
figure;
for i = 1:N
    dR(i) = solve(-1*lamda*x + F(i)*I);
    r_at_t5(i) = eval(subs(R{i},5));
    p = plot(r_at_t5(i), dR(i),'x');
    set(p,'LineWidth',2);
    hold on;
    legendInfo2{i} = ['r_{inf}' num2str(i) ' (F = ' num2str(F(i)) ')'];
end
% p = plot(r_at_t5(:,1), dR(:,1),'x');
% set(p,'LineWidth',2);

xlabel('r_{inf} (s^{-1})');
ylabel('r(t=5) (s^{-1})');
title('Equilibrium Rates');
legend(legendInfo2);
grid on;
