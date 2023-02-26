extends VehicleBody3D

@onready var test = $test
@export var dash_dist = 7000
var timed_out = false
var flipping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("ui_right", "ui_left") * 0.4, 5 * delta)
	engine_force = Input.get_axis("ui_down", "ui_up") * 900
	if Input.is_action_just_released("ui_accept") && !timed_out:
		timed_out = true
		print("end")
		$".".apply_central_impulse(Vector3(dash_dist * Input.get_axis("ui_down", "ui_up"),0,0).rotated(Vector3(0,1,0), $".".rotation.y).rotated(Vector3(0,0,1), $".".rotation.z))
		await get_tree().create_timer(1.0).timeout
		timed_out = false
	if Input.is_action_just_released("flip") && !flipping:
		flipping = true
		var timer = Timer.new()
		timer.set_wait_time(1.5)
		timer.start()
		get_tree().get_root().add_child(timer)
		while true:
			$".".rotation.x = lerp_angle($".".rotation.x, 0, 1)
			$".".rotation.z = lerp_angle($".".rotation.z, 0, 1)
			if timer.time_left == 0:
				timer.queue_free()
				break
			
		flipping = false
	
