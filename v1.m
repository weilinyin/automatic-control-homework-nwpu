% Define transfer functions
s = tf('s');
G = 1 / s^2;  % Spacecraft transfer function
H = 1 / (0.1 * s + 1);  % Sensor transfer function

% Design lead compensator G_c(s)
zeta = 0.5;  % Damping ratio
omega_n = 2;  % Natural frequency (rad/s)

% Calculate desired closed-loop pole location
p1 = -zeta * omega_n + omega_n * sqrt(1 - zeta^2) * 1i;
p2 = conj(p1);

% Use pole placement to design lead compensator G_c(s)
K = 1;  % Assume initial gain
G_c = K * (s + 0.5) / (s + 2);  % Example lead compensator

% Open-loop transfer function with compensator
OLTF = G_c * G * H;

% Closed-loop transfer function
CLTF = feedback(OLTF, 1);

% Simulate step response
figure;
step(CLTF);
title('Closed-loop Step Response');
grid on;

% Analyze step response
info = stepinfo(CLTF);
overshoot = info.Overshoot;
settling_time = info.SettlingTime;

fprintf('Overshoot: %.2f%%\n', overshoot);
fprintf('Settling Time: %.2f seconds\n', settling_time);
