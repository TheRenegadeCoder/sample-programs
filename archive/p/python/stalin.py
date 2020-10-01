#!usr/bin/python

def stalin(user_num):					# Function for Stalin Sort.
    a = 0
    while True:
        shift = 0
        for i in range(len(user_num) - 1 - a):
            if user_num[i] > user_num[i + 1]:			# Checking tow simultaneous values and comparing them (less , greater).
                user_num.insert(shift, user_num.pop(i + 1))	# EG : If first input is 6 and second input is 5 , 5 and 6 will interchange.
                shift += 1					# Move to next value.
        a += 1
        if shift == 0:
            break
    return user_num

# Main execution below

if __name__ == "__main__":
    user_num = [66, 1, 4, 88 , 6, 5, 8, 7, 10, 9]		# User's Input.

    print(stalin(user_num))


