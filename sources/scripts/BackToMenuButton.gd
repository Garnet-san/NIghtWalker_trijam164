extends Button





func _on_BackToMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://sources/scenes/MainMenu.tscn")
