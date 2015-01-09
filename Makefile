all:
	nim compile -d:release brainimfuck.nim
debug:
	nim compile brainimfuck.nim