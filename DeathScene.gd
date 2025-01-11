extends Control


var highscore = 0
@onready var scoreLabel = $Label/Score


func showScore(score: int):
	load_score()
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


