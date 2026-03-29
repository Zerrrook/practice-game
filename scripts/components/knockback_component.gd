class_name KnockbackComponent
extends Node2D

@export var body : CharacterBody2D

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0.0
var is_knockback_active := false
func apply_knockback(direction: Vector2, force: float, knockback_duration : float):
	knockback = direction * force
	knockback_timer = knockback_duration
	is_knockback_active = true

func process_knockback(delta):
	if body:
		if knockback_timer > 0.0:
			body.velocity.x = knockback.x
			knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
			is_knockback_active = false
