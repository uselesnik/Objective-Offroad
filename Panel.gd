extends Panel

@onready var level = $"/root/Node3d"
@onready var line_edit = $"LineEdit"
@onready var vbox = $"ScrollContainer/VBoxContainer"

var prev_text = ""
var messages = []

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("toggle_chat"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		line_edit.text = ""
	if Input.is_action_just_pressed("ui_text_completion_accept") and visible and line_edit.text != "":
		if line_edit.text[0] == "/":
			decode(line_edit.text.lstrip("/"))
			line_edit.text = ""
		else:
			var newlabel = Label.new()
			newlabel.text = "> " + line_edit.text
			line_edit.text = ""
			vbox.add_child(newlabel)
			messages.append(get_path_to(newlabel))
			

func decode(input):
	if input == "cls":
		for i in messages.size():
			get_node(messages[i]).queue_free()
		messages = []
	elif input == "cam":
		level.switch_cam()
	elif input.left(5) == "seed " :
		input = input.lstrip("seed ")
		for i in get_tree().get_root().get_child_count():
			if get_tree().get_root().get_child(i).is_in_group("seeds"):
				get_tree().get_root().get_child(i).set_new_seed(int(input))
		
