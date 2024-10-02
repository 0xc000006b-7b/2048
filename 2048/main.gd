extends Node3D


@onready var food_scene = preload("res://food.tscn")
@onready var enemy_scene = preload("res://enemy.tscn")
@onready var game_over_scene = preload("res://game_over.tscn")
var food_array : Array
var array_range = 10
var enemy_array : Array
var enemy_array_range = 5

var game_over
# Called when the node enters the scene tree for the first time.
func _ready():
	#Food Instances
	for i in range(array_range):
		
		var food = food_scene.instantiate()
		var food_spawn_location = get_node("Path3D/PathFollow3D")
		#food_spawn_location.progress_ratio = randf()
		food.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
		food_array.insert(i, food)
		Global.food_pos_array.insert(i, food.position)
		#var player_position = $Player.position
		#food.initialize(food_spawn_location.position, player_position)
		add_child(food_array[i])
	#Enemy Instances
	for i in range(enemy_array_range):
		
		var enemy = enemy_scene.instantiate()
		var food_spawn_location = get_node("Path3D/PathFollow3D")
		#food_spawn_location.progress_ratio = randf()
		enemy.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
		enemy_array.insert(i, enemy)
		Global.enemy_name_array.insert(i, "enemy" + str(i))
		Global.enemy_name_array_count = i
		#var player_position = $Player.position
		#food.initialize(food_spawn_location.position, player_position)
		add_child(enemy_array[i])
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if Global.enemy_eat_player:
		#get_tree().paused = true
		#get_tree().reload_current_scene()
		#$GameOver.show()
	
	if Global.defeat:
		game_over = game_over_scene.instantiate()
		add_child(game_over)
		get_tree().paused = true
		
	
	
	if Input.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://hud.tscn")
	
	if Global.enemy_population < 1:
		for i in range(Global.eaten_enemy):
			var enemy = enemy_scene.instantiate()
			enemy.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
			enemy_array.insert(i, enemy)
			add_child(enemy_array[i])
			Global.enemy_population += Global.eaten_enemy
			Global.eaten_enemy = 0
			
	if Global.food_population < 5:
		for i in range(Global.eaten):
			var food = food_scene.instantiate()
			#food_spawn_location.progress_ratio = randf()
			food.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
			food_array.insert(i, food)
			Global.food_pos_array.insert(i, food.position)
			#var player_position = $Player.position
			#food.initialize(food_spawn_location.position, player_position)
			add_child(food_array[i])
			Global.food_population += Global.eaten
			Global.eaten = 0
			print(food.position)
	


func _on_timer_timeout():
	pass
