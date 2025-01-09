extends Area2D


signal levelcomplete

func _on_body_entered(body):
	levelcomplete.emit()
