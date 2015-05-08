clear all;
set(groot,'defaultTextInterpreter','none');
set(groot,'defaultLegendInterpreter','none');
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesFontSize',12);
set(groot,'defaultAxesPosition',[0.15,0.15,0.7,0.7]);

Cmu = 0.09;
Sstar = 3.3;

t_range = [0,10];
A = [10,1,0.5,0.1,0.01];

figure();
hold on;
for i = 1:length(A)
    t_start = t_range(1);
    t_end   = t_range(2) * A(i);
    init_cond = [0.00001,0.00001];
    [tvec,yvec] = ode45(@ode_a12_SKE,[t_start,t_end],init_cond);
    tvec = tvec / A(i);
    a12 = -Cmu .* yvec(:,1) ./ yvec(:,2) .* Sstar .* sin(tvec);
    plot(tvec,a12,'DisplayName',['w/S = ',num2str(A(i))]);
end
hold off;
xlabel('Time (S t)');
ylabel('a_{12}');
legend(gca,'show');

figure();
hold on;
for i = 1:length(A)
    t_start = t_range(1);
    t_end   = t_range(2) * A(i);
    init_cond = [0.00001,0.00001];
    [tvec,yvec] = ode45(@ode_a12_DKE,[t_start,t_end],init_cond);
    tvec = tvec / A(i);
    a12 = -Cmu .* yvec(:,1) ./ yvec(:,2) .* Sstar .* sin(tvec);
    plot(tvec,a12,'DisplayName',['w/S = ',num2str(A(i))]);
end
hold off;
legend(gca,'show');









