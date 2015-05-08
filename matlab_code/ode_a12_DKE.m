function [ dy ] = ode_a12_DKE(T,y)

Cmu = 0.09;
Sstar = 3.3;
Ce1 = 1.44;
Ce2 = 1.92;
C1 = 1.5;
C2 = 0.8;

% fprintf('%5f  %5f  %5f\n',T,y(1),y(2));

% Time T is Sstar*tau.
% y is a vector of k_tilde, epsilon_tilde, and a12.

alpha1 = -(y(1)/y(2)) * y(3) * Sstar * sin(T) - 1 + C1;
alpha2 = C2 - (4/3);
dy = zeros(2,1);
dy(1) = -y(1) * y(3) * Sstar * Cmu * sin(T);
dy(2) = -Ce1 * y(2) * y(3) * Sstar * sin(T) - Ce2 * y(2)^2 / y(1);
dy(3) = -alpha1 * (y(1)/y(2)) * y(3) + 0.5*alpha2 * Sstar * sin(T);

end

