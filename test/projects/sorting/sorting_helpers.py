from test.utilities import clean_list

sorting_invalid_permutations = (
    'description,in_params,expected', [
        (
            'no input',
            None,
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'empty input',
            '""',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'invalid input: not a list',
            '"1"',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        ), (
            'invalid input: wrong format',
            '"4 5 3"',
            'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
        )
    ]
)

sorting_valid_permutations = (
    'description,in_params,expected', [
        (
            'sample input',
            '"4, 5, 3, 1, 2"',
            '1, 2, 3, 4, 5'
        ), (
            'sample input: with duplicate',
            '"4, 5, 3, 1, 4, 2"',
            '1, 2, 3, 4, 4, 5'
        ), (
            'sample input: already sorted',
            '"1, 2, 3, 4, 5"',
            '1, 2, 3, 4, 5'
        ), (
            'sample input: reverse sorted',
            '"9, 8, 7, 6, 5, 4, 3, 2, 1"',
            '1, 2, 3, 4, 5, 6, 7, 8, 9'
        )
    ]
)


def get_valid_permutations_parametrization():
    return {
        'argnames': sorting_valid_permutations[0],
        'argvalues': sorting_valid_permutations[1],
        'ids': [p[0] for p in sorting_valid_permutations[1]],
    }


def get_invalid_permutations_parametrization():
    return {
        'argnames': sorting_invalid_permutations[0],
        'argvalues': sorting_invalid_permutations[1],
        'ids': [p[0] for p in sorting_invalid_permutations[1]],
    }


def base_test_sort_valid(description, in_params, expected, sort_source):
    actual = sort_source.run(params=in_params)
    assert clean_list(actual) == expected


def base_test_sort_invalid(description, in_params, expected, sort_source):
    actual = sort_source.run(params=in_params)
    assert actual.strip() == expected
