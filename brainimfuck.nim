import bfvm
var
  insts : string
  vm = VM(mem: newSeq[int](1))

block root:
  while true:
    try:
      insts = readLine(stdin)
    except IOError:
      break

    for cmd in insts:
      case cmd:
        of '+':
          vm.addMem()
        of '-':
          vm.subMem()
        of '<':
          if vm.movePtr(-1) == -1:
            echo "Runtime error"
            break root
        of '>':
          if vm.movePtr(1) == -1:
            echo "Runtime error"
            break root
        of '.':
          vm.printMem()
        else:
          echo "Syntax error"
          break root