extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation = $AnimationPlayer
@onready var openSound = $AudioStreamPlayer
var open = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	if !open:
		open = true
		openSound.play()
		animation.play("open")
		await get_tree().create_timer(Global.time_in_seconds-.5).timeout
		get_node("StaticBody2D/CollisionShape2D").disabled = open
		get_node("InteractionArea/CollisionShape2D").disabled = open
	

