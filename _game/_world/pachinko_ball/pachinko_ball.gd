class_name PachinkoBall extends RigidBody2D


@export var left_right_strength: float

@onready var input: PCInput = $PCInput
@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer


var id: int

func _initialize(peer_id: int):
	id = peer_id

func _ready():
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(id)
