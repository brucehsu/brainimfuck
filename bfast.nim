type 
  NodeType* = enum
    NODE_ROOT, NODE_MOV, NODE_ADD, NODE_PRINT, NODE_LOOP
  AST* = ref ASTObj
  ASTObj = object
    node_type* : NodeType
    node_val* : int
    next* : AST
    child* : AST

proc newNode(node_type: NodeType, val: int): AST=
  new(result)
  result.node_type = node_type
  result.node_val = val
  return result

proc appendNode(a, b: AST): AST=
  a.next = b
  return b

proc compile*(insts : string): AST= 
  new(result)
  result.node_type = NODE_ROOT
  var 
    node = result
    backtrack : seq[AST]
  backtrack.newSeq(0)
  for i, cmd in insts:
    try:
      case cmd:
        of '+':
          if node.node_type == NODE_ADD:
            node.node_val.inc()
          else:
            node = node.appendNode(newNode(NODE_ADD, 1))
        of '-':
          if node.node_type == NODE_ADD:
            node.node_val.dec()
          else:
            node = node.appendNode(newNode(NODE_ADD, -1))
        of '<':
          if node.node_type == NODE_MOV:
            node.node_val.dec()
          else:
            node = node.appendNode(newNode(NODE_MOV, -1))
        of '>':
          if node.node_type == NODE_MOV:
              node.node_val.inc()
          else:
            node = node.appendNode(newNode(NODE_MOV, 1))
        of '.':
          node = node.appendNode(newNode(NODE_PRINT, 0))
        of '[':
          node = node.appendNode(newNode(NODE_LOOP, 0))
          backtrack.add(node)
          node.child = newNode(NODE_ROOT, 0)
          node = node.child
        of ']':
          node = backtrack[backtrack.len() - 1]
          backtrack.setLen(backtrack.len() -1)
        else:
          continue
    except SystemError:
      echo "Runtime error"
      break