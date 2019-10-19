text = str(input("Enter a word or phrase to be pig-latin-ified"))
#text = "blind eggs"
def pig_it(text):
	print ('pigging \n')
	break_at_space = text.split(" ")
	new_phrase = ''
	punctuation = ('.', '!', '?')
	vowels = ("a", "e", "i", "o", "u", "y")
	for word in break_at_space:
 #	   vowel_check = word[0]
  #	  con_cluster_check = word[1]
		if word in punctuation:
			new_phrase += word
		elif word[0] in vowels:
			x = word + "yay" + " "
			new_phrase += x
		elif word[0] not in vowels:
			count = 0
			new_word = word
			while count < len(new_word):
				new_word = new_word[1:len(new_word)] + new_word[0]
				if new_word[0] not in vowels:
					count += 1
				elif new_word[0] in vowels:
					x = new_word + "ay" + " "
					new_phrase += x
					count = len(word)
		final = new_phrase.strip()
	return final
print (pig_it(text))
