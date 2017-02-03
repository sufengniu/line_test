

import networkx as nx
import numpy as np

import sys
from scipy.io import loadmat


matfile = "blogcatalog.mat"

mat = loadmat(matfile)
A = mat['network']
G = nx.from_scipy_sparse_matrix(A)

nx.write_edgelist(G, "blogcatalog.edgelist", delimiter='\t', data=False)
#nx.write_weighted_edgelist(G, "blogcatalog.edgelist")
