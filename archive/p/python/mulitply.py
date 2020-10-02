import sys

def multiply_new(x, y):

    answer = 0
    for i in range(y):
        answer += x
    return answer


if __name__ == "__main__":

    number_1 = int(sys.argv[1])
    number_2 = int(sys.argv[2])
    ans = multiply_new(number_1, number_2)
    print(f"{number_1} x {number_2} = {ans}")
