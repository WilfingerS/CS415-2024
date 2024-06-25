extends Sprite2D
class_name Shield

func Left():
	$AnimationPlayer.play("Left")
	
func Right():
	$AnimationPlayer.play("Right")
	
func Up():
	$AnimationPlayer.play("Backward")
	
func Down():
	$AnimationPlayer.play("Forward")
	
func Block():
	$AnimationPlayer.play("Block")
