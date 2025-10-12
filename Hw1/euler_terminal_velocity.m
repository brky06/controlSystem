clear; clc;

g = 9.81;    
m = 68.1;    
c = 12.5;      
v_terminal = m * g / c;
t_end = 12;   
v0 = 0;

dv_dt = @(v) g - (c / m) * v;

t_exact = linspace(0, t_end, 200);
v_exact = v_terminal * (1 - exp(-(c / m) .* t_exact));

euler_solver = @(dt) euler_forward(dv_dt, v0, dt, t_end);

dt_coarse = 2.0;
[t_euler_coarse, v_euler_coarse] = euler_solver(dt_coarse);

dt_fine = 0.5;
[t_euler_fine, v_euler_fine] = euler_solver(dt_fine);

figure('Color', 'w', 'Position', [100, 100, 1000, 420]);

subplot(1, 2, 1);
plot(t_exact, v_exact, 'Color', [0.36, 0.43, 0.70], 'LineWidth', 2.5); hold on;
plot(t_euler_coarse, v_euler_coarse, 'o-', 'Color', [0.1, 0.1, 0.1], 'LineWidth', 1.4);
yline(v_terminal, '--', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.2);
grid on;
title('Euler vs Analytical (dt = 2 s)');
xlabel('t (s)');
ylabel('v (m/s)');
legend('Exact, analytical', 'Euler, dt = 2 s', 'Terminal velocity', 'Location', 'southeast');

subplot(1, 2, 2);
plot(t_exact, v_exact, 'Color', [0.36, 0.43, 0.70], 'LineWidth', 2.5); hold on;
plot(t_euler_coarse, v_euler_coarse, 'o-', 'Color', [0.1, 0.1, 0.1], 'LineWidth', 1.4);
plot(t_euler_fine, v_euler_fine, 's-', 'Color', [0.82, 0.43, 0.15], 'LineWidth', 1.4);
yline(v_terminal, '--', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.2);
grid on;
title('Effect of Smaller dt');
xlabel('t (s)');
legend('Exact, analytical', 'Euler, dt = 2 s', 'Euler, dt = 0.5 s', 'Terminal velocity', 'Location', 'southeast');

sgtitle('Numerical Results for Falling Body with Drag');

print('euler_terminal_velocity', '-dpng', '-r300');

function [t_values, v_values] = euler_forward(rhs, v0, dt, t_end)
    t_values = 0:dt:t_end;
    steps = numel(t_values);
    v_values = zeros(size(t_values));
    v_values(1) = v0;
    for k = 2:steps
        v_prev = v_values(k - 1);
        v_values(k) = v_prev + dt * rhs(v_prev);
    end
end
