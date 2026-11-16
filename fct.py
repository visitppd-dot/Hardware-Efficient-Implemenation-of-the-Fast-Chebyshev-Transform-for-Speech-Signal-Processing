#Fast chebyshev transform calculation


import numpy as np
import matplotlib.pyplot as plt

#Compute fct
def compute_Y(x):
    x = np.asarray(x, dtype=float)
    N = len(x) - 1

    Y = np.zeros(N + 1)
    factor = np.sqrt(2 / N)

    for k in range(N + 1):
        s = x[0] / 2 + x[N] / 2
        for n in range(1, N):
            s += x[n] * np.cos(np.pi * n * k / N)
        Y[k] = factor * s

    return Y
x = [8,
19,
12,
6,
-2,
-2,
-3,
-8,
-2,
5,
4,
12,
19,
4,
-6,
2,
3,
]  # x0 ... xN (here N = 4)
Y = compute_Y(x)
print(Y)


# python vs fpga comparision


py = np.array([
    23.15774708, 4.46323562, 11.74102822, 24.18408098,
    -5.27297077, 0.33111612, 4.64882703, -7.06585675,
    4.77297077, -9.40993629, -1.84552617, 4.61423589,
    -4.27297077, -0.35125841, -3.93772736, -1.20926799,
    -3.7123106
])

# FPGA/Vivado output
fpga = np.array([
    23, 5, 12, 24, -5, 0, 5, -6,
    4, -10, -1, 6, -5, -2, -4, -1, -4
])

# Error metrics
mse = np.mean((py - fpga)**2)
rmse = np.sqrt(mse)

print("MSE =", mse)
print("RMSE =", rmse)

# Coefficient index
x = np.arange(len(py))

# Plot
plt.figure(figsize=(8,5))

plt.plot(
    x, py,
    marker='o',
    linewidth=2,
    label='Python Output'
)

plt.plot(
    x, fpga,
    marker='s',
    linestyle='--',
    linewidth=2,
    label='FPGA Output'
)

plt.xlabel("Coefficient Index")
plt.ylabel("Coefficient Value")
plt.title("Python vs FPGA Output Comparison")
plt.grid(True)
plt.legend()

plt.tight_layout()

# Save high-resolution figure
plt.savefig("fct_validation1.png", dpi=300)

plt.show()



#Code conversion
from scipy.io import wavfile

sr, data = wavfile.read('C:/Users/WS_09/Desktop/noizeus/clean/sp01.wav')

print(sr)          # Should be 8000
print(data.dtype)  # int16 or float32
print(data.min(), data.max())

import numpy as np

# Normalize to [-1,1]
data_norm = data / np.max(np.abs(data))

# Convert to full Q1.15 range
q15 = (data_norm * 32767).astype(np.int16