#!/usr/bin/env python
from __future__ import print_function
import sys
from collections import OrderedDict

class Piece:
	actionTypes = {'m':"move", 
				   '*':"strike", 
				   's':"slide",
				   'j':"jump",
				   'J':"jumpslide",
				   '_':"command",
				   'M':"move+command"
				   }
	def __init__(self, name, symbol):
		self.name = name
		self.symbol = symbol
		self.side = {1:{}, 2:{}}
	def setAction(self, side, actionSymbol, x, y):
		if actionSymbol not in Piece.actionTypes.keys():
			return
		actType = Piece.actionTypes[actionSymbol]
		if actType == "move+command":
			commands = self.side[side].setdefault("command",[])
			commands.append((x,y))
			moves = self.side[side].setdefault("move",[])
			moves.append((x,y))
		else:
			actions = self.side[side].setdefault(actType,[])
			actions.append((x,y))

	def __str__(self):
		string = self.name
		string += " " + self.symbol + "\n"
		string += str(self.side[1]) + "\n"
		string += str(self.side[2]) + "\n"
		return string

if __name__ == '__main__':
	pieces = OrderedDict()

	defFile = open(sys.argv[1],"r")

	line = defFile.readline()
	currentPiece = None
	currentSide = 1
	while line:
		# print(line)
		if line.startswith("::"):
			name, symbol = line[2:].split()
			pieces[name] = Piece(name, symbol)
			currentPiece = pieces[name]
			currentSide = 1
		elif line.strip():
			for y in [-2,-1,0,1,2]:
				# print(line)
				for x in [-2,-1,0,1,2]:
					# print(x+2)
					currentPiece.setAction(currentSide, line[x+2], x, y)
				line = defFile.readline().strip()
			currentSide = 2
		line = defFile.readline()
	defFile.close()

	out  = "angular.module('prince')\n\n"
	out += ".factory 'PieceDefinitions', ->\n\n"
	out += "  TYPES = \n"

	for k,p in pieces.iteritems():
		out += "    %s:'%s'\n" %(k,k)

	out += """  ACTIONS = 
    move: 'move'
    slide: 'slide'
    jump: 'jump'
    jumpslide: 'jumpslide'
    strike: 'strike'
    command: 'command'\n\n"""

	out += "  definitions =\n"
	out += "    TYPES: TYPES\n"
	out += "    ACTIONS: ACTIONS\n"
	for k,p in pieces.iteritems():
		out += "    %s:\n" %(k)
		out += "      type: TYPES.%s\n" %(k)
		out += "      actions: [\n"
		for i in [1,2]:
			if i==2: out += "%6s,\n" % ' '
			for a,sets in p.side[i].iteritems():
				out+= "%8s%s: [\n" % (' ', a)
				for xy in sets:
					out += "%10s[%i,%i]\n" % (' ',xy[0],xy[1])
				out += "%8s]\n" % ' '
		out += "%6s]\n\n" % ' '

	out += "  definitions\n"

	print(out)
	print("\n")
	for k,p in pieces.iteritems():
		sass  = "  &.%s:before\n" % p.name
		sass += '    content: "%s"' % p.symbol
		print(sass)

	x = 0
	y = 0
	print("\n")
	for k,p in pieces.iteritems():
		play  = "gameBoard.pieces.push new Piece\n"
		play += "  type: PieceDefinitions.TYPES.%s\n" % p.name
		play += "  x:%i\n" % x
		play += "  y:%i\n" % y
		print(play)
		if x == 5:
			y = (y+1)%6
		x = (x+1)%6

