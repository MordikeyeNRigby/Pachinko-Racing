class_name BallSpawner extends MultiplayerSpawner

@export var ball_scene: PackedScene
@export var ball_spawn_location_root: Node2D
#dictionary indexed by peer id and value is an array of its active balls BALLS IN MY MOUTH BALLS BALLS IN MY MOUTH
var balls: Dictionary[int,Array] = {}

var total_ball_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_function = _spawn_function_USE_SPAWN_NEW_BALL


func spawn_new_ball(id: int):
	if !multiplayer.is_server(): return
	var new_ball_data: Dictionary = {#honestly could have done this in a regular way but i didnt feel like it so heres ur in-dictionary anonymous lambda function for determining a valid new spawnpoint
		"peer_id": id,
		"ball_id": (func() -> int: total_ball_count += 1; return total_ball_count - 1).call(),
		"global_position": (func() -> Vector2: #the only reason this is an anonymous lambda function is cuz i didnt feel like moving my cursor outside of the dictionary i was initializing.
			var node: Node
			var i: int = 0
			while !node || node is not Node2D:
				node = ball_spawn_location_root.get_children().pick_random()
				i += 1
				assert(i < 1500,"Cannot find ball spawn location, all nodes are invalid for spawning!")
			return node.global_position
			).call() as Vector2 
	}
	#sort ur balls right dont get ballsticular torsion
	var new_ball: Node2D = spawn(new_ball_data)



func _spawn_function_USE_SPAWN_NEW_BALL(data: Dictionary = {}) -> Node2D:
	
	var peer_id: int = data["peer_id"]
	var ball: PachinkoBall = ball_scene.instantiate()
	#assign the position & peer id
	if data.has("peer_id"):
		ball._initialize(data["peer_id"])
	if data.has("global_position"):
		ball.global_position = data.global_position
	#sort it into a dictionary for later, one peer can have multiple balls to its name
	if balls.has(data["peer_id"]):
		balls[data["peer_id"]].append(ball)
	else:
		balls[data["peer_id"]] = [ball]

	
	#hook up new ball's tree exiting signal to remove itself from the client ball array when queue_freed. makes managing null references ez yee
	ball.tree_exiting.connect(func():
		if balls.has(peer_id) && balls[peer_id].has(ball):
			balls[peer_id].erase(ball)
			if balls[peer_id].size() == 0:
				balls.erase(peer_id)
		)
	return ball
