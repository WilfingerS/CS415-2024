extends HBoxContainer

@onready var heart_scene = preload("res://Hud/heart.tscn")

func setMaxHealth(max: int):
	for hp in max:
		var heart = heart_scene.instantiate()
		add_child(heart)

func update(current_hp: int):
	var hearts = get_children()
	
	for hp_index in current_hp:
		hearts[hp_index].update(true)
 
	for hp_index in range(current_hp, hearts.size()):
		hearts[hp_index].update(false)
