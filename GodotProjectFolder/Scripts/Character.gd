extends CharacterBody2D
class_name Character

const FRICTION: float = 0.15

# Custom Values

# walking
@export var acceleration: int = 40
@export var maxSpeed: int = 100
# hp stuff yea
@export var maxHP: int = 3
@export var HP: int = 3
#Signals
signal hp_changed # gonna be used for later with uh gui or something
#Onready's
@onready var sprite:Sprite2D = get_node("CharSprite")
@onready var hurtBox:Hurtbox = get_node("Hurtbox")
@onready var inventory = get_node("Inventory")
@onready var bombScene = preload("res://Scenes/Weapons/bomb.tscn")
@onready var weapon:Node2D = get_node("Weapon")
@onready var shield:Sprite2D = get_node("Shield")
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
	await shield.Block()
	blocking = false

# Health Stuff
func take_damage(dmg:int):
	if isHit or blocking or isDead:
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
	hp_changed.emit(newHP)
func kill():
	#print("Player Dead?")
	isDead = true
	weapon.visible = false
	shield.visible = false  
	$AnimationPlayer.play("Death_Roll")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("Death")
	
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
	
	# Velocity based facing
	
	#if velocity.length() < 1:
		#$AnimationPlayer.stop() # or play an idle animation
	#elif abs(velocity.y) > abs(velocity.x):
		#if velocity.y > 0:
			#$AnimationPlayer.play("Down_Move")
		#else:
			#$AnimationPlayer.play("Up_Move")
	#else:
		#if velocity.x > 0:
			#$AnimationPlayer.play("Right_Move")
		#else:
			#$AnimationPlayer.play("Left_Move")
	
	#rotation based facing
	var mouse_position = get_global_mouse_position()		
	var direction = mouse_position - global_position
	var angle = direction.angle()	
	if not isHit and not isDead:
		if velocity.length() < 1:
			if abs(angle) < PI / 4:
				shield.Right()
				$AnimationPlayer.play("Right")
			elif abs(angle) > 3 * PI / 4:
				shield.Left()
				$AnimationPlayer.play("Left")
			elif angle > 0:
				shield.Down()
				$AnimationPlayer.play("Down")
			else:
				shield.Up()
				$AnimationPlayer.play("Up")
		else:
			if abs(angle) < PI / 4:
				shield.Right()
				$AnimationPlayer.play("Right_Move")
			elif abs(angle) > 3 * PI / 4:
				shield.Left()
				$AnimationPlayer.play("Left_Move")
			elif angle > 0:
				shield.Down()
				$AnimationPlayer.play("Down_Move")
			else:
				shield.Up()
				$AnimationPlayer.play("Up_Move")
			
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
