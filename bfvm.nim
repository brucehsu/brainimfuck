type VM* = object
  mem* : seq[int]
  idx* : int

proc addMem*(vm: var VM): void = 
  vm.mem[vm.idx] += 1

proc subMem*(vm: var VM): void = 
  vm.mem[vm.idx] -= 1

proc movePtr*(vm: var VM, offset: int): void=
  if vm.idx + offset >= vm.mem.len():
    for i in countup(0, ((vm.idx + offset + 1) - vm.mem.len())):
      vm.mem.add(0)
  elif vm.idx + offset < 0:
    raise newException(SystemError, "Invalid pointer access")
  vm.idx += offset

proc printMem*(vm: var VM): void =
  stdout.write(char(vm.mem[vm.idx]))

proc execute*(vm: var VM, insts: string): int =
  for i, cmd in insts:
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
        of '[':
          var pair : int
          while vm.mem[vm.idx] != 0:
            pair = vm.execute(insts[(i+1)..(-1)])
          return vm.execute(insts[(i+pair+2)..(-1)])
        of ']':
          return i
        else:
          continue
    except SystemError:
      echo "Runtime error"
      break