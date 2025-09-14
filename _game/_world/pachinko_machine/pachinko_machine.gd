class_name PachinkoMachine extends Node2D

@onready var slots: Array[PachinkoSlot] = read_children_for_slots()

func read_children_for_slots() -> Array[PachinkoSlot]:
	var arr: Array[PachinkoSlot] = []
	for child: Node in get_children():
		if child is PachinkoSlot:
			arr.append(child)
	return arr
