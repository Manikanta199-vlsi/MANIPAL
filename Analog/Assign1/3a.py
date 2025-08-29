import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# Cutoff frequency
fc = 10000
wc = 2 * np.pi * fc

# Transfer function H(s) = wc / (s + wc)
num = [wc]
den = [1, wc]
system = signal.TransferFunction(num, den)

# Input: 1 kHz sinusoid
fsig = 1000
wsig = 2 * np.pi * fsig
t = np.linspace(0, 0.005, 5000)   # 5 ms duration
x = np.sin(wsig * t)

# Simulate response
t_out, y, _ = signal.lsim(system, U=x, T=t)

# Plot input vs output
plt.figure(figsize=(10,5))
plt.plot(t*1000, x, label="Input (1 kHz)")
plt.plot(t*1000, y, label="Output")
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Transfer Function Simulation (1 kHz Input)")
plt.legend()
plt.grid(True)
plt.show()
