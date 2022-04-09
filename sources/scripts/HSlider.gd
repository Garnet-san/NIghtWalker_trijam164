extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	value = GlobalValues.globalAudioVolume
	var percentage = (60+value)/0.6
	get_parent().get_node("Label2").text = str(percentage," %")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value:float):
	var percentage = (60+value)/0.6
	get_parent().get_node("Label2").text = str(percentage," %")
	get_parent().get_parent().get_node("AudioPlayer").volume_db = value
	GlobalValues.globalAudioVolume = value
