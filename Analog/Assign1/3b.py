import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# Cutoff frequency
fc = 10000          # 10 kHz
wc = 2 * np.pi * fc # rad/s

# Transfer function H(s) = wc / (s + wc)
num = [wc]          # numerator coefficients
den = [1, wc]       # denominator coefficients

# Define system
system = signal.TransferFunction(num, den)

# Frequency range for plotting
w, mag, phase = signal.bode(system)

# --- Magnitude plot ---
plt.figure(figsize=(10,5))
plt.semilogx(w/(2*np.pi), mag)  # convert rad/s -> Hz
plt.title("Bode Magnitude Plot")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude (dB)")
plt.grid(True)

# --- Phase plot ---
plt.figure(figsize=(10,5))
plt.semilogx(w/(2*np.pi), phase)
plt.title("Bode Phase Plot")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (degrees)")
plt.grid(True)

plt.show()
