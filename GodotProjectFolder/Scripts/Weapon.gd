extends Node2D
class_name Weapon
#Exports
@export var weaponName:String = "Sword"
@export var damage:int = 1
#OnReady
@onready var weapon:Node2D =  get_node("Node2D")
@onready var sprite:Sprite2D = weapon.get_node("Sprite2D")
@onready var hitbox:Hitbox = weapon.get_node("Hitbox")
@onready var animPlayer:AnimationPlayer = weapon.get_node("AnimationPlayer")

func ATTACK():
	if not animPlayer.is_playing():
		animPlayer.play("Swing")

func _process(_delta):
	#Update Rotation of weapon
	var mouseDirection:Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouseDirection.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif mouseDirection.x < 0 and not sprite.flip_h:
		sprite.flip_h = true

	weapon.rotation = mouseDirection.angle()
	
	if weapon.scale.y == 1 and mouseDirection.x < 0:
		weapon.scale.y = -1
	elif weapon.scale.y == -1 and mouseDirection.x > 0:
		weapon.scale.y = 1
	# Attack change this to the player
	#attack()
