extends Node

var _fallback_position := Vector2.ZERO
var _checkpoint_position := Vector2.ZERO

var fallback_position : Vector2:
	get():
		return _fallback_position
	set(pos):
		_fallback_position = pos
		print("Fallback point set to: ", pos)

var checkpoint_position : Vector2:
	get():
		return _checkpoint_position
	set(pos):
		_checkpoint_position = pos
		print("Checkpoint set to: ", pos)
