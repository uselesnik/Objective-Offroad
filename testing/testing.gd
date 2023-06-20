extends Node2D

var noise = FastNoiseLite.new()
var seed = 0
var max:float = 0
var min:float = 10
var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_texture()
	

func generate_texture():
	
	noise.offset = Vector3($".".position.x, $".".position.y, 0)
	noise.seed = seed
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	var image = noise.get_image(256,256)
	var texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = texture
	

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * 5

func _physics_process(delta):
	generate_texture()
	get_input()
	var curr_data = noise.get_noise_2d($".".position.x, $".".position.y)
	if (min > curr_data):
		min = curr_data
	if (max < curr_data):
		max = curr_data
	print("min ", min, "max ", max)

	$".".position += velocity

func set_new_seed(n_seed):
	seed = n_seed
	generate_texture()
