extends Node3D

var SIZE = 32
var SEGMENT_SIZE = 1
var WORLD_SCALE = 2

@export var noise = FastNoiseLite.new()

func _ready():
	Globals.chunk_size = SIZE
	
#	generate_chunk(Vector2(0,0))
#	generate_chunk(Vector2(1,0))
#	generate_chunk(Vector2(0,1))
#	generate_chunk(Vector2(1,1))

func generate_chunk(chunk_coords: Vector2):
	noise.seed = Globals.seed
	print(chunk_coords)
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
#		print(y / 10)
		vertex_array[i].y = (pow(2, y * 6.5) - 10 * sin(y)) * 1.7 - 10
	array_mesh[ArrayMesh.ARRAY_VERTEX] = vertex_array
	
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
	var col_shape = CollisionShape3D.new()
	col_shape.position.x = chunk_coords.x * SIZE * WORLD_SCALE
	col_shape.position.z = chunk_coords.y * SIZE * WORLD_SCALE
	col_shape.scale *= WORLD_SCALE
	col_shape.shape = arr_mesh.create_trimesh_shape()
	
	
	add_child(mesh_inst)
	add_child(col_shape)


