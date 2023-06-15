extends Node

var current_chunks = {}
@onready var world_gen = get_parent().get_node("mdt_world")
var chunk_circle_template = []

func _ready(): 
	world_gen.erase_all_pickups()
	chunk_circle_template = generate_chunk_circle_template()
	generate_chunk_circle(0,0)
	print("loaded")
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cut"):
		generate_chunk_circle(10,10)
#needs to be called everytime the render distance changes


func generate_chunk_circle_template():
	var chunk_circle = []
	for x in range(-Globals.render_dist, Globals.render_dist + 1):
		for y in range(-Globals.render_dist, Globals.render_dist + 1):
			if hipotenuza(x, y) <= Globals.render_dist:
				chunk_circle.append(Vector2(x, y))
	return chunk_circle


func generate_chunk_circle(x, y, generete:bool = true):
	var ret = []
	for i in chunk_circle_template.size():
		var local_coords = Vector2(chunk_circle_template[i].x + x, chunk_circle_template[i].y + y)
		var key = str(local_coords)
		if !current_chunks.has(key):
			ret.append(str(local_coords))
			if generete:
				world_gen.generate_chunk(Vector2(local_coords.x, local_coords.y))
			current_chunks[key] = true
	return ret

func erase_unused(new_pos):
	pass
#	var new_circle = generate_chunk_circle(new_pos.x, new_pos.y, false)
#	var prev_circle = current_chunks.keys()
#	for i in prev_circle.size():
#		if !new_circle.has(prev_circle[i]):
#			current_chunks.erase(prev_circle[i])
#			print("deleting: ", prev_circle[i])
#			world_gen.delete_chunk(str_to_var("Vector2" + prev_circle[i]))
	

func hipotenuza(x, y):
	return sqrt(pow(x, 2) + pow(y, 2))


func _on_creative_cam_switched_chunks(direction, new_pos):
	generate_chunk_circle(new_pos.x, new_pos.y)
	print(direction)
	erase_unused(new_pos)
	#todo izračunaj kateri del kroga se izbriše in ga zavrti glede na podano smer
	#to dobiš tako da generiraš 2 array kroga, ju premakneš za 1 in ju odšteješ


func _on_car_switched_chunks(direction, new_pos):
	generate_chunk_circle(new_pos.x, new_pos.y)
	erase_unused(new_pos)


func _on_spin_box_value_changed(value):
	chunk_circle_template = generate_chunk_circle_template()
