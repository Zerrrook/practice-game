extends CharacterBody2D
class_name Player

var is_alive := true
var is_hurt := false
var dying := false
var direction := 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var knockback_component: KnockbackComponent = $KnockbackComponent

@onready var state_machine: Node = $FSM

# Player logic
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
# Player Component Hub
# Triggered when the health component emits the died signal
func _on_player_died():
	dying = true
	
func die():
	is_alive = false
	Engine.time_scale = 0.5
	animated_sprite.play("death")
	respawn()

func respawn():
	#respawn_timer.start()
	pass

func _on_respawn_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	
