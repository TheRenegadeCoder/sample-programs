

class trieNode(object):
	def __init__(self, char:str):
		self.char = char
		self.childs = []
		self.completeWord = False

#function to add nodes to the trie
def addNode(rootNode, word:str):
	node = rootNode 				#Start at the beginning
	for char in word:				#search for each of the letter
		found = False
		for child in node.childs:	#does current node have dem letter?
			if child.char == char:	#did we find it?
				node = child 		#Hail yeah we did, make that our current node
				found = True
				break
		#If no findy-findy create a new node for the current char
		if not found:
			newNode = trieNode(char) 	#Create node for new char-zard
			node.childs.append(newNode) #Append it to the childs
			node = newNode				#change to that new node

	node.completeWord = True			#Set flag statign current node is a word

# Function to display terminus nodes (them with them there complete words)
def dispChilds(Node,word:str):
	partWord = word + Node.char 	# cat parent to current norde
	if Node.completeWord == True:	#if the node is a word but got childs
		print(partWord)	

	if len(Node.childs) != 0:		#if we got kids!
		for child in Node.childs:	
			dispChilds(child,partWord) 	#recursion!

#create the mother node
root = trieNode('*')

addNode(root,"Dasher")
addNode(root,"Dancer")
addNode(root,"Prancer")
addNode(root,"Dashy")
addNode(root,"Dan")
#
# Now we got a trie that looks like this where *<>* indicates the 
# end of a complete word.
#			     *
#			    / \
#			   D    P
# 			  /      \
#			 A 		  R
#          /   \	   \
#		  S    *N*		A
# 		 /		 \		 \
#		H 		  C 	  N
# 	   / \   	   \	   \
# 	  E  *Y*		E 		C
#    / 				 \  	 \ 
#  *R*				 *R*     E
#							   \
#							   *R*
dispChilds(root,"")


#Pull in the presidents names and build trie
print("\n\nNow look at a trie of the U.S. Presidents:\n")
root = trieNode('*')
#Could use these if we want to read in a list
#print("-- opening --")
#with open("names.txt") as f: 	#example data
#	file = f.readlines() 		#read the lines in as list, name list "file"

#creat list to make dictionary from
file =['George Washington','John Adams','Thomas Jefferson',
		'James Madison','James Monroe','Daniel D. Tompkins',
		'John Quincy Adams','Andrew Jackson','Martin Van Buren',
		'William Henry Harrison','John Tyler','James K. Polk',
		'Zachary Taylor','Millard Fillmore','Franklin Pierce',
		'James Buchanan','Abraham Lincoln','Andrew Johnson',
		'Ulysses S. Grant','Rutherford Birchard Hayes',
		'James A. Garfield','Chester A. Arthur','Grover Cleveland',
		'Benjamin Harrison','Levi P. Morton','Grover Cleveland',
		'William McKinley','Theodore Roosevelt','William H. Taft',
		'Woodrow Wilson','Thomas R. Marshall','Warren G. Harding',
		'Calvin Coolidge','Herbert Hoover','Franklin D. Roosevelt',
		'Harry S. Truman','Dwight D. Eisenhower','John F. Kennedy',
		'Lyndon B. Johnson','Richard M. Nixon','Gerald R. Ford',
		'Jimmy Carter','Ronald Reagan','George Bush','Bill Clinton',
		'George W. Bush','Barack Obama','Donald J. Trump']


#add nodes in the example text by each line in the list
for line in file:
	addNode(root,line)
dispChilds(root,"")

#Why do this?
#We can use Tries to make GUIs cleaner with autofil as the user types.
#--> As the user enters letter we move down a Trie branch, if the current
#--> node has children present all completed words down the trie branch.