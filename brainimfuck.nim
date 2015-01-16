type VM* = object
  mem : seq[int]
  idx : int

proc addMem(vm: var VM): void = 
  vm.mem[vm.idx] += 1
proc subMem(vm: var VM): void = 
  vm.mem[vm.idx] -= 1
proc movePtr(vm: var VM, offset: int): int=
  if vm.idx + offset >= vm.mem.len():
    for i in countup(0, ((vm.idx + offset + 1) - vm.mem.len())):
      vm.mem.add(0)
  elif vm.idx + offset < 0:
    return -1 # Should raise error
  vm.idx += offset
proc printMem(vm: var VM): void =
  echo char(vm.mem[vm.idx])

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