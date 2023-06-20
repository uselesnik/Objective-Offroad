extends Node
var chunk_size = 32
var render_dist = 8
var seed
var fuel_value = 100
var health = 6
var pause_menu = false
var score = 0
var coins = 0
var highScore = 0
var muted = false
var pickups = [0,0,0,0]
func _ready():
	randomize()
	seed = randi()% 10000
#	seed = 42
func apply_to_car(mode):
	pass
