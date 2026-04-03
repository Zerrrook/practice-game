extends Area2D
class_name Checkpoint

@onready var checkpoint_marker: Marker2D = $CheckpointMarker

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		CheckpointManager.checkpoint_position = checkpoint_marker.global_position
