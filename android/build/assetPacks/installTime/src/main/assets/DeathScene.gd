extends Control


var highscore = 0
@onready var scoreLabel = $Label/Score


@onready var coinpt = $Panel/Coinpt
@onready var greenpt_2 = $Panel/Greenpt2
@onready var healpt_3 = $Panel/Healpt3
@onready var godpt_4 = $Panel/Godpt4
@onready var totalpt = $Panel/Totalpt





func showScore(score: int, nbCoin: int, nbGreen: int, nbHeal: int, nbGod: int):
	load_score()
	coinpt.text = str(nbCoin)
	greenpt_2.text = str(nbGreen)
	healpt_3.text = str(nbHeal)
	godpt_4.text = str(nbGod)
	totalpt.text = str(score)
	SkinManager.spendablegold += nbCoin
	SkinManager.save_game()
	
	if score > highscore:
		scoreLabel.text = str(score)
		save_score(score)
	
func save_score(score: int):
	var config = ConfigFile.new()
	config.set_value("score", "score", score)
	config.save("user://score.cfg")

func load_score():
	var config = ConfigFile.new()
	if config.load("user://score.cfg") == OK:
		highscore = config.get_value("score", "score", "score")
		scoreLabel.text = str(highscore)

