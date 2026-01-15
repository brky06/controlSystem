clc; clear; close all;

s = tf('s');

Gc = 10;            
Gp = 1/(s+1);       
H = 1;              


T_ref = feedback(Gc*Gp, H);


T_dist = Gp / (1 + Gc*Gp*H);

t = 0:0.01:3;

[y_r, t] = step(T_ref, t);   
[y_d, t] = step(T_dist, t); 


y_total = y_r + y_d;

figure;
plot(t, y_r, 'b--', 'LineWidth', 1.5); hold on;
plot(t, y_d, 'r--', 'LineWidth', 1.5);
plot(t, y_total, 'k-', 'LineWidth', 2);

grid on;
legend('Response to Reference (R)', 'Response to Disturbance (D)', 'Total Response (R+D)');
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Lab 6: Verification of Superposition Principle');

