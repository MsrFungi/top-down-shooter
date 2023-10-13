extends CharacterBody2D


@export var SPEED = 300.0
@export var weapon : Weapon

#las escenas de armas deben ser hijas de $Textures/HeadTorso/WeaponPosition
#para que se muestren de forma correcta.

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	$Textures/Legs/AnimationPlayer.speed_scale = 4.0


func _physics_process(delta):
	#Hacer que el personaje apunte hacia el mouse
	var player_to_mouse : Vector2 = (get_global_mouse_position() - global_position)
	$Textures.rotation = player_to_mouse.angle()
	#disparo
	if weapon and Input.is_action_pressed("ui_shot"):
		weapon.shoot()
		
	#movimiento del personaje
	var direction := Vector2()
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2(0, 0)
	
	var blend_position = (velocity.rotated(-player_to_mouse.angle())).normalized()
	
	$Textures/Legs/AnimationTree["parameters/blend_position"] = blend_position
	
	move_and_slide()
	
