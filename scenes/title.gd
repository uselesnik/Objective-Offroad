extends Node2D

var new_game = preload("res://scenes/new_world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_play_pressed():
	var new_game_inst = new_game.instantiate()
	new_game_inst.name = "menu"
	$VBoxContainer.add_child(new_game_inst)
	$VBoxContainer.move_child(new_game_inst, 1)

