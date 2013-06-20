from numpy import *
import sys
f_name=sys.argv[1]
data=loadtxt(f_name,delimiter=' ',dtype='S')
savetxt(f_name.replace('.ped','_transp.ped'), data.transpose(), delimiter=' ',fmt="%s")
