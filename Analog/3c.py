import numpy as np
import matplotlib.pyplot as plt

# Cutoff frequency
fc = 10000
wc = 2 * np.pi * fc

# Test frequencies
freqs = [1000, 5000, 10000, 15000, 20000, 25000]

# Time vector (long enough to show cycles)
t = np.linspace(0, 3e-3, 1000)  # 3 ms

# Store signals
inputs = []
outputs = []

for f in freqs:
    w = 2 * np.pi * f
    # Transfer function H(jw)
    H = wc / (1j*w + wc)
    mag = abs(H)
    phase = np.angle(H)
    
    # Input = 1 V amplitude
    x = np.sin(w*t)
    # Output = attenuated + shifted
    y = mag * np.sin(w*t + phase)
    
    inputs.append(x)
    outputs.append(y)

# --- Page 1 (first 3 freqs) ---
fig, axs = plt.subplots(3, 2, figsize=(12, 8))
fig.suptitle("RC Low-Pass Filter Response (Page 1)", fontsize=14)

for i, f in enumerate(freqs[:3]):
    # Left = magnitude comparison
    axs[i, 0].plot(t*1000, inputs[i], 'b', label="Input")
    axs[i, 0].plot(t*1000, outputs[i], 'r', label="Output")
    axs[i, 0].set_ylabel(f"{f/1000:.1f} kHz")
    axs[i, 0].legend()
    axs[i, 0].grid(True)

    # Right = phase shift view (zoom to few cycles)
    axs[i, 1].plot(t*1000, inputs[i], 'b')
    axs[i, 1].plot(t*1000, outputs[i], 'r')
    axs[i, 1].set_xlim(0, 1.0)   # zoom in (1 ms window)
    axs[i, 1].grid(True)

axs[2, 0].set_xlabel("Time (ms)")
axs[2, 1].set_xlabel("Time (ms)")

plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.show()

# --- Page 2 (next 3 freqs) ---
fig, axs = plt.subplots(3, 2, figsize=(12, 8))
fig.suptitle("RC Low-Pass Filter Response (Page 2)", fontsize=14)

for i, f in enumerate(freqs[3:]):
    idx = i + 3
    # Left = magnitude comparison
    axs[i, 0].plot(t*1000, inputs[idx], 'b', label="Input")
    axs[i, 0].plot(t*1000, outputs[idx], 'r', label="Output")
    axs[i, 0].set_ylabel(f"{f/1000:.1f} kHz")
    axs[i, 0].legend()
    axs[i, 0].grid(True)

    # Right = phase shift view
    axs[i, 1].plot(t*1000, inputs[idx], 'b')
    axs[i, 1].plot(t*1000, outputs[idx], 'r')
    axs[i, 1].set_xlim(0, 1.0)   # zoom for clear phase lag
    axs[i, 1].grid(True)

axs[2, 0].set_xlabel("Time (ms)")
axs[2, 1].set_xlabel("Time (ms)")

plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.show()
