import pyttsx3
import PyPDF2
book = open('Algorithms.pdf', 'rb')
pdfReader = PyPDF2.PdfFileReader(book)
pages = pdfReader.numPages
print(pages)

speaker = pyttsx3.init()
# speaker.setProperty('rate', 150)
# speaker.setProperty('volume', 0.7)
for num in range(6, pages):
    page = pdfReader.getPage(num)
    text = page.extractText()
#     speaker.say(text)
#     speaker.runAndWait()

voice_id = "english-us"
  
# Use female voice 
speaker.setProperty('voice', voice_id) 
speaker.say(text)
  
speaker.runAndWait()

voices = speaker.getProperty('voices') 
  
# for voice in voices: 
#     # to get the info. about various voices in our PC  
#     print("Voice:") 
#     print("ID: %s" %voice.id) 
#     print("Name: %s" %voice.name) 
#     print("Age: %s" %voice.age) 
#     print("Gender: %s" %voice.gender) 
#     print("Languages Known: %s" %voice.languages)