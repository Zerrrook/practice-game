extends Area2D
class_name FallbackPoint

@onready var fallback_point_marker: Marker2D = $FallbackPointMarker
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		CheckpointManager.fallback_position = fallback_point_marker.global_position
