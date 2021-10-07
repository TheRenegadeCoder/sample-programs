import random
import sys

def get_verification_code(total, asStr=False):
    mod = (total * 10) % 11
    mod = mod if mod<10 else 0
    return str(mod) if asStr else mod

verification_code1 = None
verification_code2 = None

total_code1 = 0
total_code2 = 0
cpf = []

for i in reversed(range(1, 10)):
    multiplier = i+1
    digit = random.randrange(0, 9)
    cpf.append(str(digit))
    total_code1 = total_code1 + digit*(multiplier)
    total_code2 = total_code2 + digit*(multiplier+1)

verification_code1 = get_verification_code(total_code1)
total_code2 = total_code2 + (verification_code1*2)
verification_code2 = get_verification_code(total_code2)

cpf.append(str(verification_code1))
cpf.append(str(verification_code2))

if len(sys.argv)>1 and sys.argv[1]=='-d' :
	pieces = [
		''.join(cpf[0:3]),
		''.join(cpf[3:6]),
		''.join(cpf[6:9]),
		''.join(cpf[9:]),
	]
	print pieces[0]+'.'+pieces[1]+'.'+pieces[2]+'-'+pieces[3]
else :
	print ''.join(cpf)
