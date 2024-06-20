extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation = $AnimationPlayer

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
		get_node("InteractionArea/CollisionShape2D").disabled = true
		animation.play("Open")

