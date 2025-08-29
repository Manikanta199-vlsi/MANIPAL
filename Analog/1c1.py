import numpy as np
import matplotlib.pyplot as plt

# Sampling parameters
Fs = 100000       # sampling rate (100 kHz)
T = 1/Fs          # sampling interval
t = np.arange(0, 2e-3, T)   # 2 ms duration

# Frequencies
freqs = [1000, 3000, 5000, 7000]  # Hz
amplitude = 5   # 5V amplitude

# ---------------- PAGE 1: Individual signals ----------------
fig, axs = plt.subplots(2, 2, figsize=(10,6))
axs = axs.ravel()

for i, f in enumerate(freqs):
    y = amplitude * np.sin(2*np.pi*f*t)
    axs[i].plot(t*1000, y)
    axs[i].set_title(f"{f/1000:.0f} kHz Sine Wave (Amplitude = {amplitude}V)")
    axs[i].set_xlabel("Time (ms)")
    axs[i].set_ylabel("Amplitude (V)")
    axs[i].grid(True)

plt.tight_layout()
plt.show()

# ---------------- PAGE 2: Sum of signals ----------------
y_sum = np.zeros_like(t)
for f in freqs:
    y_sum += amplitude * np.sin(2*np.pi*f*t)

plt.figure(figsize=(10,4))
plt.plot(t*1000, y_sum, color='black')
plt.title("Sum of 1, 3, 5, 7 kHz Sinusoids (Amplitude = 5V each)")
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude (V)")
plt.grid(True)
plt.show()
