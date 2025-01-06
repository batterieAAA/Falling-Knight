extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var camera = $"../Camera2D" 
@onready var score_label = $"../CanvasLayer2/Label" 
@onready var knight = $"."


#sounds
@onready var hurtsound = $HurtSound
@onready var powerupsound = $PowerUpSound
@onready var pickupSound = $CoinSound

@onready var ui = get_node("../CanvasLayer2/HealthUI")  # Adjust this path to match your node structure
@onready var death_menu = $"../CanvasLayer2/DeathScene"  # Reference to the DeathMenu

const SPEED = 150
var speedMod = 1
var invincible = false  # Variable to track invincibility

enum {FALL, RUN, DEATH}

var state = FALL
var score = 0  # Initialize the score
var health = 3  # Initialize the health

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED * speedMod
		sprite.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Ensure the character stays within the viewport boundaries, considering the zoom factor
	var camera_position = camera.global_position
	var viewport_size = get_viewport().get_visible_rect().size
	var zoom_factor = camera.zoom

	var half_width = (viewport_size.x / 2) / zoom_factor.x
	var min_x = camera_position.x - half_width
	var max_x = camera_position.x + half_width

	# Wrap-around effect
	if position.x < min_x:
		position.x = max_x
	elif position.x > max_x:
		position.x = min_x

func take_damage():
	if not invincible:
		health -= 1
		hurtsound.playing = true
		ui.update_hearts(health)
		sprite.modulate = Color(1, 0, 0)  # Red color
		invincible = true  # Set invincibility to true
		
		# Start the DamageTimer
		$Timer.start()
		
		if health <= 0:
			die()

func die():
	# Handle player death logic here
	print("Player has died")
	# Display the death menu
	death_menu.visible = true
	
	# Connect button signals using Callable
	death_menu.get_node("RestartButton").connect("pressed", Callable(self, "_on_restart_button_pressed"))
	death_menu.get_node("QuitButton").connect("pressed", Callable(self, "_on_quit_button_pressed"))
	
	# Pause the game
	get_tree().paused = true

func _on_restart_button_pressed():
	# Restart the game
	print("restart")
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	# Quit the game
	print("quit")
	get_tree().quit()

func _on_coin_collected():
	score += 1
	pickupSound.playing = true
	score_label.text = str(score)

func _on_fruit_collected():
	powerupsound.playing = true
	sprite.speed_scale += 0.1
	speedMod += 0.1

func _on_enemy_touched():
	take_damage()  

func _on_timer_timeout():
	sprite.modulate = Color(1, 1, 1)  # Normal color
	invincible = false  # Revert invincibility to false
