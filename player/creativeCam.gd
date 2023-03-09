extends Node3D
#experimental #$"../mdt_world"

signal switched_chunks
@onready var cam = $Camera3D
const MOUSE_SENSITIVITY = 0.8
@export var SPEED = 0.05

var chunk_size = Globals.chunk_size
var prev_position = Vector2()
func _ready():
	prev_position = Vector2(0,0)
	
func _process(delta):
	changed_chunk()
	var movement = Vector3(0,0,0)
	if Input.is_action_pressed("fly_up"):
		movement.y = SPEED
	if Input.is_action_pressed("fly_down"):
		movement.y = -SPEED
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement.x = SPEED * input_direction.x
	movement.z = SPEED * input_direction.y
	
	$".".position += movement.rotated(Vector3(0, 1 , 0), $".".rotation.y)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			SPEED *= 1.1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			SPEED *= 0.9
		if event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			SPEED = 0.05
	if event is InputEventMouseMotion:
		cam.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		cam.rotation.x= clampf(cam.rotation.x, deg_to_rad(-89.9), deg_to_rad(89.9))
		
func changed_chunk():
	var chunk_coords = Vector2(round(self.position.x / chunk_size / 2), round(self.position.z / chunk_size / 2))
	if (prev_position.x != chunk_coords.x) || (prev_position.y != chunk_coords.y):
		print("changed_chunk")
		emit_signal("switched_chunks", prev_position - chunk_coords, chunk_coords)
		
	prev_position = chunk_coords
	




