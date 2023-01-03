extends VehicleBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("ui_right", "ui_left") * 0.4, 5 * delta)
	engine_force = Input.get_axis("ui_down", "ui_up") * 900
