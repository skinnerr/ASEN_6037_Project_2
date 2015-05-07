close all; clear all;
set(groot,'defaultTextInterpreter','none');
set(groot,'defaultLegendInterpreter','none');
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesFontSize',12);

data1 = read_MKM_data('/home/ryan/Project_02/data/chan590.means');
data2 = read_MKM_data('/home/ryan/Project_02/data/chan590.kbal');
data3 = read_MKM_data('/home/ryan/Project_02/data/chan590.reystress');
data = [data1;data2;data3];
data.keys

figure();
plot(data('Umean'),data('y'));
ylabel('y');
xlabel('mean(u)');

figure();
hold on;
for field = {'R_uu','R_uv','R_uw','R_vv','R_vw','R_ww'}
    plot(data(field{1}),data('y'),'DisplayName',field{1});
end
hold off;
ylabel('y');
xlabel('Reynolds Stress');
legend(gca,'show');

figure();
k = zeros(length(data('y')),1);
for field = {'R_uu','R_vv','R_ww'}
    temp = data(field{1});
    k = k + temp / 2;
end
plot(k,data('y'));
ylabel('y');
xlabel('k');

