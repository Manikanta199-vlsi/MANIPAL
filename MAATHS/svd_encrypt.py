# encrypt.py - SENDER'S SCRIPT (with visualization)
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt # Import for plotting

def encrypt_image(image_path):
    """
    Encrypts an image, saves the necessary files, and displays a
    visual representation of the encrypted image.
    """
    print("--- SENDER: Starting Encryption ---")
    
    try:
        # 1. Load the original image and convert to a matrix
        original_image = Image.open(image_path).convert('L')
        A = np.array(original_image)
        print(f"Original image '{image_path}' loaded. Shape: {A.shape}")

        # 2. Perform SVD
        U, s, Vt = np.linalg.svd(A, full_matrices=False)
        print("SVD performed on the image matrix.")

        # 3. Generate and save the permutation key
        perm_key = np.random.permutation(len(s))
        np.save('perm_key.npy', perm_key)
        print("Secret permutation key saved to 'perm_key.npy'.")

        # 4. Scramble the singular values
        s_scrambled = s[perm_key]
        
        # 5. Reconstruct the encrypted matrix (as a float array)
        Sigma_scrambled = np.diag(s_scrambled)
        A_encrypted_float = U @ Sigma_scrambled @ Vt
        
        # 6. Save the encrypted MATRIX with full precision
        np.save('encrypted_matrix.npy', A_encrypted_float)
        print("Encrypted matrix saved with full precision as 'encrypted_matrix.npy'.")

        # 7. Save the U and Vt matrices as secret keys
        np.save('U_key.npy', U)
        np.save('Vt_key.npy', Vt)
        print("Secret keys 'U_key.npy' and 'Vt_key.npy' saved.")

        print("\n--- Encryption Complete ---")
        
        # --- NEW VISUALIZATION STEP ---
        # 8. Create a displayable version of the encrypted image
        #    This is for viewing only and does not affect the saved data.
        A_encrypted_display = np.clip(A_encrypted_float, 0, 255).astype(np.uint8)
        
        # 9. Display the noisy encrypted image
        print("Displaying the visual representation of the encrypted image...")
        plt.imshow(A_encrypted_display, cmap='gray')
        plt.title('Encrypted Image (Visual Representation)')
        plt.axis('off')
        plt.show()

    except FileNotFoundError:
        print(f"Error: The file '{image_path}' was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    encrypt_image('cameraman.tif')
