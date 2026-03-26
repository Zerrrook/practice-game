class_name KnockbackComponent
extends Node2D

@export var body : CharacterBody2D

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0.0

func apply_knockback(direction: Vector2, force: float, knockback_duration : float):
	knockback = direction * force
	knockback_timer = knockback_duration

func process_knockback(delta):
	if body:
		if knockback_timer > 0.0:
			body.velocity = knockback
			knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
