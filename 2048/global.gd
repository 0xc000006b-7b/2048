extends Node

var food_pos_array : Array
var enemy_name_array : Array
var enemy_name_array_count = 0
var score = 0
var food_collided_with_player = false
var food_collided_with_enemy = false
var player_collided_with_enemy = false
var enemy_entered_food = false
var player_eat_enemy = false
var enemy_eat_player = false
var change_controller = false
var food_population = 10
var enemy_population = 5
var eaten_enemy = 0
var eaten = 0
var overall_player_score = 0
var enemy_score = 0
var food_position = Vector3()
var player_position = Vector3()


var defeat = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
