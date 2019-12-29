NULL_HASH = 1 # hash(0)
NUM_LEAVES = 1000
TREE_DEPTH = 20

# a full binary tree has \sigma{0, DEPTH, 2^i} = DEPTH^2 / 2 nodes.  assume that the root node is at index 0 and the leaves occupy the last 2^DEPTH indices

class TreeNode:
  def __init__(self, left_child, right_child, value=None):
    if left_child == None and right_child == None:
        self.value = value
    else:
        if left_child == None:
            left_child = NULL_HASH
        elif right_child == None:
            right_child = NULL_HASH

        self.value = hash_left_right(left_child, right_child)

def serialize(tree):
  pass
  
def _merkleize_level(level, prev_level):
  pass

# return how many nodes to the left of a node in its row of the tree, idx is the index of the node in the overall tree
def calc_row_idx(idx):
  pass

# calculate the index of a node within the overall tree given its row index and the level of the tree it is at
def calc_tree_idx(row_idx, level):
  pass

def merkleize(indices, values):

  # lookup map for the hash at a given index (indexing in an array described above)
  tree = {}

  # iterate the tree depth 
  for i in range(1, TREE_DEPTH):
      for idx in current_level_indices:
        row_idx = calculate_row_idx(idx, level)# distance from left side of this row of the tree
        digest = None

        if row_idx % 2 == 0:
            if idx + 1 in tree:
              digest = hash_func(tree[idx], tree[idx + 1])
            else:
              digest = hash_func(tree[idx], NULL_HASH)
        else:
            if idx - 1 in tree:
              digest = hash_func(tree[idx - 1], tree[idx]) 
            else:
              digest = hash_func(NULL_HASH, tree[idx])

        root_idx = calc_root_idx(idx, level)
        tree[root_idx] = digest
  # the root should be tree[0]

def main():
  # generate a number of random indices

  # generate random values for each index

  # construct the tree object

  # serialize the tree
