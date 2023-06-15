extends Node3D

var rng = RandomNumberGenerator.new()

var SIZE = 32
var SEGMENT_SIZE = 1
var WORLD_SCALE = 2
var mat = preload("res://models/red.tres")
var pickable = preload("res://scenes/pickable_object.tscn")
@export var noise = FastNoiseLite.new()

func _ready():
	Globals.chunk_size = SIZE
	rng.randomize()
func generate_chunk(chunk_coords: Vector2):
	
	noise.seed = Globals.seed
#	print(chunk_coords, noise.noise_type)
	var starting_mesh = PlaneMesh.new()
	starting_mesh.size = Vector2(SIZE, SIZE)
	starting_mesh.subdivide_depth = (SIZE / SEGMENT_SIZE) - 1
	starting_mesh.subdivide_width = (SIZE / SEGMENT_SIZE) - 1
	
	var st = SurfaceTool.new()
	st.create_from(starting_mesh, 0)
	
	var array_mesh = st.commit_to_arrays()
	var vertex_array = array_mesh[ArrayMesh.ARRAY_VERTEX]
	
	
	for i in vertex_array.size():
		var y = noise.get_noise_2d(SIZE * chunk_coords.x / 1 + vertex_array[i].x / 1, SIZE * chunk_coords.y / 1 + vertex_array[i].z / 1)
		vertex_array[i].y = (pow(2, y * 6.5) - 10 * tan(y)) * 1.7 - 10
	array_mesh[ArrayMesh.ARRAY_VERTEX] = vertex_array
	var y1 = vertex_array[vertex_array.size()/2].y
	
	var arr_mesh = ArrayMesh.new()
	arr_mesh.add_surface_from_arrays(starting_mesh.PRIMITIVE_TRIANGLES, array_mesh)
	
	
	st.create_from(arr_mesh, 0)
	st.generate_normals()
	st.generate_tangents()
	var mesh_inst = MeshInstance3D.new()
	mesh_inst.scale *= WORLD_SCALE
	mesh_inst.position.x = chunk_coords.x * SIZE * WORLD_SCALE
	mesh_inst.position.z = chunk_coords.y * SIZE * WORLD_SCALE
	mesh_inst.mesh = st.commit()
	mesh_inst.set_surface_override_material(0, mat)
	var col_shape = CollisionShape3D.new()
	col_shape.position.x = chunk_coords.x * SIZE * WORLD_SCALE
	col_shape.position.z = chunk_coords.y * SIZE * WORLD_SCALE
	col_shape.scale *= WORLD_SCALE
	col_shape.shape = arr_mesh.create_trimesh_shape()
	
	mesh_inst.name = "m" + str(chunk_coords)
	col_shape.name = "c" + str(chunk_coords)
	add_child(mesh_inst)
	add_child(col_shape)
	if get_tree().current_scene.name != "title" && rng.randi()%3 == 1:
		spawn_pickup(Vector3(chunk_coords.x *SIZE* WORLD_SCALE,y1 * WORLD_SCALE,chunk_coords.y *SIZE* WORLD_SCALE))
	
	

func delete_chunk(pos:Vector2):
	remove_child(get_node("m" + str(pos)))
	remove_child(get_node("c" + str(pos)))


func _on_creative_cam_switched_chunks(prev_pos, new_pos):
	print(prev_pos)
	print(new_pos)

func spawn_pickup(pos):
	var pick_inst = pickable.instantiate()
	var m = rng.randi()%20 
	if m <= 10:
		pick_inst.mode = 1 
	elif m < 17:
		pick_inst.mode = 0 
	else:
		pick_inst.mode = 2 
	pick_inst.name = "p_" + str(pos)
	pick_inst.position = pos
	get_tree().root.get_child(0).add_child(pick_inst)

func erase_all_pickups():
	for i in get_tree().root.get_child(0).get_child_count():
		get_tree().root.get_child(0).get_child(i).queue_free()


func _on_pause_exited():
	print("exited")
	erase_all_pickups()
