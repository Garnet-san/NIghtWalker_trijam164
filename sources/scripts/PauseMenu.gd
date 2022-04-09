extends Control


func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		visible = true
		get_tree().paused = true


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://sources/scenes/MainMenu.tscn")

