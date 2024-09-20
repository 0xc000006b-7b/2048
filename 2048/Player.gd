extends CharacterBody3D

@onready var camera = $Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()
var gravity = 850
var speed = 5.0
var value = 2
var getPos = Vector3()
var movement_mouse = Vector3()
# Called when the node enters the scene tree for the first time.
func _ready():
	$NumberLabel.text = str(value)
	getPos = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Global.player_collided_with_enemy:
		Global.player_position = self.position
	if Global.food_collided_with_player == true:
		$AudioStreamPlayer3D.play()
		value += Global.score
		Global.food_collided_with_player = false
		#self.scale = Vector3(scale.x + (value/1000), scale.x + (value/1000), scale.x + (value/1000))
		#print(self.scale)
	
	$NumberLabel.text = str(value)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		#print(is_on_floor())
	
	var space_state = get_world_3d().direct_space_state
	
	var mouse_position = get_viewport().get_mouse_position()
	movement_mouse = mouse_position
	movement_mouse = Vector3(mouse_position.x - getPos.x, 0, mouse_position.y - getPos.z)
	movement_mouse = mouse_position.normalized() * delta * speed
	
	
	rayOrigin = camera.project_ray_origin(mouse_position)
	
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		$MeshInstance3D.look_at(Vector3(pos.x, position.y, pos.z), Vector3(0,1,0))
		#position += Vector3(pos.x, 0, pos.z)
		
	position += Vector3(movement_mouse.x, 0, movement_mouse.y)
	#position = position.move_toward(Vector3(movement_mouse.x,0,movement_mouse.y), delta * speed)
	#velocity = Vector3(mouse_position.x * speed, 0, mouse_position.y * speed)
	#print(get_viewport().get_mouse_position())
	move_and_slide()


func _on_area_3d_body_entered(body):
	pass # Replace with function body.
