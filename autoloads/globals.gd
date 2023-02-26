extends Node

var chunk_size = 32
var render_dist = 4
var seed
func _ready():
	randomize()
#	seed = randi()% 10000
	seed = 42

