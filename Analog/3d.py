import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# Cutoff frequency
fc = 10000        # 10 kHz
wc = 2 * np.pi * fc

# Transfer function H(s) = wc / (s + wc)
num = [wc]
den = [1, wc]
system = signal.TransferFunction(num, den)

# Input: 10 kHz square wave
fsig = 10000       # 10 kHz
wsig = 2 * np.pi * fsig
t = np.linspace(0, 0.002, 5000)   # 2 ms duration to show a few cycles
x = signal.square(wsig * t)       # Square wave input

# Simulate response
t_out, y, _ = signal.lsim(system, U=x, T=t)

# Plot input vs output
plt.figure(figsize=(10,5))
plt.plot(t*1000, x, label="Input (10 kHz Square Wave)")
plt.plot(t*1000, y, label="Output")
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Low-Pass Filter Response to 10 kHz Square Wave")
plt.legend()
plt.grid(True)
plt.show()
