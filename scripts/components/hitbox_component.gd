class_name HitboxComponent
extends Area2D

@export var damage := 1

func get_hit_data(target_position: Vector2):
	var direction = (target_position - global_position).normalized()
	
	return {
		"damage": damage,
		"knockback": direction
	}
