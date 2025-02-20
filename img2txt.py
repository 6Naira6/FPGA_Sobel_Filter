import numpy as np
from PIL import Image

image = Image.open("image_in.jpg").convert("L")
image_array = np.array(image)
np.savetxt("input.txt", image_array, fmt="%d")
