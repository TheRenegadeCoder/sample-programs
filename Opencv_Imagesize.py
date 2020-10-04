#Using opencv to determine the size of an image
#Run: python Opencv_Imagesize.py
import imutils
import cv2

image=cv2.imread("<dir_path>/<image_name>")
(h,w,d) = image.shape
print ("width={},height={},depth={}".format(w,h,d))
cv2.imshow("Image",image)
cv2.waitKey(0)
