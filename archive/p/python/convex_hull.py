from math import sqrt
import sys


X = [int(i.strip()) for i in sys.argv[1].split(',') if i]
Y = [int(i.strip()) for i in sys.argv[2].split(',') if i]

assert len(X) == len(Y), 'Wrong Input'

Z = list(set((zip(X, Y))))
X = [i for i, _ in Z]
Y = [j for _, j in Z]


def dist(point1, point2):
    x1, y1 = point1
    x2, y2 = point2
    return sqrt(abs((x2 - x1)**2 + (y2 - y1)**2))


def farthest(point, set_of_points):
    d = [(dist(point, i), i) for i in set_of_points]
    d = list(set(d))
    d = sorted(d, reverse=True)
    return d[0][1]


def orient(point1, point2, point3):
    x1, y1 = point1
    x2, y2 = point2
    x3, y3 = point3
    val = ((x2-x1) * (y3-y1)) - ((y2 - y1) * (x3-x1))
    if val == 0:
        return 0
    elif val > 0:
        return 1
    else:
        return 2


def next_hurdle(setofpoints, pivot, final_list):
    z = setofpoints
    final_list = final_list[1:]
    k = []
    for i in z:
        if i in final_list:
            continue
        bool1 = 1
        for j in z:
            if orient(pivot, i, j) == 1:
                bool1 = 0
                break
        if bool1 == 1:
            k.append(i)
    return farthest(pivot, k)


def foo(z):
    final_list = []
    topmost = [(i, j) for i, j in z if j == max(Y)]
    v1 = sorted(topmost)[0]
    final_list.append(v1)
    next_point = v1[0], v1[1] + 1
    pivot = v1
    while next_point != v1:
        next_point = next_hurdle(z, pivot, final_list)
        pivot = next_point
        final_list.append(next_point)
    return final_list


if __name__ == '__main__':
    convex_polygon_coords = foo(Z)
    print(convex_polygon_coords)
