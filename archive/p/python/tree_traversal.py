# A class that represents an individual node in a binary tree with the method to set left and right nodes
class Node(object):
    def __init__(self, value= None):
        self.data = value
        self.left = None
        self.right = None 
    # to set left child    
    def set_left(self, node):
        self.left = node 
    # to set right child    
    def set_right(self, node):
        self.right = node

# recursive preorder traversal
#Root -> Left ->Right
def preOrder(node):
    if(node):
        print(node.data, end=" ")
        preOrder(node.left)
        preOrder(node.right)

# recursive inorder traversal
# Left -> Root -> Right
def inOrder(node):
    if(node):
        inOrder(node.left)
        print(node.data, end=" ")
        inOrder(node.right)

# recursive postorder traversal
# Left ->Right -> Root
def postOrder(node):
    if(node):
        postOrder(node.left)
        postOrder(node.right)
        print(node.data, end=" ")
        

def main(): 
#               1 
#             /   \
#            2     3
#          /  \   / \
#         4    5 6   7
#----------------------------------------
    root = Node(1)
    node2 = Node(2)
    node3 = Node(3)
    root.set_left(node2)
    root.set_right(node3)
    node4 = Node(4)
    node5 = Node(5)
    node2.set_left(node4)
    node2.set_right(node5)
    node6 = Node(6)
    node7 = Node(7)
    node3.set_left(node6)
    node3.set_right(node7)
#----------------------------------------    
    preOrder(root)
    print('\n')
    inOrder(root)
    print('\n')
    postOrder(root)
    
main()    
        

