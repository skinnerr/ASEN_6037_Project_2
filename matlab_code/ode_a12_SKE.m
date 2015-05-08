function [ dy ] = ode_a12_SKE(T,y)

Cmu = 0.09;
Sstar = 3.3;
Ce1 = 1.44;
Ce2 = 1.92;

% fprintf('%5f  %5f  %5f\n',T,y(1),y(2));

% Time T is Sstar*tau.
% y is a vector of k_tilde and epsilon_tilde.

a12 = -Cmu * (y(1) / y(2)) * Sstar * sin(T);
dy = zeros(2,1);
dy(1) = -y(1) * a12 * Sstar * Cmu * sin(T);
dy(2) = -Ce1 * y(2) * a12 * Sstar * sin(T) - Ce2 * y(2)^2 / y(1);

end

