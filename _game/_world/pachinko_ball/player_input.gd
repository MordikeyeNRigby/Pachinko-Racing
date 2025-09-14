class_name PCInput extends BaseNetInput

var l_axis: Vector2

var r_axis: Vector2

func _gather():
	l_axis = Vector2(Input.get_axis("Left","Right"),Input.get_axis("Up","Down"))
