extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var camera = $"../Camera2D" 
@onready var score_label = $"../CanvasLayer2/Label" 
@onready var knight = $"."
@onready var healeffect = $HealEffect
@onready var pickeffect = $GPUParticles2D

@onready var godtimer = $GodTimer
@onready var damagetimer = $DamageTimer

# sounds
@onready var hurtsound = $HurtSound
@onready var powerupsound = $PowerUpSound
@onready var pickupSound = $CoinSound

@onready var ui = get_node("../CanvasLayer2/HealthUI")  # Adjust this path to match your node structure
@onready var death_menu = $"../CanvasLayer2/DeathScene"  # Reference to the DeathMenu

@onready var initial_position = position

const SPEED = 150
var speedMod = 1
var invincible = false  # Variable to track invincibility
var godinvincible = false
var can_interact = true

var hasgodray = false

var nbFruit = 0
var score = 0  # Initialize the score
var health = 3  # Initialize the health
@onready var left_button = $"../LeftButton"
@onready var right_button = $"../RightButton"

var left_is_pressed = false
var right_is_pressed = false

func _ready():
	# Connect button signals
	left_button.connect("button_down", Callable(self, "_on_left_button_pressed"))
	left_button.connect("button_up", Callable(self, "_on_left_button_released"))
	right_button.connect("button_down", Callable(self, "_on_right_button_pressed"))
	right_button.connect("button_up", Callable(self, "_on_right_button_released"))

func _on_left_button_pressed():
	left_is_pressed = true

func _on_left_button_released():
	left_is_pressed = false

func _on_right_button_pressed():
	right_is_pressed = true

func _on_right_button_released():
	right_is_pressed = false

func _physics_process(delta):
	if not can_interact:
		pass
		
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction == 0:
		if left_is_pressed:
			direction = -1
		elif right_is_pressed:
			direction = 1

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
	if not invincible and not godinvincible and can_interact:
		health -= 1
		pickeffect.self_modulate = Color(1, 0, 0)
		pickeffect.emitting = true
		hurtsound.playing = true
		ui.update_hearts(health)
		sprite.modulate = Color(1, 0, 0)  # Red color
		invincible = true  # Set invincibility to true

		# Start the DamageTimer
		damagetimer.start()

		if health <= 0:
			die()

func die():
	# Handle player death logic here
	print("Player has died")
	# Display the death menu
	death_menu.visible = true
	death_menu.showScore(score)

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
	if not can_interact:
		pass
	score += 1
	pickupSound.playing = true
	pickeffect.self_modulate = Color(1, 1, 0)
	pickeffect.emitting = true
	score_label.text = str(score)

func _on_fruit_collected():
	if not can_interact:
		pass
	powerupsound.playing = true
	pickeffect.self_modulate = Color(0, 0, 1)
	pickeffect.emitting = true
	sprite.speed_scale += 0.1
	speedMod += 0.1
	nbFruit += 1

func _on_healfruit_collected():
	if not can_interact:
		pass
	powerupsound.playing = true
	pickeffect.self_modulate = Color(0, 1, 0)
	healeffect.emitting = true
	pickeffect.emitting = true
	if health < 3:
		health += 1
		ui.update_hearts(health)

func _on_godfruit_collected():
	if not can_interact:
		pass
	powerupsound.playing = true
	pickeffect.self_modulate = Color(1, 1, 1)
	pickeffect.emitting = true
	godinvincible = true
	$Aura.visible = true
	godtimer.start()

func _on_enemy_touched():
	take_damage()

func _on_timer_timeout():
	sprite.modulate = Color(1, 1, 1)  # Normal color
	invincible = false  # Revert invincibility to false

func _on_god_timer_timeout():
	godinvincible = false
	$Aura.visible = false

func godray():
	$ColorRect.visible = true

func nogodray():
	$ColorRect.visible = false

func reset_new_floor():
	position = initial_position
	nbFruit = 0
