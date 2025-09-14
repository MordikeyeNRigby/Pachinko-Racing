class_name PachinkoBall extends NetworkRigidBody2D


@export var left_right_strength: float

@onready var input: PCInput = $PCInput
@onready var synchronizer: RollbackSynchronizer = $Synchronizer


var id: int

func _initialize(peer_id: int):
	id = peer_id

func _ready():
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(id)
	if !synchronizer: return
	synchronizer.process_settings()
	synchronizer.process_authority()

func _physics_rollback_tick(_delta: float, _tick: int):
	pass
