extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$".".rotation.y += (delta * 0.1)
#	print(rotation_degrees.y)
	if rotation_degrees.y >= 360:
		get_tree().quit()