extends Panel


@onready var previous_button = $PreviousButton
@onready var next_button = $NextButton

@onready var tuto_1 = $Tuto1
@onready var tuto_2 = $Tuto2
@onready var tuto_3 = $Tuto3



func _on_next_button_pressed():
	SoundManager.chick_sound.play()
	if tuto_1.visible == true:
		tuto_1.visible = false
		tuto_2.visible = true
		previous_button.disabled = false
	elif tuto_2.visible == true:
		tuto_2.visible = false
		tuto_3.visible = true
		next_button.disabled = true


func _on_previous_button_pressed():
	SoundManager.chick_sound.play()
	if tuto_2.visible == true:
		tuto_2.visible = false
		tuto_1.visible = true
		previous_button.disabled = true
	if tuto_3.visible == true:
		tuto_3.visible = false
		tuto_2.visible = true
		next_button.disabled = false
