extends Sprite2D
class_name Shield

var is_blocking = false

func Left():
	if not is_blocking:
		$AnimationPlayer.play("Left")

func Right():
	if not is_blocking:
		$AnimationPlayer.play("Right")

func Up():
	if not is_blocking:
		$AnimationPlayer.play("Backward")

func Down():
	if not is_blocking:
		$AnimationPlayer.play("Forward")

func Block():
	is_blocking = true
	$AnimationPlayer.play("Block")
	var block_duration = $AnimationPlayer.current_animation_length
	await get_tree().create_timer(block_duration).timeout
	is_blocking = false
