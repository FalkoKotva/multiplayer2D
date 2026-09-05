class_name Bullet
extends Node2D

const SPEED: int = 600

@onready var life_timer: Timer = $LifeTimer
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent

var direction: Vector2

func _ready() -> void:
	hit_box_component.hit_hurtbox.connect(_on_hit_hurtbox)
	life_timer.timeout.connect(_on_life_timer_timeout)

func _process(delta: float) -> void:
	global_position += direction * SPEED * delta

func start(new_direction: Vector2):
	direction = new_direction
	rotation = direction.angle()

func register_collision():
	queue_free()

func _on_life_timer_timeout():
	if is_multiplayer_authority():
		queue_free()

func _on_hit_hurtbox(_hurtbox_component: HurtBoxComponent):
	register_collision()
