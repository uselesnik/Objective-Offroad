extends Area3D

var value = 0
var og_pos 
signal picked_up
# Called when the node enters the scene tree for the first time.
func _ready():
	og_pos = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value += delta / 1.02
	position.y = og_pos + 0.2 * sin(value)
	rotate_y(delta * 2)


func _on_body_entered(body):
	if body.is_in_group("car"):
		print_debug("object picked up")
		emit_signal("picked_up")
		queue_free()
