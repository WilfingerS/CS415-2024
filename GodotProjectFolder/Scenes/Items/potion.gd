extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
var helthAdded = 1


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

	
	
func _on_interact():
	Global.player.addPotion()
	queue_free()
	

