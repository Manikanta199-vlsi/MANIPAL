import numpy as np
import matplotlib.pyplot as plt

# Time settings
fs = 1000       # Sampling frequency in Hz
T = 1           # Duration in seconds
t = np.linspace(0, T, int(fs*T), endpoint=False)  # Time vector

# Input signal
x = np.sin(2 * np.pi * 1 * t)  # 1 Hz sine wave

# Updated Output function
Y = 2*x + (x**2)/8 + (x**3)/32

# --- Plot time-domain signal ---
plt.figure(figsize=(12,5))
plt.plot(t, Y)
plt.xlabel('Time (s)')
plt.ylabel('Y(t)')
plt.title('Time-Domain Signal of Updated Y(t)')
plt.grid(True)
plt.show()

# FFT
Y_fft = np.fft.fft(Y)
freq = np.fft.fftfreq(len(Y), d=1/fs)

# Take only the positive frequencies
idx = np.arange(len(freq)//2)
freq = freq[idx]
Y_fft_magnitude = np.abs(Y_fft[idx]) / len(Y)  # Normalize amplitude

# --- Plot FFT with highlighted harmonics ---
plt.figure(figsize=(12,5))
plt.stem(freq, Y_fft_magnitude, basefmt=" ")  # Removed use_line_collection
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.title('FFT of Updated Y(t) with Harmonics Highlighted')
plt.grid(True)

# Highlight harmonics
harmonics = [1, 2, 3, 4, 5]  # Expected harmonics from nonlinear terms
for h in harmonics:
    if h < fs/2:  # Only plot within Nyquist
        idx_h = np.argmin(np.abs(freq - h))
        plt.plot(h, Y_fft_magnitude[idx_h], 'ro')  # red dot
        plt.text(h, Y_fft_magnitude[idx_h]+0.01, f'{h} Hz', color='red', ha='center')

plt.show()
