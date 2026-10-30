class_name LiquidCounter

var bodies_of_water : int
signal water_entered()
signal water_exited()

func change_water(entering:bool):
	if entering:
		bodies_of_water += 1
		if bodies_of_water == 1:
			water_entered.emit()
	else:
		bodies_of_water -= 1
		if bodies_of_water == 0:
			water_exited.emit()
