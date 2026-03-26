extends Node
class_name State

signal state_transition (source_state: State, new_state_name: String, hit_data : Dictionary)
func Enter(_hit_data : Dictionary = {}):
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
