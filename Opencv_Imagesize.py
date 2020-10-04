<!--Using opencv to determine the size of an image-->
import imutils
import cv2

image=cv2.imread("/Users/anshul.choudhary@ibm.com/PycharmProjects/opencv/sample.png")
(h,w,d) = image.shape
print ("width={},height={},depth={}".format(w,h,d))


cv2.imshow("Image",image)
cv2.waitKey(0)
