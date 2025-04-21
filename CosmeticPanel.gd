extends Panel

@onready var horse_knight_skin = $HorseKnightSkin
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var gold_knight_skin = $GoldKnightSkin




func _on_cosmetic_button_pressed():
	$"../Panel".hide()
	$"../ShopPanel".hide()
	$"../TutorialPanel".hide()
	$"../TrophyPanel".hide()
	
	if SkinManager.trophies["trophy10"] == true:
		horse_knight_skin.disabled = false
	if SkinManager.boughtgoldarmor == true:
		gold_knight_skin.disabled = false
	visible = !visible




func _on_horse_knight_skin_pressed():
	animated_sprite_2d.sprite_frames = SkinManager.horseknight
	SkinManager.sethorseskin()

func _on_gold_knight_skin_pressed():
	animated_sprite_2d.sprite_frames = SkinManager.goldknight
	SkinManager.setgoldskin()


func _on_helmless_knight_skin_pressed():
	animated_sprite_2d.sprite_frames = SkinManager.helmlessskin
	SkinManager.sethelmlesskin()

func _on_default_pressed():
	animated_sprite_2d.sprite_frames = SkinManager.helmknight
	SkinManager.setdefaultskin()


func _on_girl_knight_skin_pressed():
	pass # Replace with function body.
