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
@onready var bombScene = preload("res://Scenes/Weapons/bomb.tscn")
@onready var inventory:Control = get_node("Inventory")

@onready var weapon:Node2D = get_node("Weapon")
@onready var damage = weapon.damage

var mov_Direction:Vector2 = Vector2.ZERO
<<<<<<< Updated upstream
=======
var blocking = false
var isDead = false
var isHit = false
var invOpen = false
# Dictionary of Items for Inventory
>>>>>>> Stashed changes

func access_inventory():
	if invOpen:
		invOpen = false
	else:
		invOpen = true
# Actions
<<<<<<< Updated upstream
func attack():
	if Input.is_action_just_pressed("attack"):
		weapon.ATTACK()

func pickUP():
	pass
=======
func pickUP(item,type:String):
	# Type should be the type of item it is picking up
	# "Weapon","Shield","Armor","Potion","Bomb","Currency?"
	# Item should be the node passed
	pass
	
func use_Bomb():
	if inventory.use_item("bomb"):
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
>>>>>>> Stashed changes

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
	# NOTE: IF THE PLAYER DIES THE GAME WILL CLOSE LOL
	#queue_free() # apparently this will delete node after it can be
	
# Movement Stuff
func move():
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
<<<<<<< Updated upstream
	attack()
=======
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
>>>>>>> Stashed changes
