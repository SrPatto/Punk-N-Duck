extends Area2D

const PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")

@onready var drop_point_1: Marker2D = $DropPoint_1
@onready var drop_point_2: Marker2D = $DropPoint_2
@onready var throwing_point: Marker2D = $ThrowingPoint
@onready var timer_reload: Timer = $Timer_reload

var drop_points: Array[Marker2D] = [drop_point_1, drop_point_2]
var drop_point 
var drop_point_Position

func _ready() -> void:
	drop_point = drop_points.pick_random()

func _process(delta: float) -> void:
	if drop_point != null:
		drop_point_Position = drop_point.global.position

func throw():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.global_position = throwing_point.global_position
	projectile.direction = 0
	self.add_child(projectile)


func _on_timer_reload_timeout() -> void:
	throw()

func _on_body_entered(body: Node2D) -> void:
	$CollisionShape2D.disabled = true
	if body == Global.player:
		body.call_deferred("death")
