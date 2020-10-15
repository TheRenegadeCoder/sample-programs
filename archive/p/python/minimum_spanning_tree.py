import sys

USAGE = 'Usage: please provide a comma-separated list of integers'


def prims_algorithm(weights):
    num_verticies = len(weights)
    map_c, map_e = {ind: max([elem for row in weights for elem in row]) +
                    1 for ind in range(num_verticies)}, {ind: None for ind in range(num_verticies)}
    set_f, set_q = set(), set(range(num_verticies))
    while len(set_q) > 0:
        v = [i for i in set_q if map_c[i] == min(
            [map_c[item] for item in set_q])][0]
        set_q.remove(v)
        set_f.add(v)
        set_f.add(map_e[v]) if map_e[v] is not None else None
        for w in range(num_verticies):
            if v == w:
                continue
            if w in set_q and 0 < weights[w][v] <= map_c[w]:
                map_c[w] = weights[w][v]
                map_e[w] = v
    return sum([weights[v][w] for v, w in map_e.items() if v is not None and w is not None])


def _validate_arguments():
    arguments = sys.argv[1:]
    if len(arguments) != 1:
        log(USAGE)
        sys.exit()
    try:
        weights = [int(weight.strip()) for weight in arguments[0].split(',')]
    except Exception:
        log(USAGE)
        sys.exit()
    num_verticies = len(weights) ** 0.5
    if num_verticies != int(num_verticies):
        log(USAGE)
        sys.exit()
    num_verticies = int(num_verticies)
    weights = [[weights[num_verticies * row + col]
                for col in range(num_verticies)] for row in range(num_verticies)]
    for row in range(num_verticies):
        for col in range(row, num_verticies):
            if weights[row][col] != weights[col][row]:
                log('The matrix you provided doesn\'t represent an undirected graph.')
                sys.exit()
    return weights


def log(msg):
    sys.stdout.write('{}\n'.format(msg))


def main():
    weights = _validate_arguments()
    ret = prims_algorithm(weights)
    log(ret)


def test():
    _test_case_1()
    _test_case_2()
    _test_case_3()
    _test_case_4()
    _test_case_5()


def _test_case_1():
    log('Test case 1')
    sys.argv = sys.argv[:1]
    try:
        main()
    except SystemExit:
        pass


def _test_case_2():
    log('Test case 2')
    sys.argv = sys.argv[:1] + [""]
    try:
        main()
    except SystemExit:
        pass


def _test_case_3():
    log('Test case 3')
    sys.argv = sys.argv[:1] + ["1, 0, 3, 0, 5, 1"]
    try:
        main()
    except SystemExit:
        pass


def _test_case_4():
    log('Test case 4')
    sys.argv = sys.argv[:1] + \
        ["0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 0, 0"]
    try:
        main()
    except SystemExit:
        pass


def _test_case_5():
    log('Test case 5')
    sys.argv = sys.argv[:1] + \
        ["0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0"]
    try:
        main()
    except SystemExit:
        pass


if __name__ == '__main__':
    # test()
    main()
