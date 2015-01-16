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
  try:
    case cmd:
      of '+':
        vm.addMem()
      of '-':
        vm.subMem()
      of '<':
        vm.movePtr(-1)
      of '>':
        vm.movePtr(1)
      of '.':
        vm.printMem()
      else:
        break
  except SystemError:
    echo "Runtime error"
    break