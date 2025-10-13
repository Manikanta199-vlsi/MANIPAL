from PIL import Image
import matplotlib.pyplot as plt

def decrypt_grayscale_and_plot(encrypted_image_path, key, output_path):
    """
    Decrypts a grayscale image using the same key it was encrypted with,
    saves the result, and plots both images for comparison.
    """
    try:
        # 1. Open the encrypted image
        encrypted_img = Image.open(encrypted_image_path)
        pixels = encrypted_img.load()
        width, height = encrypted_img.size

        # 2. Create a new blank image for the decrypted output
        decrypted_img = Image.new('L', (width, height))
        decrypted_pixels = decrypted_img.load()

        # 3. The decryption logic is IDENTICAL to encryption
        # Applying the same XOR operation again reverses it.
        for i in range(width):
            for j in range(height):
                encrypted_value = pixels[i, j]
                # Decrypt the pixel by applying the XOR operation with the same key
                decrypted_value = encrypted_value ^ key
                decrypted_pixels[i, j] = decrypted_value

        # 4. Save the fully decrypted image
        decrypted_img.save(output_path)
        print(f"✅ Image decrypted successfully and saved to '{output_path}'")

        # --- Plotting Logic ---
        fig, axes = plt.subplots(1, 2, figsize=(10, 5))

        # Plot the Encrypted Image (Input)
        axes[0].imshow(encrypted_img, cmap='gray')
        axes[0].set_title('Encrypted Image (Input)')
        axes[0].axis('off')

        # Plot the Decrypted Image (Output)
        axes[1].imshow(decrypted_img, cmap='gray')
        axes[1].set_title('Decrypted Image (Output)')
        axes[1].axis('off')

        plt.suptitle(f'Decryption with Key: {key}', fontsize=16)
        plt.show()

    except FileNotFoundError:
        print(f"❌ Error: '{encrypted_image_path}' not found. Make sure you have run the encryption script first.")
    except Exception as e:
        print(f"An error occurred: {e}")


# --- Main execution ---
if __name__ == "__main__":
    # Define the file paths
    encrypted_image_file = 'encrypted_cameraman.tif'
    decrypted_image_file = 'decrypted_cameraman.tif'

    # IMPORTANT: You MUST use the exact same key you used for encryption.
    secret_key = 143

    # Run the decryption function
    decrypt_grayscale_and_plot(encrypted_image_file, secret_key, decrypted_image_file)
