extends CharacterBody3D

@onready var camera = $Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()
var gravity = 850
@export var speed: float = 10.0
var value = 2
var getPos = Vector3()
var movement_mouse = Vector3()
var mouse_position = Vector2()

var target_velocity = Vector3.ZERO

const ZOOM_SPEED = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$NumberLabel.text = str(value)
	getPos = self.position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Zoom_UP") and not camera.position.y == 15:
		camera.position.y -= ZOOM_SPEED
	if Input.is_action_just_released("Zoom_Down") and not camera.position.y == 60:
		camera.position.y += ZOOM_SPEED
		
	#if zoom_in == true :
		#camera.position.y = lerp(camera.position.y, camera.position.y - Vector3(0,15,0), ZOOM_SPEED)
		#await get_tree().create_timer(0.10).timeout
		#zoom_in = false
	
	#if zoom_out == true :
		#camera.position.y = lerp(camera.position.y, camera.position.y + Vector3(0,60,0), ZOOM_SPEED)
		#await get_tree().create_timer(0.10).timeout
		#zoom_out = false
	
func _physics_process(delta):
	if Global.player_collided_with_enemy:
		Global.player_position = self.position
	if Global.food_collided_with_player == true:
		$AudioStreamPlayer3D.play()
		value += Global.score
		Global.food_collided_with_player = false
		#self.scale = Vector3(scale.x + (value/1000), scale.x + (value/1000), scale.x + (value/1000))
		#print(self.scale)
	if Global.player_eat_enemy:
		Global.eaten_enemy += 1
		$AudioStreamPlayer3D.play()
		value += Global.enemy_score
		Global.player_eat_enemy = false
		
	if Global.enemy_eat_player:
		Global.enemy_eat_player = false
		await get_tree().create_timer(5.0).timeout
		self.position = Vector3.ZERO
		#queue_free()
	
	Global.overall_player_score = value
	$NumberLabel.text = str(value)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		#print(is_on_floor())
	
	if position.y < -20:
		await get_tree().create_timer(0.5).timeout
		self.position = Vector3.ZERO
	
	
	
		#position += Vector3(pos.x, 0, pos.z)
		
	#position += Vector3(movement_mouse.x, 0, movement_mouse.y)
	if Global.change_controller:
		var direction = Vector3.ZERO

		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_back"):
			direction.z += 1
		if Input.is_action_pressed("move_forward"):
			direction.z -= 1

		if direction != Vector3.ZERO:
			direction = direction.normalized()
			$MeshInstance3D.basis = Basis.looking_at(direction)

		# Ground Velocity
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed

		# Moving the Character
		velocity = target_velocity
	else:
		var space_state = get_world_3d().direct_space_state
		mouse_position = get_viewport().get_mouse_position()
		movement_mouse = mouse_position

		rayOrigin = camera.project_ray_origin(mouse_position)
		
		rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
		var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		var intersection = space_state.intersect_ray(query)
		
		if not intersection.is_empty():
			var pos = intersection.position
			$MeshInstance3D.look_at(Vector3(pos.x, position.y, pos.z), Vector3(0,1,0))
		
		position = position.move_toward(Vector3(movement_mouse.x,0,movement_mouse.y), delta * speed)
	#velocity = Vector3(mouse_position.x * speed, 0, mouse_position.y * speed)
	#print(movement_mouse)
	move_and_slide()


func _on_area_3d_body_entered(body):
	pass # Replace with function body.

func player():
	pass
