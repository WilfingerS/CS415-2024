extends Node2D

var player = null

func _on_detection_area_body_entered(body):
	player = body
	
func _on_detection_area_body_exited(_body):
	player = null
