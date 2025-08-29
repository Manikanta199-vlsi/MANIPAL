import numpy as np
import matplotlib.pyplot as plt

# Time axis
t = np.linspace(0, 2, 2000)   # simulate 2 seconds, 2000 samples

# Input signal x(t)
x = np.sin(2 * np.pi * 1 * t)   # 1 Hz sine wave

# Function Y
y = 2*x + (x**2)/4 + (x**3)/16

# Plot
plt.figure(figsize=(10,5))
plt.plot(t, x, label="x(t) = sin(2πt)", color='blue')
plt.plot(t, y, label="y(t)", color='red')
plt.xlabel("Time (s)")
plt.ylabel("Amplitude")
plt.title("Simulation of Y = 2x + (x^2)/4 + (x^3)/16")
plt.legend()
plt.grid(True)
plt.show()
