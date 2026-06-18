extends Node
var stars = []

func _process(delta: float) -> void:
	#addStars()
	pass

func addStars():
	if Input.is_action_just_pressed("1"):
		if 1 not in stars:
			stars.append(1)
		else:
			stars.erase(1)
	if Input.is_action_just_pressed("2"):
		if 2 not in stars:
			stars.append(2)
		else:
			stars.erase(2)
	if Input.is_action_just_pressed("3"):
		if 3 not in stars:
			stars.append(3)
		else:
			stars.erase(3)
	if Input.is_action_just_pressed("4"):
		if 4 not in stars:
			stars.append(4)
		else:
			stars.erase(4)
	if Input.is_action_just_pressed("5"):
		if 5 not in stars:
			stars.append(5)
		else:
			stars.erase(5)
