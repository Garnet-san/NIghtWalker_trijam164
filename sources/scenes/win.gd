extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body:Node):
	get_tree().paused = true
	get_tree().get_root().get_node("Game_lvl1/AudioStreamPlayer2").stream_paused = false
	get_tree().get_root().get_node("Game_lvl1/Control").visible = true