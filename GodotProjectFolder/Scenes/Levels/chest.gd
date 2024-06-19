extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation = $AnimationPlayer
@onready var Inv = []
var scene_to_instance = preload("res://Scenes/Levels/Key.tscn")

const lines: Array[String] = [
	"Hey Im a Cheast!"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	if Global.Keys != 0:
		get_node("InteractionArea/CollisionShape2D").disabled = true
		animation.play("Open")
		print(Global.Keys)
		Global.Keys -= 1
		print(Global.Keys)

