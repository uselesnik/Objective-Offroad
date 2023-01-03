extends Node3D
@onready var cam1 = $"Camera3d"
@onready var cam2 = $"car/Camera3d"
@onready var cam3 = $"car/first_person_cam"

var current_camera = 0
var cameras = []
# Called when the node enters the scene tree for the first time.
func _ready():
	cameras = [cam1, cam2, cam3]
	for i in cameras.size():
		cameras[current_camera].current = false
	cameras[0].current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_cam():
	cameras[current_camera].current = false
	current_camera += 1
	if current_camera == cameras.size():
		current_camera = 0
	cameras[current_camera].current = true
