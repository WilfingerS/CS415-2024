extends CanvasLayer

var active = false

@onready var player = get_tree().get_first_node_in_group("Player")
var cost1 = 1
var cost2 = 1
var item1 = "Potion"
var item2 = "Max HP+"
var imgfile = "res://Assets/2D Pixel Dungeon Asset Pack/items and trap_animation/flasks/flasks_1_1.png"
var imgfile2 = "res://Assets/plus.png"
# Called when the node enters the scene tree for the first time.
func _ready():
	$GridContainer/Panel/RichTextLabel.text = item1
	$GridContainer/Panel/RichTextLabel2.text = $GridContainer/Panel/RichTextLabel2.text + str(cost1)
	$GridContainer/Panel2/RichTextLabel.text = item2
	$GridContainer/Panel2/RichTextLabel2.text = $GridContainer/Panel2/RichTextLabel2.text + str(cost2)
	$GridContainer/Panel/TextureRect.texture = load(imgfile)
	$GridContainer/Panel2/TextureRect.texture = load(imgfile2)
	closeShop()
	#load_file()
	
func openShop():
	if $GridContainer.visible:
		closeShop()
		return
	$ColorRect.visible = true
	$GridContainer.visible = true
	$RichTextLabel.visible = true
	player.talking = true
	
func closeShop():
	$ColorRect.visible = false
	$GridContainer.visible = false
	$RichTextLabel.visible = false
	player.talking = false
	
func buyitem1():
	if player.coins >= cost1:
		player.potions += 1
		player.coins -= cost1
	
func buyitem2():
	if player.coins >= cost2:
		player.maxHP += 1
		player.HP += 1
		player.coins -= cost2

func _input(event):
	if event.is_action_pressed("buy1"):
		buyitem1()
		print(player.potions)
	if event.is_action_pressed("buy2"):
		buyitem2()
		print(player.maxHP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
