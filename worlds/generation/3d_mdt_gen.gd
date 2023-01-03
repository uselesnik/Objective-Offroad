extends Node3D

var SIZE = Globals.chunk_size
var SEGMENT_SIZE = 8
@export var noise = FastNoiseLite.new()

func _ready():
	pass
#	generate_chunk(Vector2(0,0))
#	generate_chunk(Vector2(1,0))
#	generate_chunk(Vector2(0,1))
#	generate_chunk(Vector2(1,1))

func generate_chunk(chunk_coords: Vector2):
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
		vertex_array[i].y = noise.get_noise_2d(SIZE * chunk_coords.x + vertex_array[i].x, SIZE * chunk_coords.y + vertex_array[i].z) * 10
	array_mesh[ArrayMesh.ARRAY_VERTEX] = vertex_array
	
	
	var arr_mesh = ArrayMesh.new()
	arr_mesh.add_surface_from_arrays(starting_mesh.PRIMITIVE_TRIANGLES, array_mesh)
	
	st.create_from(arr_mesh, 0)
	st.generate_normals()
	st.generate_tangents()
	var mesh_inst = MeshInstance3D.new()
	mesh_inst.position.x = chunk_coords.x * SIZE 
	mesh_inst.position.z = chunk_coords.y * SIZE 
	mesh_inst.mesh = st.commit()
	var col_shape = CollisionShape3D.new()
	col_shape.position.x = chunk_coords.x * SIZE 
	col_shape.position.z = chunk_coords.y * SIZE 
	col_shape.shape = arr_mesh.create_trimesh_shape()
	
	
	add_child(mesh_inst)
	add_child(col_shape)


