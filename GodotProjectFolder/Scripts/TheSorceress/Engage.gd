extends State

func Enter():
	var random = randi_range(1,3)
	print("ENGAGE MODE")
	match random:
		1:
			ChangeState.emit(self, "SlideInto")
		2:
			ChangeState.emit(self, "Melee")
		3:
			ChangeState.emit(self, "Cast")
