clc; clear; close all;


s = tf('s'); % Laplace değişkeni tanımlama


G1 = 10 / (s + 2);      
G2 = 1 / (s + 5);        
H1 = 0.5;               

InnerLoop = feedback(G1, H1);

Original_Sys = series(InnerLoop, G2); 


num_simp = [10];          % Pay katsayıları
den_simp = [1 7 15];      % Payda katsayıları (s^2, s^1, s^0)
Simplified_Sys = tf(num_simp, den_simp);

%% 2. SIMULATIONS

t = 0:0.01:10; 

figure(1);
step(Original_Sys, 'b', Simplified_Sys, 'r--');
legend('Original Complex System', 'Simplified Hand-Calc System');
title('Step Input Response Comparison');
xlabel('Time (sec)'); ylabel('Amplitude');
grid on;

figure(2);
impulse(Original_Sys, 'b', Simplified_Sys, 'r--');
legend('Original Complex System', 'Simplified Hand-Calc System');
title('Impulse Input Response Comparison');
xlabel('Time (sec)'); ylabel('Amplitude');
grid on;

ramp_input = t; 

[y_orig, ~] = lsim(Original_Sys, ramp_input, t);
[y_simp, ~] = lsim(Simplified_Sys, ramp_input, t);

figure(3);
plot(t, ramp_input, 'k:', 'LineWidth', 1); hold on; % Giriş sinyali (referans)
plot(t, y_orig, 'b', 'LineWidth', 1.5);
plot(t, y_simp, 'r--', 'LineWidth', 1.5);
legend('Ramp Input (Reference)', 'Original System', 'Simplified System');
title('Ramp Input Response Comparison');
xlabel('Time (sec)'); ylabel('Amplitude');
grid on;

%% 3. VERIFICATION OUTPUT
fprintf('--- Model Doğrulama Sonuçları ---\n');
fprintf('Original System Poles:\n');
disp(pole(Original_Sys));
fprintf('Simplified System Poles:\n');
disp(pole(Simplified_Sys));

if isequal(zpk(Original_Sys), zpk(Simplified_Sys))
    disp('SUCCESS: Both systems are mathematically IDENTICAL.');
else
    disp('NOTE: Check your simplification manually. Small numerical errors are normal.');
end
