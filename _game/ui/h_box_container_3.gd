class_name PlayerList extends HBoxContainer



func _ready():
	multiplayer.peer_connected.connect(new_peer)
	multiplayer.peer_disconnected.connect(peer_disconnected)

func new_peer(id: int):
	pass

func peer_disconnected(id: int):
	pass
