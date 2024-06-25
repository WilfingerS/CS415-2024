extends CanvasLayer

var page = 0
var active = false
var spoke = false

@onready var player = get_tree().get_first_node_in_group("Player")
var textFile = "res://Scripts/Dialogue/healDialog1.txt"
var dialogue = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect.visible = false
	load_file()
	
func load_file():
	var file = FileAccess.open(textFile,FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		dialogue.append(line)
	file.close()
	

func talk():
	if active:
		page +=1
		if page >= len(dialogue):
			spoke = true
			$NinePatchRect.visible = false
			player.talking = false
			return
		$NinePatchRect/text.text = dialogue[page]
	else:
		active = true
		$NinePatchRect.visible = true
		$NinePatchRect/text.text = dialogue[page]
		player.talking = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
