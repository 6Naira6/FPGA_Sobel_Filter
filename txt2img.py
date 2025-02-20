from PIL import Image
import numpy as np

# Load the matrix of grayscale values from the text file
image_array = np.loadtxt("output.txt", dtype=np.uint8)

# Create an image object from the array
image = Image.fromarray(image_array, mode="L")

# Save the image as a file
image.save("image_out.jpg")
