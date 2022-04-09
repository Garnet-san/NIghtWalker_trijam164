extends Button



func _on_ContinueButton_pressed():
	get_tree().paused = false
	get_parent().visible = false
