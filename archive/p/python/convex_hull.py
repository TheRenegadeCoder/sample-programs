X = [int(i.strip()) for i in input().rstrip().split(',')]
Y = [int(i.strip()) for i in input().rstrip().split(',')]

Z = list(set((zip(X, Y))))
X = [i for i, j in Z]
Y = [j for i, j in Z]


from math import sqrt


def dist(point1, point2):
    """
    Returns the distance between 2d points: point1 and point2
    """
    x1, y1 = point1
    x2, y2 = point2
    return sqrt(abs((x2 - x1)**2 + (y2 - y1)**2))
    
def farthest(point, setofpoints):
    """
    setofpoints are all colinear, along with 'point'
    This function returns the farthest point from setofpoints wrt 'point'.
    """
    d = [(dist(point, i),i) for i in setofpoints]
    d = list(set(d))
    d = sorted(d, reverse = True)
    return d[0][1]

def orient(point1, point2, point3):
    #point3 is the target point.
    # if point2 is counterclockwise for point3, wrt point1; then we send 2, similarly for other cases.
    """
    0 --> points are colinear  
    1 --> Clockwise  
    2 --> Counterclockwise
    ------------------------------------------
    
    a x b = a.b.sin(theta) n
    a x b = | i    j    k |
            | a1   a2   a3|
            | b1   b2   b3|
    When k component is missing then:
    
    a x b = k|a1   a2|
             |b1   b2|
    
    Also a x b is positive only when they are clockwise, relative to coord axes; i.e. b is future path of a.
    
    Thus vector product holds the key for rotation.
    
    | x2-x1  x3-x1 |
    | y2-y1  y3-y1 |
    So, we shift the origin on x1, y1 and then we compute this determinant for sign takings.
    
    Thus this determinant's sign will tell about the sign of normal vector.
    Also, in cross product, when angle is 0, sintheta is 0 thus result is zero.
    """
    x1, y1 = point1
    x2, y2 = point2
    x3, y3 = point3
    val = ( (x2-x1) * (y3-y1) ) - ( (y2 - y1) * (x3-x1) )
    if val == 0: 
        return 0
    elif val > 0: 
        return 1
    else: 
        return 2

def next_hurdle(setofpoints, pivot, finallist):
    z = setofpoints
    finallist = finallist[1:]
    k = []
    for i in z:
        if i in finallist: continue
        bool1 = 1
        for j in z:
            if orient(pivot, i,j) == 1:
                bool1 = 0
                break
        if bool1 == 1:
            k.append(i)
    return farthest(pivot, k)

def foo(z):
    finallist  = []
    topmost = [(i,j) for i, j in z if j == max(Y)]
    v1 = sorted(topmost)[0]
    finallist.append(v1)
    next_point = v1[0], v1[0]+1 # just a non v1 point choosed
    pivot = v1
    while next_point!= v1:
        next_point = next_hurdle(z, pivot, finallist)
        pivot = next_point
        finallist.append(next_point)
    return finallist

convex_polygon_coords = foo(Z)
print(convex_polygon_coords)

""" unwrap below lines for getting a plot """

"""
import matplotlib.pyplot as plt
from matplotlib import style
style.use('dark_background')
plt.scatter(X,Y)
k1 = convex_polygon_coords
plt.plot([i for i, j in k1], [j for i, j in k1], '--y')
plt.grid('True')
for i in Z:
    plt.text(*i, '{}'.format(i))
plt.xlabel('{}'.format(k1))
#plt.savefig('sample.svg')  #enable this comment for saving an image of plot
plt.show()
"""

