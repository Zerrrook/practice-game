extends Node
class_name State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent
func enter():
	pass

func exit():
	pass

func process_input(_event : InputEvent):
	pass

func process_physics(_delta: float):
	pass

func process_frame(_delta: float):
	pass

# Applies gravity and slide to states that need them
func apply_gravity_and_move(delta): 
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
