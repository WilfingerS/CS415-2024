extends CharacterBody2D
class_name Character

const FRICTION: float = 0.15

# Custom Values

# walking
@export var acceleration: int = 40
@export var maxSpeed: int = 100
# hp stuff yea
@export var maxHP: int = 5 
@export var HP: int = 5
#Signals
signal hp_changed # gonna be used for later with uh gui
#Onready's
@onready var sprite:Sprite2D = get_node("CharSprite")
@onready var hurtBox:Hurtbox = get_node("Hurtbox")
@onready var weapon:Node2D = get_node("Weapon")
@onready var damage = weapon.damage

var mov_Direction:Vector2 = Vector2.ZERO
var blocking = false
var isDead = false

# Actions
func attack():
	if Input.is_action_just_pressed("attack"):
		weapon.ATTACK()

func pickUP():
	pass
	
#func create_bomb():
	#if Input.is_action_just_pressed("bomb"):
		#var instance = load("res://Scenes/Weapons/bomb.tscn").instantiate()
		#instance.update_pos()

func parry():
	if Input.is_action_just_pressed("block"):
		blocking = true
		print("Block?")
		$AnimationPlayer.play("Block")
		await get_tree().create_timer(0.5).timeout
		blocking = false

# Health Stuff
func take_damage(dmg:int):
	set_hp(HP-dmg)
	
func set_hp(newHP):
	if newHP < maxHP:
		if newHP <= 0:
			HP = 0
			kill()
		else:
			HP = newHP
	else:
		HP = maxHP
		
func kill():
	print("Player Dead?")
	isDead = true
	# NOTE: IF THE PLAYER DIES THE GAME WILL CLOSE LOL
	#queue_free() # apparently this will delete node after it can be
	
# Movement Stuff
func move():
	mov_Direction = Vector2.ZERO
	if not(isDead):
		mov_Direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
	velocity += mov_Direction * acceleration
	velocity = velocity.limit_length(maxSpeed)
	velocity = lerp(velocity,Vector2.ZERO,FRICTION)
	
func _physics_process(_delta):
	# Character Move OverHere
	move_and_slide()
	move()
	attack()
	parry()
	#create_bomb()
