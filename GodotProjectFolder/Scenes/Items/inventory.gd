extends Control
class_name Inventory

var slotScene = preload("res://Scenes/Items/slot.tscn")
@onready var character = self.get_parent()
@onready var grid_container = get_node("GridContainer")
@onready var slots = grid_container.get_children()

#Items That are added to the inventory? 
# Max hold of 13-16 (First 3 of slots is Weapon,Shield,Armor)
@onready var inventory = [
	["Weapon",character.get_node("Weapon")], #These link to objects on the character
	["Shield",character.get_node("Shield")],
	["Armor",character.get_node("Armor")],
	["Bomb",5,null], # Consumables should maybe look like this? null for now should be the path to the item
	["Potion",0,null],
	
]


func use_consumable(item:String):
	var canUse = false
	if item == "bomb":
		if inventory[3][1] > 0:
			inventory[3][1] -= 1
			canUse = true
	if item == "potion":
		if inventory[4][1] > 0:
			inventory[4][1] -= 1
			canUse = true
	
	return canUse
	
func access():
	visible = not(visible)
	
func update_ui():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#print(Inventory)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(inventory)
