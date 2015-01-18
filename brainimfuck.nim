import bfvm
import bfast
var
  insts : string = ""
  vm : VM
new(vm)
vm.mem.newSeq(1)
vm.idx = 0

while true:
  try:
    let inst = readLine(stdin)
    insts.add(inst)
  except IOError:
    break

var root = compile(insts)
root.optimize()
vm.execute(root)