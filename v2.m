% 定义传递函数
s = tf('s');
G = 1 / s^2;  % 液压伺服机构的传递函数
G1= (2 * s + 0.1) / (s^2 + 0.1 * s +4); % 飞机的传递函数
H = 1;  % 速率脱落传递函数

% 开环传递函数
OLTF = G * G1 * H;

% 绘制原始系统的根轨迹
figure;
rlocus(OLTF);
title('原始系统根轨迹');
grid on;

% 期望闭环极点
p1 = -2 + 2 * sqrt(3) * 1i;
p2 = conj(p1);

% 在根轨迹上标注期望闭环极点
hold on;
plot(real(p1), imag(p1), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p2), imag(p2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

% 设计超前校正器 G_c(s)
z = 0;  % 补偿器零点
p = ;    % 补偿器极点
K = ;    % 初始增益
G_c = K * (s + z) / (s + p);  % 超前校正器

% 更新后的开环传递函数
OLTF_compensated = G_c * OLTF;

% 绘制带补偿器的根轨迹
figure;
rlocus(OLTF_compensated);
title('带超前校正器的系统根轨迹');
grid on;
hold on;
plot(real(p1), imag(p1), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p2), imag(p2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

% 调整增益，检查闭环极点的位置

CLTF = feedback(OLTF_compensated, 1);

% 验证设计：绘制阶跃响应
figure;
step(CLTF);
title('闭环系统的阶跃响应');
grid on;


% 输出系统的性能信息
info = stepinfo(CLTF);
overshoot = info.Overshoot;  % 超调量
settling_time = info.SettlingTime;  % 稳定时间

fprintf('超调量: %.2f%%\n', overshoot);
fprintf('稳定时间: %.2f 秒\n', settling_time);

% 使用 damp 函数验证阻尼比和自然频率
[wn, zeta, poles] = damp(CLTF);
fprintf('自然频率 (rad/s): %.2f\n', wn(2));
fprintf('阻尼比: %.2f\n', zeta(2));
