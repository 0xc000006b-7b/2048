extends RigidBody3D

var enemy_score = 2
var gravity = 850
var speed = 5
var unique_name = ""
var food_pos_array : Array[Vector3]
var count = 0
var another_enemy = false
var another_enemy_pos = Vector3()
var another_enemy_score = 0
var temp = Vector3()
var player_position = Vector3()
var player_entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	temp = Global.food_pos_array.pick_random()
	unique_name = Global.enemy_name_array[Global.enemy_name_array_count]
	print(unique_name)
	$EnemyScoreLabel.text = str(enemy_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$EnemyScoreLabel.text = str(enemy_score)
	
	#if position.distance_to(temp) <= 0:
		#temp = Global.food_pos_array.pick_random()
	"""for i in range(Global.food_pos_array.size()):
		if position.distance_to(Global.food_pos_array[i]) < 20:
			print(unique_name, " is close to ",Global.food_pos_array[i])
			temp = Global.food_pos_array[i]"""
			
	
	if not Global.food_pos_array.has(temp):
		temp = Global.food_pos_array.pick_random()
	
	if player_entered:
		if Global.overall_player_score < enemy_score:
			position = position.move_toward(Global.player_position, delta * speed)
		else:
			#if position.distance_to(Global.food_position) > 80:
			position = position.move_toward(temp, delta * speed)
			#print(unique_name, " following ", temp)
	#elif another_enemy:
		#if another_enemy_score < enemy_score:
			#position = position.move_toward(another_enemy_pos, delta * speed)
		#else:
			#position = position.move_toward(Global.food_position, delta * speed)
	else:
		position = position.move_toward(temp, delta * speed)
		#print(unique_name, " following ", temp)
	
		#if not Global.player_collided_with_enemy and not Global.enemy_entered_food and not another_enemy:
			#if position.x > 55 or position.x < -55 or position.z > 55 or position.z < -55:
				#position += Vector3(abs(speed) * delta, 0, abs(speed) * delta)
			#else:
				#position += Vector3(speed * delta, 0, speed * delta)
	
func _physics_process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.has_method('player'):
		print("I SEE PLAYER")
		player_entered = true
		Global.player_collided_with_enemy = true
	elif body.has_method('ping'):
		#if not food_pos_array.is_empty():
			#food_pos_array[0] = body.position
		Global.enemy_entered_food = true


func _on_area_3d_body_exited(body):
	#if body.has_method('ping'):
		#for i in range(count):
			#if food_pos_array.has(body.ping()):
				#food_pos_array.remove_at(i)
				#print(body.ping(), " at ", i, " is removed")
	if body.has_method('player'):
		Global.player_collided_with_enemy = false
		player_entered = false
	#elif body.has_method('i_am_enemy'):
		#another_enemy = false


func _on_player_collision_area_3d_body_entered(body):
	if body.has_method('player'):
		if Global.overall_player_score > enemy_score:
			Global.enemy_score = enemy_score
			Global.player_eat_enemy = true
			Global.enemy_population -= 1
			queue_free()
		elif Global.overall_player_score < enemy_score:
			enemy_score += Global.overall_player_score
			Global.enemy_eat_player = true
	elif body.has_method('ping'):
		if Global.food_pos_array.has(body.position):
			Global.food_pos_array.erase(body.position)
			Global.enemy_entered_food = false
		temp = Global.food_pos_array.pick_random()
		enemy_score += body.return_my_value()
		#Global.food_collided_with_enemy = true
		Global.food_population -= 1
		Global.eaten += 1
		body.self_destroy()
	
		
func return_my_score():
	return enemy_score
	
func add_another_enemy_score(score : int):
	enemy_score += score
	
func i_am_enemy():
	print("i_am_enemy method")
	
func destroy_self():
	queue_free()

func _on_player_collision_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.has_method('i_am_enemy'):
		
		#if another_enemy_score > enemy_score:
			#body.add_another_enemy_score(enemy_score)
			#print("hit")
			#queue_free()
		#else:
			#enemy_score += body.return_my_score()
			#body.destroy_self()
			#print("EEEEEEEEEEEE")
		
		#print(body_rid, " ", body, " ", body_shape_index, " ", local_shape_index, " ")
	pass


func _on_player_search_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.has_method('i_am_enemy'):
		#another_enemy = true
		#another_enemy_pos = body.position
		#another_enemy_score = body.return_my_score()
		#print("I SEE ENEMY")
	pass
