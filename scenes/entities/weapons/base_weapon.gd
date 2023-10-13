extends Node2D
class_name Weapon
##Escena con la funcionalidad básica de un arma. A esta se le debe
##agregar un modo para mostrar la textura.
##
##damage: daño que hace cada bala al enemigo.
##cooldown: tiempo mínimo entre un disparo y otro

@export var damage : int
@export_range(0.01, 5.0) var cooldown : float = 1.0
var _can_shoot := true

var Shot = preload("res://scenes/entities/weapons/shot.tscn")


func _ready():
	$CooldownTimer.wait_time = cooldown


func shoot() -> bool:
	#TODO: Que cuando dispare se dibuje la trayectoria de la bala
	if not _can_shoot:
		return false
	
	#Generar el disparo
	var shot_instance := Shot.instantiate()
	shot_instance.shoot_direction = (get_global_mouse_position() - global_position).angle()
	shot_instance.global_position = global_position
	get_node("/root").get_children()[0].add_child(shot_instance)
	
	__apply_cooldown()
	
	return true


func __apply_cooldown() -> void:
	_can_shoot = false
	$CooldownTimer.start()
	

func _on_cooldown_timer_timeout() -> void:
	_can_shoot = true
