extends CharacterBody3D

@onready var camera = $Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()
var gravity = 850
var speed = 5.0
var value = 1
var getPos = Vector3()
# Called when the node enters the scene tree for the first time.
func _ready():
	$NumberLabel.text = str(value)
	getPos = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var vec = get_viewport().get_mouse_position() - self.position # getting the vector from self to the mouse
	#vec = vec.normalized() * delta * speed # normalize it and multiply by time and speed
	#position += vec # move by that vector
	pass
	
func _physics_process(delta):
	
	if Global.collided == true:
		$AudioStreamPlayer3D.play()
		value += Global.score
		Global.collided = false
	
	$NumberLabel.text = str(value)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		print(is_on_floor())
	
	var space_state = get_world_3d().direct_space_state
	
	var mouse_position = get_viewport().get_mouse_position()
	var movement_mouse = mouse_position
	movement_mouse = Vector3(mouse_position.x - getPos.x, 0, mouse_position.y - getPos.z)
	movement_mouse = mouse_position.normalized() * delta * speed
	
	position += Vector3(movement_mouse.x, 0, movement_mouse.y)
	rayOrigin = camera.project_ray_origin(mouse_position)
	
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		#$MeshInstance3D.look_at(Vector3(pos.x, position.y, pos.z), Vector3(0,1,0))
	#velocity = Vector3(mouse_position.x * speed, 0, mouse_position.y * speed)
	print(position)
	move_and_slide()


func _on_area_3d_body_entered(body):
	pass # Replace with function body.
