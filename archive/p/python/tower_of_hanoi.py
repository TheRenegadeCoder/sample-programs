def tower_of_hanoi(n , source, destination, aux): 
	if n == 1: 
		print('Move disk 1 from source',source,'to destination',destination) 
		return
	tower_of_hanoi(n-1, source, aux, destination) 
	print ('Move disk',n,'from source',source,'to destination',destination) 
	tower_of_hanoi(n-1, aux, destination, source) 
		

n = int(input('Enter the number of disk: '))
tower_of_hanoi(n,'A','C','B') 

