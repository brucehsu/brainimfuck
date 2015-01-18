import bfast

type 
  VM* = ref VMObj
  VMObj = object
    mem* : seq[int]
    idx* : int

proc addMem*(vm: var VM, val: int): void = 
  vm.mem[vm.idx] += val

proc movePtr*(vm: var VM, offset: int): void=
  if vm.idx + offset >= vm.mem.len():
    for i in countup(0, ((vm.idx + offset + 1) - vm.mem.len())):
      vm.mem.add(0)
  elif vm.idx + offset < 0:
    raise newException(SystemError, "Invalid pointer access")
  vm.idx += offset

proc printMem*(vm: var VM): void =
  stdout.write(char(vm.mem[vm.idx]))

proc execute*(vm: var VM, root: AST): void =
  var node = root
  while node != nil:
    case node.node_type:
      of NODE_ROOT:
        discard      
      of NODE_MOV:
        vm.movePtr(node.node_val)
      of NODE_ADD:
        vm.addMem(node.node_val)
      of NODE_PRINT:
        vm.printMem()
      of NODE_LOOP:
        while vm.mem[vm.idx]!=0:
          vm.execute(node.child)
      else:
        raise newException(SystemError, "Unexpected instructions")
    node = node.next