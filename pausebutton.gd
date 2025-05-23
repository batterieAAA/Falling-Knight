extends Button

var paused = false
@onready var label = $"../Panel/Label"

func _ready():
	set_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Ensure mouse is visible in the paused state.

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		toggle_pause()

func toggle_pause():
	paused = not paused
	label.text = "Score:" + str(SkinManager.currentscore)
	get_tree().paused = paused
	$"../Panel".visible = !$"../Panel".visible 

func _on_pressed():
	toggle_pause()
