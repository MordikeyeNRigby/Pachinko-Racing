##Utility class giving us useful static functions for any boiler-plate heavy tasks or mathematics used in multiple locations.
class_name Utils

static func get_clean_buffer() -> StreamPeerBuffer:
	var buffer := StreamPeerBuffer.new()
	buffer.resize(256)
	buffer.seek(0)
	return buffer

static func get_buffer(data: PackedByteArray) -> StreamPeerBuffer:
	var buffer := StreamPeerBuffer.new()
	buffer.put_data(data)
	buffer.seek(0)
	return buffer

static func serialize_vecti(buffer: StreamPeerBuffer, v: Vector2i) -> PackedByteArray:
	buffer.put_64(v.x)
	buffer.put_64(v.y)
	return buffer.data_array

static func deserialize_vecti(buffer: StreamPeerBuffer) -> Vector2i:
	return Vector2i(buffer.get_64(),buffer.get_64())
