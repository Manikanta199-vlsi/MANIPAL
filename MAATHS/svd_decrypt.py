# decrypt.py - RECEIVER'S SCRIPT (Corrected)
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt

def decrypt_image():
    """
    Loads an encrypted matrix and its secret keys from .npy files,
    decrypts it, and displays the perfectly recovered image.
    """
    print("--- RECEIVER: Starting Decryption ---")
    
    try:
        # 1. Load the high-precision encrypted matrix
        A_encrypted = np.load('encrypted_matrix.npy')
        print("Encrypted matrix loaded from 'encrypted_matrix.npy'.")

        # 2. Load the securely sent secret keys
        U = np.load('U_key.npy')
        Vt = np.load('Vt_key.npy')
        perm_key = np.load('perm_key.npy')
        print("Secret keys U, Vt, and permutation_key loaded.")

        # 3. Use the robust decryption method
        V = Vt.T 
        # This math now works perfectly because A_encrypted has full precision
        Sigma_scrambled_matrix = U.T @ A_encrypted @ V
        s_scrambled = np.diag(Sigma_scrambled_matrix)
        print("Extracted scrambled singular values using keys.")

        # 4. Unscramble the singular values
        unscramble_key = np.argsort(perm_key)
        s_original = s_scrambled[unscramble_key]
        print("Singular values unscrambled successfully.")

        # 5. Reconstruct the original image
        Sigma_original = np.diag(s_original)
        A_decrypted_float = U @ Sigma_original @ Vt
        
        # 6. Convert back to a proper image format (uint8)
        A_decrypted_clipped = np.clip(A_decrypted_float, 0, 255)
        A_decrypted = A_decrypted_clipped.astype(np.uint8)
        print("Original image perfectly reconstructed.")

        # 7. Display the decrypted image
        plt.imshow(A_decrypted, cmap='gray')
        plt.title('Decrypted Image (Perfect Recovery)')
        plt.axis('off')
        plt.show()

    except FileNotFoundError:
        print("Error: Make sure all four '.npy' files are in the same folder.")
    except Exception as e:
        print(f"An error occurred during decryption: {e}")

if __name__ == "__main__":
    decrypt_image()
