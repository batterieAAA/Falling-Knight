extends Panel

@onready var buy_shield_button = $HBoxContainer/VBoxContainer/BuyShieldButton
@onready var gold_armor_button = $HBoxContainer/VBoxContainer/GoldArmorButton





@export_group("prices")
@export var shieldprice = 100
@export var potionprice = 100
@export var goldarmorprice = 1000
@export var mysteryboxprice = 100


func _on_button_2_pressed():
	
	
	
	SoundManager.startbutton.play()
	SkinManager.setgoldskin()
	SkinManager.spendablegold -= goldarmorprice
	SkinManager.boughtgoldarmor = true
	gold_armor_button.disabled = true
	$"../..".updatespendablegold()
	SkinManager.save_game()


func _on_buy_shield_button_pressed():
	SoundManager.startbutton.play()
	SkinManager.boughtshield = true
	buy_shield_button.disabled = true
	SkinManager.spendablegold -= shieldprice
	$"../..".updatespendablegold()
	SkinManager.save_game()
	


func _on_shop_pressed():
	SoundManager.old_man_yoroshiku.play()
	$"../TutorialPanel".hide()
	$"../TrophyPanel".hide()
	$"../CosmeticPanel".hide()
	$"../Panel".hide()
	
	visible = !visible
	buy_shield_button.text = str(shieldprice)
	gold_armor_button.text = str(goldarmorprice)
	if SkinManager.spendablegold >= shieldprice and not SkinManager.boughtshield:
		buy_shield_button.disabled = false
	else:
		gold_armor_button.disabled = true
	if SkinManager.spendablegold >= goldarmorprice and not SkinManager.boughtgoldarmor:
		gold_armor_button.disabled = false
	else:
		gold_armor_button.disabled = true
