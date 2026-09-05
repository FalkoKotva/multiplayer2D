class_name HitBoxComponent
extends Area2D

signal hit_hurtbox(hirtbox_component: HurtBoxComponent)

var damage: int = 1

func register_hitbox_hit(hurtbox_component: HurtBoxComponent):
	hit_hurtbox.emit(hurtbox_component)
