from PIL import Image
import matplotlib.pyplot as plt

def encrypt_grayscale_and_plot(image_path, key, output_path):
    """
    Encrypts a grayscale image, saves it, and then plots both the 
    original and encrypted images for comparison.
    """
    try:
        # --- Encryption Logic (same as before) ---
        original_img = Image.open(image_path)
        pixels = original_img.load()
        width, height = original_img.size

        encrypted_img = Image.new('L', (width, height))
        encrypted_pixels = encrypted_img.load()

        for i in range(width):
            for j in range(height):
                pixel_value = pixels[i, j]
                encrypted_pixels[i, j] = pixel_value ^ key

        encrypted_img.save(output_path)
        print(f"✅ Image encrypted and saved to '{output_path}'")

        # --- Plotting Logic (new part) ---
        
        # Create a figure to display the images
        fig, axes = plt.subplots(1, 2, figsize=(10, 5))

        # Plot the Original Image
        axes[0].imshow(original_img, cmap='gray')
        axes[0].set_title('Original Image')
        axes[0].axis('off')  # Hide the axes ticks

        # Plot the Encrypted Image
        axes[1].imshow(encrypted_img, cmap='gray')
        axes[1].set_title('Encrypted Image')
        axes[1].axis('off')  # Hide the axes ticks
        
        # Display the plot window
        plt.suptitle(f'Encryption with Key: {key}', fontsize=16)
        plt.show()

    except FileNotFoundError:
        print(f"❌ Error: '{image_path}' not found. Please ensure it's in the correct folder.")
    except Exception as e:
        print(f"An error occurred: {e}")


# --- Main execution ---
if __name__ == "__main__":
    # Define file paths and the secret key
    original_image_file = 'cameraman.tif'
    encrypted_image_file = 'encrypted_cameraman.tif'
    secret_key = 143 

    # Run the function
    encrypt_grayscale_and_plot(original_image_file, secret_key, encrypted_image_file)
