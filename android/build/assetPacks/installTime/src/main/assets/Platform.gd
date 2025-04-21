extends Area2D
@onready var animation_player = $AnimationPlayer



func nexttlevel():
	animation_player.play("platformbreak")


