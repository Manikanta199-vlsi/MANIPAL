import numpy as np
import matplotlib.pyplot as plt

# Parameters
f = 1000          # frequency = 1 kHz
Fs = 100000       # sampling rate = 100 kHz (100 samples per cycle)
T = 1/Fs          # sampling interval
t = np.arange(0, 2e-3, T)   # 2 ms duration (enough for 2 cycles)

# Generate sine wave
A = 1             # amplitude = 1
y = A * np.sin(2 * np.pi * f * t)

# Plot
plt.figure(figsize=(8,4))
plt.plot(t*1000, y)   # time in milliseconds
plt.title("1 kHz Sine Wave")
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.grid(True)
plt.show()
