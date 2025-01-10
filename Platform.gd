extends Area2D
@onready var animation_player = $AnimationPlayer


@onready var breakaudio = $AudioStreamPlayer


func nexttlevel():
	animation_player.play("platformbreak")
	breakaudio.play()



