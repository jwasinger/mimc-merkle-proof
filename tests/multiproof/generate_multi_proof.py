import random

NULL_HASH = 1  # hash(0)
NUM_LEAVES = 1000
TREE_DEPTH = 20

# TODO parameterize these constants, check that NUM_LEAVES <= 2**TREE_DEPTH

# a full binary tree has \sigma{0, DEPTH, 2^i} = DEPTH^2 / 2 nodes.
# assume that the root node is at index 0 and the leaves occupy the last
# 2^DEPTH indices


class TreeNode:
    def __init__(self, left_child, right_child, value=None):
        if left_child is None and right_child is None:
            self.value = value
        else:
            if left_child is None:
                left_child = NULL_HASH
            elif right_child is None:
                right_child = NULL_HASH

            self.value = hash_left_right(left_child, right_child)


def serialize(tree):
    pass


def _merkleize_level(level, prev_level):
    pass

# return how many nodes to the left of a node in its row of the tree, idx
# is the index of the node in the overall tree
def calc_row_idx(idx):
    row_starts = [2**j for j in range(0, TREE_DEPTH)]
    for i in range(len(row_starts)):
        if idx <= row_starts[i]:
            return row_starts[i] - idx

# calculate the index of a node within the overall tree given its row
# index and the level of the tree it is at
def calc_tree_idx(row_idx, level):
    return row_idx + (2**level - 1)


def merkleize(indices, values):

    # lookup map for the hash at a given index (indexing in an array described
    # above)
    tree = {}
    current_level_indices = {}

    for i in range(len(indices)):
        current_level_indices[indices[i]] = values[i]
        tree[indices[i]] = values[i]

    #TODO fix and test this algorithm
    for i in range(1, TREE_DEPTH):

        new_level_indices = {}

        for idx in current_level_indices:
            # distance from left side of this row of the tree
            row_idx = calculate_row_idx(idx, level)
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

            new_level_indices[root_idx] = digest

        current_level_indices = new_level_indices

    return tree


def main():
    # generate a number of random indices

    indices = []
    values = []

    for i in range(NUM_LEAVES):
        indices.append(random.randint(0, 2**TREE_DEPTH - 1))
        values.append(100)  # TODO make this random

    # construct the tree object
    tree = merkleize(indices, values)
    print(tree[0])

    # serialize the tree

if __name__ == "__main__":
    main()
