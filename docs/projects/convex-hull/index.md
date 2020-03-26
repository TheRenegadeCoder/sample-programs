---
title: Convex Hull in Every Language
layout: default
date: 2018-11-01
last-modified: 2018-11-02
featured-image:
tags: [convex-hull]
authors:
---

Suppose you have a set of points in the plane. The **convex hull** of this set is the smallest
convex polygon that contains all the points.

A good way to visualize the problem is this: Imagine each point is a nail sticking out of the plane,
and you stretch a rubber band around them and let it go. The band will contract and assume a shape
that encloses the nails. This shape is the convex hull.

![Rubber band visualization][1]

Note that all vertices of the convex hull are points in the original set. So the convex hull is really
a subset of points from the original set, and there may be points that lie inside the polygon but are
not vertices of the convex hull.

## Requirements

Write a program that receives two command line arguments: strings in the form `x1, x2, x3 ...` and
`y1, y2, y3 ...` respectively, where `(xi, yi)` are the coordinates of the i-th point of the set.

Your program should be able to parse these lists into some internal representation in your choice
language (ideally an array). From there, the program should compute the convex hull of the set of points,
and output a list in the form

    (x1, y1)
    (x2, y2)
    ...

where `(xj, yj)` are the coordinates of the j-th vertex of the convex hull.

There are many algorithms to solve this problem. You may implement any of them.
Check this [great document by Jeff Erickson][2] for more details about the
problem and the different algorithms to solve it.

## Testing

Verify that the actual output matches the expected output. See the
[requirements][3] section for an example of the expected output.

## Articles

{% include article_list.md collection=site.categories.convex-hull %}

## Further Reading

- Fill as needed

[1]: https://upload.wikimedia.org/wikipedia/commons/d/de/ConvexHull.svg
[2]: http://jeffe.cs.illinois.edu/teaching/compgeom/notes/01-convexhull.pdf
[3]: #requirements
