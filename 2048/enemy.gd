extends RigidBody3D

var enemy_score = 2
var gravity = 850
var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyScoreLabel.text = str(enemy_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.food_collided_with_enemy:
		enemy_score += Global.enemy_score
		$EnemyScoreLabel.text = str(enemy_score)
		Global.food_collided_with_enemy = false
	#if not Global.player_collided_with_enemy:
		#position += Vector3(speed * delta, 0, speed * delta)
	#else:
		#position = position.move_toward(Global.player_position, delta * speed)
		#print(Global.player_position)
		
	if Global.player_collided_with_enemy:
		position = position.move_toward(Global.player_position, delta * speed)
	elif Global.player_collided_with_enemy and Global.enemy_entered_food:
		position = position.move_toward(Global.player_position, delta * speed)
	elif not Global.player_collided_with_enemy and Global.enemy_entered_food:
		position = position.move_toward(Global.food_position, delta * speed)
	else:
		position += Vector3(speed * delta, 0, speed * delta)
	
func _physics_process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.name.match("Player"):
		print("food")
		Global.player_collided_with_enemy = true
	else:
		Global.enemy_entered_food = true


func _on_area_3d_body_exited(body):
	Global.player_collided_with_enemy = false
