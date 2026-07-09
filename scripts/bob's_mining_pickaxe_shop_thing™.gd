extends Node2D

var toggle := 0
@onready var sbutton = get_node("/root/")


signal showshop
signal closeshop

func _ready() -> void:
	modulate.a = 0
	print(sbutton)


func _on_showshop() -> void:
	if toggle == 0:
		var t = get_tree().create_tween()
		t.tween_property(self, "modulate:a", 1, 0.2)
	toggle += 1
	if visible == true:
		print("visible")
		


func _on_closeshop() -> void:
	var tree = get_tree()
	if toggle == 1 && tree != null:
		print("toggle is on 1")
		var t = tree.create_tween()
		t.tween_property(self, "modulate:a", 0, 0.2)
		toggle = 0
		
		
