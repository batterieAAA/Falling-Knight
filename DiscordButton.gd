extends Button

# Replace this with your official Discord channel link
const DISCORD_URL = "https://discord.gg/tDHxqB4cbP"

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	if OS.shell_open(DISCORD_URL):
		print("Opening Discord channel...")
	else:
		print("Failed to open URL.")
