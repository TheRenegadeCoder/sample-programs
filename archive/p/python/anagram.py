from collections import Counter

"""
Conuter gives us a dict containing the letters and their counts
so we can use that information to find anagrams

"""
def check_anagram(str1, str2):

	return  Counter(str1) == Counter(str2)


if __name__ == '__main__':

	str1 = str(input())
	str2 = str(input())
	print(check_anagram(str1, str2))
