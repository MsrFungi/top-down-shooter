extends RayCast2D

const SHOT_DISTANCE = 1000

var shoot_direction : float #ángulo en radianes
# Called when the node enters the scene tree for the first time.
func _ready():
	#Se apunta el raycast hacia la dirección dada
	target_position = Vector2.from_angle(shoot_direction) * SHOT_DISTANCE
	var shot_point : Vector2 = target_position
	
	#Se dibuja una línea hasta donde impacte la bala o hasta la distancia máxima
	force_raycast_update()
	
	if is_colliding():
		#var collision = get_collider()
		shot_point = get_collision_point() - position
	$Line2D.set_point_position(0, Vector2.ZERO)
	$Line2D.set_point_position(1, shot_point)
	enabled = false
	
	#Tween de animación para la línea
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1,)
	tween.tween_callback(queue_free)
	
	
	
	
