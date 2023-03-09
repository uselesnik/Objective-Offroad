extends VBoxContainer

var master_bus = AudioServer.get_bus_index("Master")
# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer2/HSlider.value = AudioServer.get_bus_volume_db(master_bus)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
		
