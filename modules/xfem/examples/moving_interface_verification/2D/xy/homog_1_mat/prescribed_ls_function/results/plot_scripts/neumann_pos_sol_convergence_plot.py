import numpy as np
import matplotlib.pyplot as plt

### Data Extraction
conv_data = np.genfromtxt('../Neumann_pos_sols/neumann_pos_sols.csv',delimiter=',')
conv_data[:,1] -= 800.

### Plot data
savdir = '../../doc/figures/'
plt.figure()
conv_plt, = plt.loglog(conv_data[:,0],conv_data[:,1],label='1D, xy, homogeneous'\
        + ' 1 material convergence')
plt.xlabel('Number of elements in x')
plt.ylabel('Difference between XFEM and real sol. at x=0')
plt.savefig(savdir+'1D_xy_homog1mat_neumann_comp.png')
