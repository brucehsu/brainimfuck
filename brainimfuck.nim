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

echo insts

for cmd in insts:
  case cmd:
    of '+':
      vm.addMem()
    of '-':
      vm.subMem()
    of '<':
      if vm.movePtr(-1) == -1:
        echo "Runtime error"
        break
    of '>':
      if vm.movePtr(1) == -1:
        echo "Runtime error"
        break
    of '.':
      vm.printMem()
    else:
      echo "Syntax error"
      break