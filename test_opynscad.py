# from opynscad import OPynScadWriter, WrappedObj, UnionObj, DiffObj
from opynscad import OPynScadWriter, DiffObj, UnionObj
from hinges import *

scad = OPynScadWriter("test-opynscad.scad")
single_fin = HingeFin(HingeFinConfig(10, 30, 3, 2, 0.4))
single_fin_rotated = HingeFin(HingeFinConfig(10, 30, 3, 2, 0.4, spin=20))
single_fin_rotated.translate([0, 5, 0])
union = UnionObj([single_fin, single_fin_rotated])
# diff = DiffObj([single_fin, single_fin_rotated])
# scad.write(diff)
scad.write(union)
