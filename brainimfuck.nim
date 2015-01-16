import bfvm
var
  insts : string = ""
  vm = VM(mem: newSeq[int](1))

while true:
  try:
    let inst = readLine(stdin)
    insts.add(inst)
  except IOError:
    break

discard vm.execute(insts)