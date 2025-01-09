extends Node


var godfruit : int
var greenfruit : int
var healfruit : int
var holypieces : int

var level1req : bool = false
var level2req : bool = false
var level3req : bool = false
var level4req : bool = false
var level5req : bool = false

func level1check():
	if holypieces <= 1:
		level1req = true
func level2check():
	if holypieces <= 2:
		level2req = true
func level3check():
	if holypieces <= 3:
		level3req = true
func level4check():
	if holypieces <= 4:
		level4req = true
func level5check():
	if holypieces <= 5:
		level5req = true
