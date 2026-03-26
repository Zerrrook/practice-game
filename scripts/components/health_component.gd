class_name HealthComponent
extends Node2D

signal died
@export var max_health : int
var health : int

func _ready():
	health = max_health
	print(get_parent().name + " has: " + str(health) + " health")
	
func damage_taken(damage):
	health -= damage
	print(get_parent().name + " has: " + str(health) + " health")
	
	if health <= 0:
		died.emit()
		
