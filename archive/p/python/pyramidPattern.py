"""
    Author : Nameer Waqas
    Date   : 02/10/2020
    Title  : Pyramid Pattern algorithm.
"""

def printPyramid(limit):
    whiteSpace = limit
    for i in range(1,limit+1):
        for j in range(whiteSpace):
            print(" ",end="")
        whiteSpace-=1
        for k in range(i):
            print("* ",end="")
        print("",end="\n")

# Function call
printPyramid(15)

#                * 
#               * * 
#              * * * 
#             * * * * 
#            * * * * * 
#           * * * * * * 
#          * * * * * * * 
#         * * * * * * * * 
#        * * * * * * * * * 
#       * * * * * * * * * * 
#      * * * * * * * * * * * 
#     * * * * * * * * * * * * 
#    * * * * * * * * * * * * * 
#   * * * * * * * * * * * * * * 
#  * * * * * * * * * * * * * * *
