extends Node3D

@export var food_scene: PackedScene
var food_array : Array
var array_range = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start()
	for i in range(array_range):
		
		var food = food_scene.instantiate()
		var food_spawn_location = get_node("Path3D/PathFollow3D")
		#food_spawn_location.progress_ratio = randf()
		food.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
		food_array.insert(i, food)
		#var player_position = $Player.position
		#food.initialize(food_spawn_location.position, player_position)
		add_child(food_array[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.food_population < 90:
		for i in range(Global.eaten):
			var food = food_scene.instantiate()
			#food_spawn_location.progress_ratio = randf()
			food.position = Vector3(randi_range(-50, 50),0, randi_range(-50, 50))
			food_array.insert(i, food)
			#var player_position = $Player.position
			#food.initialize(food_spawn_location.position, player_position)
			add_child(food_array[i])
			Global.food_population += Global.eaten
			Global.eaten = 0
			print(food.position)
	


func _on_timer_timeout():
	pass
