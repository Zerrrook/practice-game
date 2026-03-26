class_name HurtboxComponent
extends Area2D

signal hit(hit_data)

func _on_area_entered(area: Area2D) -> void:
	
#	looks for the "get_hit_data" function from the hitbox component
	if area.has_method("get_hit_data"):
		var data = area.get_hit_data(global_position)
		hit.emit(data)
	
	
