import random

NULL_HASH = 1  # hash(0)
NUM_LEAVES = 1000
TREE_DEPTH = 2
LARGEST_INDEX = int( 2 ** (TREE_DEPTH + 1) ) - 2

# TODO parameterize these constants, check that NUM_LEAVES <= 2**TREE_DEPTH

# a full binary tree has \sigma{0, DEPTH, 2^i} = DEPTH^2 / 2 nodes.
# assume that the root node is at index 0 and the leaves occupy the last
# 2^DEPTH indices

row_starts = [0, 1] + [2**j + 1 for j in range(1, TREE_DEPTH)]

NULL_HASH = hash(0)

def mimc_compress2(left, right):
    return hash(str(left) + str(right)) # TODO

def get_tree_index(row_idx, lvl=TREE_DEPTH):
    return row_idx + row_starts[lvl]
    
def get_row_index(idx):
    if idx > LARGEST_INDEX:
        raise Exception("index too large for tree size")

    for index in range(len(row_starts)):
        if idx < row_starts[index]:
            if index > 0:
                return idx - row_starts[index - 1]
            else:
                return 0

    return idx - row_starts[-1]

def get_parent_idx(idx, level):
    row_idx = idx - row_starts[level]
    if row_idx % 2 == 0:
        # parent_idx = row_idx - level_width[level - 1]
        parent_idx = idx - (row_starts[level] - row_starts[level - 1])
    else:
        parent_idx = idx - (row_starts[level] - row_starts[level - 1] + 1)

    return parent_idx

def hash_level(idxs, lvl):
    idxs = [{'index': index, 'value': value} for index, value in idxs.items()]
    siblings = list(pair_siblings(idxs))
    result = {}

    for left, right in siblings:
        parent_idx = get_parent_idx(left['index'], lvl)
        parent_value = mimc_compress2(left['value'], right['value'])
        result[parent_idx] = parent_value

    return result

def make_node(index, value):
    return { 'index': index, 'value': value }

def pair_siblings(nodes):
    nodes = sorted(nodes, key = lambda x: x['index'])
    # return a list of pairs where x, y in nums, y - x == 1, x % 2 == 0, 
    i = 0
    while i < len(nodes):
        if get_row_index(nodes[i]['index']) % 2 == 0:
            if i+1 < len(nodes) and nodes[i+1]['index'] == nodes[i]['index'] + 1:
                yield(nodes[i], nodes[i + 1])
                i += 2
            else:
                yield (nodes[i], make_node(i + 1, NULL_HASH))
                i += 1
        else:
            yield (make_node(i - 1, NULL_HASH), nodes[i] )
            i += 1

def merkleize(indices, values):

    # lookup map for the hash at a given index (indexing in an array described
    # above)
    tree_levels = [{} for i in range(TREE_DEPTH + 1)]
    tree = {}

    if len(indices) == 0:
        return { 0: NULL_HASH }

    for i in range(len(indices)):
        tree_idx = i + int(2**TREE_DEPTH / 2) + 1 # add offset to start of bottom level
        tree_levels[TREE_DEPTH][tree_idx] = values[i]

    for lvl in reversed(range(0, TREE_DEPTH)):
        tree_levels[lvl] = hash_level(tree_levels[lvl + 1], lvl + 1)

    for lvl in tree_levels:
        for idx, value in lvl.items():
            tree[idx] = value

    return tree

def compute_proof(tree, row_index):
    proof = {
        'root': None,
        'leaf': None,
        'index': None,
        'witnesses': [],
    }

    index = get_tree_index(row_index)

    proof['root'] = tree[0]
    proof['leaf'] = tree[index]
    proof['index'] = index

    for lvl in reversed(range(TREE_DEPTH + 1)):
        index = get_parent_idx(index, lvl)

        if index % 2 == 0:
            if index + 1 in tree:
                proof['witnesses'].append(tree[index + 1])
            else:
                proof['witnesses'].append(NULL_HASH)
        else:
            if index - 1 in tree:
                proof['witnesses'].append(tree[index - 1])
            else:
                proof['witnesses'].append(NULL_HASH)

    return proof


def verify_proof(proof):
    selector = proof['index']
    computed_root = None

    if selector % 2 == 0:
        computed_root = mimc_compress2(proof['leaf'], proof['witnesses'][0])
    else:
        computed_root = mimc_compress2(proof['witnesses'][0], proof['leaf'])

    selector /= 2

    for witness in range(1, len(proof['witnesses'])):
        if selector % 2 == 0:
            computed_root = mimc_compress2(computed_root, witness)
        else:
            computed_root = mimc_compress2(witness, computed_root)

    if computed_root != proof['root']:
        raise Exception("{} (computed) != {}".format(computed_root, proof['root']))
