class_name World extends Node2D

signal server_registered_you()

@onready var current_machine: PachinkoMachine = $"Pachinko Machine"
@onready var ball_spawner: BallSpawner = $BallSpawner
@onready var UI:  Control = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#ui to spawn ball appears
func _on_networker_new_peer(id: int) -> void:
	if !multiplayer.is_server(): return
	enable_game_ui.rpc_id(id)

@rpc("authority","call_remote","reliable")
func enable_game_ui():
	server_registered_you.emit()


func _on_spawn_ball_button_up() -> void:
	if multiplayer.is_server(): return
	_requested_ball_spawn.rpc_id(1)

@rpc("any_peer","call_remote","reliable")
func _requested_ball_spawn():
	if !multiplayer.is_server(): return
	ball_spawner.spawn_new_ball(multiplayer.get_remote_sender_id())
