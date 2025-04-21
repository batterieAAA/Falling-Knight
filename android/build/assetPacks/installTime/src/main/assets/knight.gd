extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var camera = $"../Camera2D" 
@onready var score_label = $"../CanvasLayer2/HBoxContainer/Label"
@onready var knight = $"."
@onready var healeffect = $HealEffect
@onready var pickeffect = $GPUParticles2D
@onready var animation_player = $AnimationPlayer
@onready var gamemanager = $"../GameManager"
@onready var game_animation_player = $"../AnimationPlayer"

@onready var godtimer = $GodTimer
@onready var damagetimer = $DamageTimer

@onready var ui = get_node("../CanvasLayer2/HealthUI")  # Adjust this path to match your node structure
@onready var death_menu = $"../CanvasLayer2/DeathScene"  # Reference to the DeathMenu

@onready var initial_position = position

const rainbowshader = preload("res://rainbow.tres")

const SPEED = 200
var speedMod = 1
var invincible = false  # Variable to track invincibility
var godinvincible = false
var can_interact = true

var hasgodray = false

var passreq = 0
var score = 0  # Initialize the score
var health = 3  # Initialize the health

var nbGreen = 0
var nbCoin = 0
var nbGod = 0
var nbHeal = 0



var moving_left = false
var moving_right = false

@onready var haveshield = SkinManager.boughtshield


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# Check if touch is on the left or right side of the screen
			if event.position.x < get_viewport().size.x / 4:
				moving_left = true
			else:
				moving_right = true
		else:
			# Stop movement when the touch is released
			moving_left = false
			moving_right = false




func _ready():
	# Connect button signals
	sprite.sprite_frames = SkinManager.currentskin
	sprite.play("fall")

func _physics_process(delta):
	if not can_interact:
		pass
		
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * speedMod
		sprite.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Movement logic for tap-and-hold
	if moving_left:
		velocity.x = -SPEED * speedMod
		sprite.flip_h = true
	elif moving_right:
		velocity.x = SPEED * speedMod
		sprite.flip_h = false
	else:
		# Gradual deceleration when neither side is pressed
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()
#
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

	if not invincible and not godinvincible and can_interact and not haveshield:
		health -= 1
		pickeffect.self_modulate = Color(1, 0, 0)
		pickeffect.emitting = true
		SoundManager.hurt.play()
		ui.update_hearts(health)
		sprite.modulate = Color(1, 0, 0)  # Red color
		invincible = true  # Set invincibility to true

		# Start the DamageTimer
		damagetimer.start()
		if health <= 0:
			die()
	if not invincible and not godinvincible and can_interact and haveshield:
		SoundManager.shield_hit_sound.play()
		pickeffect.self_modulate = Color(140, 140, 140)
		pickeffect.emitting = true
		SkinManager.boughtshield = false
		haveshield = false
		ui.update_shield()

func die():
	# Handle player death logic here
	playDeathAnimation()
	# Pause the game
	get_tree().paused = true
	
	await get_tree().create_timer(1).timeout
	# Display the death menu
	death_menu.visible = true
	score = nbCoin + nbGreen*5 + nbHeal*25 + nbGod*50
	death_menu.showScore(score, nbCoin, nbGreen, nbHeal, nbGod)

	# Connect button signals using Callable
	death_menu.get_node("RestartButton").connect("pressed", Callable(self, "_on_restart_button_pressed"))
	death_menu.get_node("QuitButton").connect("pressed", Callable(self, "_on_quit_button_pressed"))



func _on_restart_button_pressed():
	# Restart the game
	print("restart")

	game_animation_player.play("main_menu_outro")
	await get_tree().create_timer(1).timeout
	
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	# Quit the game
	print("quit")
	game_animation_player.play("main_menu_outro")
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_coin_collected():
	if not can_interact:
		pass
	nbCoin += 1
	score_label.text = str(nbCoin)
	SkinManager.currentscore = score

func _on_fruit_collected():
	if not can_interact:
		pass
	nbGreen += 1
	passreq += 1
	sprite.speed_scale += 0.1
	speedMod += 0.0125

	gamemanager.fruitcheck()
	

func _on_healfruit_collected():
	if not can_interact:
		pass
	healeffect.emitting = true
	nbHeal += 1
	passreq += 1
	if health < 3:
		health += 1
		ui.update_hearts(health)
	gamemanager.fruitcheck()

func _on_godfruit_collected():
	if not can_interact:
		pass
	pickeffect.self_modulate = Color(1, 1, 1)
	pickeffect.emitting = true
	godinvincible = true
	sprite.material = rainbowshader
	$godeffect.show()
	nbGod += 1
	passreq += 1
	gamemanager.fruitcheck()

	godtimer.start()
func _on_enemy_touched():
	take_damage()

func _on_timer_timeout():
	sprite.modulate = Color(1, 1, 1)  # Normal color
	invincible = false  # Revert invincibility to false

func _on_god_timer_timeout():
	godinvincible = false
	$godeffect.hide()
	sprite.material = null

func godray():
	$Aura.visible = true
func nogodray():
	$Aura.visible = false

func reset_new_floor():
	position = initial_position
	passreq = 0
	godray()


func playDeathAnimation():
	sprite.animation = "death"


