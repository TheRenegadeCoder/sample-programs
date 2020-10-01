#!/usr/bin/env python
import sys

#.Function to create Permuterm Index for any given word.
def permuterm_in(word):

    permuterm_Index = []                           #array to store permuterm index
    word = word.lower()                            #make the word lower case

    stop_words = ['ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', 'about', 'once', 'during',
              'out', 'very', 'having', 'with', 'they', 'own', 'an', 'be', 'some', 'for', 'do', 'its', 'yours', 
              'such', 'into', 'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', 'who', 'as', 'from',
              'him', 'each', 'the', 'themselves', 'until', 'below', 'are', 'we', 'these', 'your', 'his', 'through',
              'don', 'nor', 'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', 'their', 'while', 
              'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', 'no', 'when', 'at', 'any', 'before', 'them', 'same', 
              'and', 'been', 'have', 'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', 'what', 'over', 
              'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', 'you', 'herself', 'has', 'just', 'where', 'too', 'only', 
              'myself', 'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', 'theirs', 'my', 'against', 'a', 'by', 
              'doing', 'it', 'how', 'further', 'was', 'here', 'than']

     

    
    for x in range(0, len(word)):
        if word in stop_words:                #check wheather user given word is a stop word or not
            print( '"' + word + '" is a stop word! \n Please try a anothor word')
            break
        if x == 0:                           #add the '$' sign to the end of the word in the first time loop runs
            temp = word + '$'
            permuterm_Index.append(temp) 
        temp = temp[1:] + temp[:1] 
        permuterm_Index.append(temp)         # add values to the permuterm_index array
    
    return permuterm_Index




def main(args):
    try:
        str1, str2 = input_list(args[0])
        print(anagram(str1, str2))
    except (IndexError,ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])
