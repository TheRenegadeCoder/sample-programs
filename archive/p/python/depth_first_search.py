import sys


def get_input(argv):
    error_message = 'Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")'

    # check input
    if len(argv) != 3:
        print(error_message)
        sys.exit(1)
    tree, vertex_values, target = argv
    if not tree or not vertex_values or not target:
        print(error_message)
        sys.exit(1)

    # convert strings to lists
    tree = list(map(int, tree.split(', ')))
    vertex_values = list(map(int, vertex_values.split(', ')))
    tree = [tree[i: i + len(vertex_values)] for i in range(0, len(tree), len(vertex_values))]
    target = int(target)

    return tree, vertex_values, target

class TreeNode:
    def __init__(self, val):
        self.val = val
        self.connected = []

def create_tree(tree, vertex_values):
    nodes = {value: TreeNode(value) for value in vertex_values}
    for i, row in enumerate(tree):
        node = nodes[vertex_values[i]]
        for j, is_connected in enumerate(row):
            if j <= i:
                continue
            if is_connected:
                node.connected.append(nodes[vertex_values[j]])
    head = nodes[vertex_values[0]]
    return head

def depth_first_search(node, target):
    if node.val == target:
        return True
    for connected_node in node.connected:
        if depth_first_search(connected_node, target):
            return True
    return False

def main():
    tree, vertex_values, target = get_input(sys.argv[1:])
    tree_head = create_tree(tree, vertex_values)
    if depth_first_search(tree_head, target):
        print('true')
    else:
        print('false')

if __name__ == '__main__':
    main()
