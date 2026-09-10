extends Area2D

#inheritance to receive attacks > must be on attackreceiver layer and mask player attack
class_name AttackReceiver

func receive_attack():
	print ("Ouch I have been attacked uwu")
