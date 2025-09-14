class_name PachinkoSlot extends Area2D

func _ready():
	collision_layer = 0#dont be detected
	collision_mask = 1#detect balls only
	
