## A utility class for wrapping logging/debugging functionality. modified from booches code to make it a singleton to use the multiplayer api nicely
extends Node

enum Severity {INFO, WARNING, ERROR, IMPORTANT}

var multiplayer_id: String:
	get():
		if multiplayer.has_multiplayer_peer():
			return str(multiplayer.get_unique_id())
		else:
			return "?"

var print_exclusively: int = 1

## Prints the time it takes for a method to execute.
func print_method_runtime(function: Callable) -> void:
	var start_time: int = Time.get_ticks_msec()
	function.call()
	var end_time: int = Time.get_ticks_msec()
	var total_seconds : float = float(end_time - start_time) / 1000
	print(str(function) + " took " + str(total_seconds) + " seconds to run.")


## Prints the path to a node from the root of the SceneTree that the node resides in.
func print_absolute_path_to(node: Node):
	print(node.get_path())



func print_info(message: String) -> void:
	log_message(message, Severity.INFO)


func print_warning(message: String) -> void:
	log_message(message, Severity.WARNING)


func print_error(message: String) -> void:
	log_message(message, Severity.ERROR)


func print_important(message: String):
	log_message(message, Severity.IMPORTANT)


func log_message(message : String, severity : Severity) -> void:
	var datetime_string = Time.get_time_string_from_system()
	var formatted_message: String = datetime_string + " PEER-ID: " + multiplayer_id + " -> " + message
	if print_exclusively != 0 && multiplayer.get_unique_id() != print_exclusively: return
	match severity:
		Severity.INFO:
			print_rich("[color=white]" + formatted_message + "[/color]")
		Severity.WARNING:
			print_rich("[color=yellow]" + formatted_message + "[/color]")
		Severity.ERROR:
			print_rich("[color=red]" + formatted_message + "[/color]")
		Severity.IMPORTANT:
			print_rich("[color=green]" + formatted_message + "[/color]")
