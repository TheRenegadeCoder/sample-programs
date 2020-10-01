import sys
import os
from PIL import Image #input(windows) python3 JPGtoPNGconverter.py picture\ new\
image_folder =sys.argv[1]  #directory of image to convert
output_folder = sys.argv[2] #directory to save in
if not os.path.exists(output_folder):
	os.makedirs(output_folder)

for filename in os.listdir(image_folder):
	
	img = Image.open(f'{image_folder}{filename}')
	clean_name = os.path.splitext(filename)[0]
	img.save(f'{output_folder}{clean_name}.png','png')
	print('all done!!!')
