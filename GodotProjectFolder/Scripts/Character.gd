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
signal hp_changed # gonna be used for later with uh gui or something
#Onready's
@onready var sprite:Sprite2D = get_node("CharSprite")
@onready var hurtBox:Hurtbox = get_node("Hurtbox")
@onready var inventory = get_node("Inventory")
@onready var bombScene = preload("res://Scenes/Weapons/bomb.tscn")
@onready var weapon:Node2D = get_node("Weapon")
@onready var damage = weapon.damage
#other used variables
var mov_Direction:Vector2 = Vector2.ZERO
var blocking = false
var isDead = false
var isHit = false

# Actions
func pickUP():
	pass
	
func use_Bomb():
	if inventory.use_consumable("bomb"):
		var bomb = bombScene.instantiate()
		owner.add_child(bomb)
		bomb.player = self
		bomb.explode()

func parry():
	if blocking || isHit: # since events handled on _input use just_pressed
		return
	blocking = true
	print("Block?")
	$AnimationPlayer.play("Block")
	var block_duration = $AnimationPlayer.current_animation_length
	await get_tree().create_timer(block_duration).timeout
	blocking = false

# Health Stuff
func take_damage(dmg:int):
	if isHit || blocking:
		return
	
	isHit = true
	$AnimationPlayer.play("OnHit")
	var  invincibility_length = $AnimationPlayer.current_animation_length
	await get_tree().create_timer(invincibility_length).timeout
	set_hp(HP - dmg)
	isHit = false
	
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
	
	if velocity.x >= 0:
		$AnimationPlayer.play("Right_Move")
	if velocity.x < 0:
		$AnimationPlayer.play("Left_Move")
	#create_bomb()
func _input(event):
	if isDead: #Can't Perform Actions if dead
		return
		
	if event.is_action_pressed("attack"):
		weapon.ATTACK()
	if event.is_action_pressed("block"):
		parry()
	if event.is_action_pressed("bomb"):
		use_Bomb()
	if event.is_action_pressed("inventory"):
		inventory.access()
