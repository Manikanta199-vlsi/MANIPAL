import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# ==============================
# Filter Design Parameters
# ==============================
fc = 10e3   # cutoff frequency = 10 kHz
C = 1e-9    # 1 nF
R = 1 / (2 * np.pi * fc * C)   # calculate R from fc and C

print(f"Design values: R = {R:.2f} ohms (≈ {R/1e3:.2f} kΩ), C = {C} F, fc = {fc/1e3:.1f} kHz")

# ==============================
# First-order transfer function
# H(s) = 1 / (RC*s + 1)
# ==============================
num1 = [1.0]
den1 = [R*C, 1.0]
system1 = signal.TransferFunction(num1, den1)

# ==============================
# Second-order transfer function
# Cascaded two stages → square numerator and denominator
# ==============================
num2 = np.polymul(num1, num1)
den2 = np.polymul(den1, den1)
system2 = signal.TransferFunction(num2, den2)

# ==============================
# Frequency response
# ==============================
freq_hz = np.logspace(2, 6, 1000)   # from 100 Hz to 1 MHz
w_rad = 2 * np.pi * freq_hz         # convert to rad/s

# Bode response
w1, mag1, phase1 = signal.bode(system1, w_rad)
w2, mag2, phase2 = signal.bode(system2, w_rad)

# Convert back to Hz for plotting
freq_out = w1 / (2 * np.pi)

# ==============================
# Plot magnitude response
# ==============================
plt.figure(figsize=(10, 5))
plt.semilogx(freq_out, mag1, label="1st Order")
plt.semilogx(freq_out, mag2, '--', label="2nd Order")
plt.axvline(fc, color='red', linestyle=':', label=f"fc = {fc/1e3:.1f} kHz")
plt.title("Magnitude Response (Bode Plot)")
plt.ylabel("Magnitude (dB)")
plt.xlabel("Frequency (Hz)")
plt.legend()
plt.grid(which="both", linestyle="--", linewidth=0.5)
plt.tight_layout()
plt.show()

# ==============================
# Plot phase response
# ==============================
plt.figure(figsize=(10, 5))
plt.semilogx(freq_out, phase1, label="1st Order")
plt.semilogx(freq_out, phase2, '--', label="2nd Order")
plt.axvline(fc, color='red', linestyle=':', label=f"fc = {fc/1e3:.1f} kHz")
plt.title("Phase Response (Bode Plot)")
plt.ylabel("Phase (degrees)")
plt.xlabel("Frequency (Hz)")
plt.legend()
plt.grid(which="both", linestyle="--", linewidth=0.5)
plt.tight_layout()
plt.show()
