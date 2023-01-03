extends Node

@onready var world_gen = get_parent().get_node("mdt_world")
var chunk_circle_template = []

func _ready():
	chunk_circle_template = generate_chunk_circle_template()
	generate_chunk_circle(0,0)
	pass




#needs to be called everytime the render distance changes
func generate_chunk_circle_template():
	var chunk_circle = []
	for x in range(-Globals.render_dist, Globals.render_dist + 1):
		for y in range(-Globals.render_dist, Globals.render_dist + 1):
			if hipotenuza(x, y) <= Globals.render_dist:
				chunk_circle.append(Vector2(x, y))
	return chunk_circle


func generate_chunk_circle(x, y):
	for i in chunk_circle_template.size():
		world_gen.generate_chunk(Vector2(chunk_circle_template[i].x + x, chunk_circle_template[i].y + y))

func hipotenuza(x, y):
	return sqrt(pow(x, 2) + pow(y, 2))
