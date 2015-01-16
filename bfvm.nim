type VM* = object
  mem* : seq[int]
  idx* : int

proc addMem*(vm: var VM): void = 
  vm.mem[vm.idx] += 1

proc subMem*(vm: var VM): void = 
  vm.mem[vm.idx] -= 1

proc movePtr*(vm: var VM, offset: int): int=
  if vm.idx + offset >= vm.mem.len():
    for i in countup(0, ((vm.idx + offset + 1) - vm.mem.len())):
      vm.mem.add(0)
  elif vm.idx + offset < 0:
    return -1 # Should raise error
  vm.idx += offset

proc printMem*(vm: var VM): void =
  echo char(vm.mem[vm.idx])