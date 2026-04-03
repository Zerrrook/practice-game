class_name HurtboxComponent
extends Area2D

# Hit_data = Has knockback
# Hazard_data = Has no knockback

signal hit(hit_data)
@export var parent : CharacterBody2D
func _on_area_entered(area: Area2D) -> void:
	if parent is Player:
		# looks for the "get_hit_data" function from the hitbox component
		if area.has_method("get_hit_data"):
			var data = area.get_hit_data(global_position)
			data["is_hazard"] = false
			hit.emit(data)
			
		# looks for the "get_hazard_data" function from the hazard component
		if area.has_method("get_hazard_data"):
			var hazard_data = area.get_hazard_data()
			hit.emit({"damage": hazard_data, "knockback_direction": Vector2.ZERO, "is_hazard": true})
