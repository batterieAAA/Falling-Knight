extends Node

var greenfruit: int

var level1req: bool = false
var level2req: bool = false
var level3req: bool = false
var level4req: bool = false
var level5req: bool = false




func reset():
	greenfruit = 0
	level1req = false
	level2req = false
	level3req = false
	level4req = false
	level5req = false

func level1check():
	if greenfruit >= 5:
		print("you got it bro")
		level1req = true
		
func level2check():
	if greenfruit >= 7:
		level2req = true
		
func level3check():
	if greenfruit >= 9:
		level3req = true
		
func level4check():
	if greenfruit >= 11:
		level4req = true
		
func level5check():
	if greenfruit >= 15:
		level5req = true


