extends Panel
@onready var label = $Label
@onready var trophydot = $"../TrophyButton/Trophydot"
@onready var shop_panel = $"../ShopPanel"
@onready var cosmetic_panel = $"../CosmeticPanel"
@onready var tutorial_panel = $"../TutorialPanel"




func _on_trophy_b_pressed():
	$"../CosmeticPanel".hide()
	$"../ShopPanel".hide()
	$"../Panel".hide()
	$"../TutorialPanel".hide()
	
	visible = !visible
	trophydot.hide()
	SoundManager.chick_sound.play()
	if SkinManager.trophies["trophy1"] == true:
		$"HBoxContainer/VBoxContainer/1stTrophyButton".buttonactivate()
		
	if SkinManager.trophies["trophy2"] == true:
		$"HBoxContainer/VBoxContainer2/2ndTrophyButton".buttonactivate()
		
	if SkinManager.trophies["trophy3"] == true:
		$"HBoxContainer/VBoxContainer3/3rdTrophyButton".buttonactivate()
	if SkinManager.trophies["trophy4"] == true:
		$"HBoxContainer/VBoxContainer/4thTrophyButton".buttonactivate()

	if SkinManager.trophies["trophy5"] == true:
		$"HBoxContainer/VBoxContainer2/5thTrophyButton".buttonactivate()

	if SkinManager.trophies["trophy6"] == true:
		$HBoxContainer/VBoxContainer3/CoinTrophyButton.buttonactivate()

	if SkinManager.trophies["trophy7"] == true:
		$HBoxContainer/VBoxContainer/HearthTrophyButton.buttonactivate()

	if SkinManager.trophies["trophy8"] == true:
		$HBoxContainer/VBoxContainer2/GodFruitTrophyButton.buttonactivate()

	if SkinManager.trophies["trophy9"] == true:
		$HBoxContainer/VBoxContainer3/GreenFruitTrophyButton.buttonactivate()

	if SkinManager.trophies["trophy10"] == true:
		$HBoxContainer/VBoxContainer/HorseTrophyButton.buttonactivate()

	if SkinManager.trophies["trophy11"] == true:
		$HBoxContainer/VBoxContainer2/Button.buttonactivate()

	if SkinManager.trophies["trophy12"] == true:
		$HBoxContainer/VBoxContainer3/Button4.buttonactivate()





func _on_st_trophy_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Beat the first floor"


func _on_th_trophy_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Beat the 4th floor"


func _on_hearth_trophy_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Collect HeartFruits"


func _on_horse_trophy_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Pet the Horse"


func _on_second_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Beat the 2nd Floor"

func _on_fifth_button_pressed():
	SoundManager.kochuksound.play()
	label.text = "Beat the Dragon"
func _on_godfruit_pressed():
	SoundManager.kochuksound.play()
	label.text = "Collect x GodFruit"

func _on_buytrophy_pressed():
	SoundManager.kochuksound.play()
	label.text = "Buy Something from the shop"

func _on_thirdtrophy_pressed():
	SoundManager.kochuksound.play()
	label.text = "Beat the 3rd Floor"

func _on_cointrophy_pressed():
	SoundManager.kochuksound.play()
	label.text = "Collect X Coins"

func _on_Greenfruit_pressed():
	SoundManager.kochuksound.play()
	label.text = "Collect X GreenFruits"

func _on_button4_pressed():
	SoundManager.kochuksound.play()
	label.text = "???"
