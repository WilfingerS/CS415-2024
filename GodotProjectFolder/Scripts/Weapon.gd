extends Node2D

#Exports
@export var attackDmg:int = 1
@export var weaponName:String = "Sword"
#OnReady
@onready var weapon:Node2D =  get_node("Node2D")
@onready var sprite:Sprite2D = weapon.get_node("Sprite2D")
@onready var hitbox:Hitbox = weapon.get_node("Hitbox")

func ATTACK():
	print("attack")

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
