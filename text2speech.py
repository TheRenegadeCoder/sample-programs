import PyPDF2
import pyttsx3

# For this I have installed two libraries via pip command
# pip install pyttsx3
# pip install PDF2

speaker = pyttsx3.init()
speaker.say("WELCOME INTO THIS APPLICATION.")
speaker.runAndWait()

book = open('1.pdf','rb')  #Here add location of the pdf file that you want to listen to.
pdfReader = PyPDF2.PdfFileReader(book)
pages = pdfReader.numPages
print(pages)
speaker1 = pyttsx3.init()
for i in range(0,int(pages)):
    page = pdfReader.getPage(i)
    text = page.extractText()
    speaker1.say(text)
    speaker1.runAndWait()

#END



