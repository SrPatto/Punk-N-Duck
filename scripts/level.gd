extends Node2D

@export var modules: Array[PackedScene] = []
var amount = 10
var randomNumber = RandomNumberGenerator.new()
var offset = 528
var initModules = 0

func _ready() -> void:
	for n in amount:
		spawn_module(n*offset)

func spawn_module(n):
	if initModules > 4:
		randomNumber.randomize()
		var num = randomNumber.randi_range(0, modules.size()-1)
		var instance = modules[num].instantiate()
		instance.position.x = n
		add_child(instance)
	else:
		var instance = modules[0].instantiate()
		instance.position.x = n
		add_child(instance)
		initModules += 1
