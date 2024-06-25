extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	if get_node("NPC Dialog").spoke == false:
		get_node("NPC Dialog").talk()
	else:
		get_node("Shop2").openShop()
		
