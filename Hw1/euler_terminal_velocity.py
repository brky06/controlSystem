import numpy as np
import matplotlib.pyplot as plt


def euler_method(rhs, t0, y0, dt, t_end):
    t_values = [t0]
    y_values = [y0]
    t = t0
    y = y0

    while t < t_end - 1e-12:
        y = y + dt * rhs(t, y)
        t = t + dt
        t_values.append(t)
        y_values.append(y)
    return np.array(t_values), np.array(y_values)
g = 9.81  
m = 68.1  
c = 12.5  
v_terminal = m * g / c
t_end = 12.0  
v0 = 0.0
def dv_dt(_t, v):
    return g - (c / m) * v
dt_coarse = 2.0
t_euler_coarse, v_euler_coarse = euler_method(dv_dt, 0.0, v0, dt_coarse, t_end)

t_exact = np.linspace(0.0, t_end, 200)
v_exact = v_terminal * (1.0 - np.exp(-(c / m) * t_exact))
dt_fine = 0.5
t_euler_fine, v_euler_fine = euler_method(dv_dt, 0.0, v0, dt_fine, t_end)

fig, axes = plt.subplots(1, 2, figsize=(12, 5), sharey=True)

    # Plot 1:
ax0 = axes[0]
ax0.plot(t_exact, v_exact, label="Exact, analytical", color="#5b6cb3", linewidth=2.5)
ax0.plot(t_euler_coarse, v_euler_coarse, "o-", label="Euler, dt = 2 s", color="#1b1b1b")
ax0.axhline(v_terminal, linestyle="--", color="0.5", linewidth=1.5, label="Terminal velocity")
ax0.set_xlabel("t (s)")
ax0.set_ylabel("v (m/s)")
ax0.set_title("Euler vs analytical (dt = 2 s)")
ax0.grid(True, linestyle=":", linewidth=0.7)

    # Plot 2
ax1 = axes[1]
ax1.plot(t_exact, v_exact, label="Exact, analytical", color="#5b6cb3", linewidth=2.5)
ax1.plot(t_euler_coarse, v_euler_coarse, "o-", label="Euler, dt = 2 s", color="#1b1b1b")
ax1.plot(t_euler_fine, v_euler_fine, "s-", label="Euler, dt = 0.5 s", color="#d16d27")
ax1.axhline(v_terminal, linestyle="--", color="0.5", linewidth=1.5, label="Terminal velocity")
ax1.set_xlabel("t (s)")
ax1.set_title("Effect of smaller dt")
ax1.grid(True, linestyle=":", linewidth=0.7)

fig.suptitle("Numerical Results for Falling Body with Drag", fontsize=14, y=1.02)
fig.tight_layout()
fig.savefig("euler_terminal_velocity.png", dpi=300, bbox_inches="tight")
plt.show()
