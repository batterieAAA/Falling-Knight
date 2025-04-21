extends Node

const helmlessskin = preload("res://Assets/Skins/helmlessknight.tres")
const helmknight = preload("res://Assets/Skins/helmknight.tres")
const horseknight = preload("res://Assets/Skins/horseknight.tres")
const goldknight = preload("res://Assets/Skins/goldknight.tres")


var currentskin = helmknight

var newtrophy = false
var trophies = {
	"trophy1": false,
	"trophy2": false,
	"trophy3": false,
	"trophy4": false,
	"trophy5": false,
	"trophy6": false,
	"trophy7": false,
	"trophy8": false,
	"trophy9": false,
	"trophy10": false,
	"trophy11": false,
	"trophy12": false,
	
	# Add remaining trophies here
}

var totalhealfruit = 0
var totalgodfruit = 0
var totalgreenfruit = 0
var totalcoin = 0

var currentfloor = 1
var currentscore = 0


var spendablegold = 0
var boughtshield = false
var shieldbroke = false
var boughtgoldarmor = false



func updatecurrentskin(): 
	currentskin = helmlessskin
func sethorseskin(): 
	currentskin = horseknight
func setgoldskin(): 
	currentskin = goldknight
func sethelmlesskin(): 
	currentskin = helmlessskin
func setdefaultskin(): 
	currentskin = helmknight


# Save game data
func save_game():
	var config = ConfigFile.new()
	
	# Save trophies dynamically
	for trophy_name in trophies.keys():
		config.set_value("GameData", trophy_name, trophies[trophy_name])
	
	# Save other game data
	config.set_value("GameData", "totalhealfruit", totalhealfruit)
	config.set_value("GameData", "totalgodfruit", totalgodfruit)
	config.set_value("GameData", "totalgreenfruit", totalgreenfruit)
	config.set_value("GameData", "totalcoin", totalcoin)
	config.set_value("GameData", "boughtshield", boughtshield)
	config.set_value("GameData", "spendablegold", spendablegold)
	config.set_value("GameData", "boughtgoldarmor", boughtgoldarmor)
	
	var error = config.save("user://savegame.cfg")
	if error == OK:
		print("Game saved successfully!")
	else:
		print("Failed to save game! Error code: ", error)

# Load game data
func load_game():
	var config = ConfigFile.new()
	
	var error = config.load("user://savegame.cfg")
	if error == OK:
		# Load trophies dynamically
		for trophy_name in trophies.keys():
			trophies[trophy_name] = config.get_value("GameData", trophy_name, false)
		
		# Load other game data
		totalhealfruit = config.get_value("GameData", "totalhealfruit", 0)
		totalgodfruit = config.get_value("GameData", "totalgodfruit", 0)
		totalgreenfruit = config.get_value("GameData", "totalgreenfruit", 0)
		totalcoin = config.get_value("GameData", "totalcoin", 0)
		boughtshield = config.get_value("GameData", "boughtshield", false)
		spendablegold = config.get_value("GameData", "spendablegold", 0)
		boughtgoldarmor = config.get_value("GameData", "boughtgoldarmor", false)
		
		
		print("Game loaded successfully!")
	else:
		print("Failed to load game! Error code: ", error)

func reset_save_file():
	var config = ConfigFile.new()
	config.clear()  # Clear all in-memory data
	var error = config.save("user://savegame.cfg")  # Overwrite the save file with empty content
	if error == OK:
		print("Save file reset successfully!")
	else:
		print("Failed to reset save file! Error code: ", error)
