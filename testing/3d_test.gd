extends Node3D

var noise = FastNoiseLite.new()

var array_quad_vertices = []
var array_quad_indices = []
var array_chunk_points = []
 
var dictionary_check_quad_vertices = {}
 
var chunk_size = Globals.chunk_size
const chunk_segments = 4
 
func _ready():
	noise.seed = 23846
	
	make_chunk(Vector2(0, 0))
	
	make_chunk(Vector2(1, 0))
	
	make_chunk(Vector2(0, 1))
	
	make_chunk(Vector2(1, 1))
	
 
 
func make_chunk(coords: Vector2):
	array_quad_vertices = []
	array_quad_indices = []
	array_chunk_points = []
	array_chunk_points = create_2d_array(chunk_segments + 1, chunk_segments + 1, Vector3(0,0,0))
	dictionary_check_quad_vertices = {}
	
	var surface_tool = SurfaceTool.new()
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)

	create_chunk_points(coords)
	add_quads()
	
	for vertex in array_quad_vertices:
		
		surface_tool.add_vertex(vertex)
		
	for index in array_quad_indices:
		surface_tool.add_index(index)
	
#	surface_tool.generate_normals()
#	surface_tool.generate_tangents()
	
	var arr_mesh = ArrayMesh.new()
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_tool.commit_to_arrays())
	var coll_shape = CollisionShape3D.new()
	coll_shape = arr_mesh.create_trimesh_shape()
	var meshinst = MeshInstance3D.new()
	meshinst.mesh = surface_tool.commit()
	
	add_child(meshinst)
#	add_child(coll_shape)
	

 
 
func add_quad(point_1, point_2, point_3, point_4):
	
	var vertex_index_one
	var vertex_index_two
	var vertex_index_three
	var vertex_index_four
	
	vertex_index_one = _add_or_get_vertex_from_array(point_1)
	vertex_index_two = _add_or_get_vertex_from_array(point_2)
	vertex_index_three = _add_or_get_vertex_from_array(point_3)
	vertex_index_four = _add_or_get_vertex_from_array(point_4)
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_two)
	array_quad_indices.append(vertex_index_three)
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_three)
	array_quad_indices.append(vertex_index_four)
 
 
func _add_or_get_vertex_from_array(vertex):
	if dictionary_check_quad_vertices.has(vertex) == true:
		return dictionary_check_quad_vertices[vertex]
	
	else:
		array_quad_vertices.append(vertex);
		
		dictionary_check_quad_vertices[vertex] = array_quad_vertices.size()-1
		return array_quad_vertices.size()-1

func create_chunk_points(coords: Vector2):
	var step = float(chunk_size) / chunk_segments
	for x in chunk_segments + 1:
		for y in chunk_segments + 1:
			array_chunk_points[x][y] = 1
			var height = noise.get_noise_2d(coords.x * chunk_segments + x + 0.5, coords.y * chunk_segments + y + 0.5) * 16
			array_chunk_points[x][y] = Vector3(coords.x * chunk_size + x * step, height, coords.y * chunk_size + y * step)

func add_quads():
	for x in chunk_segments:
		for y in chunk_segments:
			add_quad(array_chunk_points[x][y], array_chunk_points[x + 1][y], array_chunk_points[x + 1][y + 1], array_chunk_points[x][y + 1])

	

func create_2d_array(width, height, starting_value):
	var a = []
	
	for y in range(height):
		a.append([])
		a[y].resize(width)
		
		for x in range(width):
			a[y][x] = starting_value
	
	return a
