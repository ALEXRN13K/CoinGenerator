extends Node2D


const rebirth_cost_multiplier := 2.2
var rebirth_cost := 100000
@export var rebirths := 0

@onready var coin_node = get_node("/root/Game")
@onready var worm = get_node("/root/Game/UI/Worm")
@onready var red_worm = get_node("/root/Game/UI/Red Worm")
@onready var leaf_worm = get_node("/root/Game/UI/Leaf Worm")
@onready var archangel_worm = get_node("/root/Game/UI/Archangel Worm")
@onready var rebirth_menu = get_node("/root/R Button/Area2D/Rebirth Menu")

func _on_leave_pressed() -> void:
	hide()
	

func _on_buy_rebirth_pressed() -> void:
	if coin_node.coins >= rebirth_cost:
		
		coin_node.emit_signal("reset_multiplier")
		worm.emit_signal("reset")
		red_worm.emit_signal("reset")
		leaf_worm.emit_signal("reset")
		rebirth_cost *= rebirth_cost_multiplier
		$"Rebirth Cost".text = "Rebirth Cost: " + str(rebirth_cost)
		coin_node.coins - 100
		coin_node.emit_signal("redraw_coins", 0)
		rebirths += 1
		$Rebirths.text = "Rebirths: " + str(rebirths)
		print(rebirths)
		hide()
		if rebirths >= 5:
			archangel_worm.emit_signal("show_archangel_worm")
			
			
		
		



func _on_show_archangel_worm() -> void:
	archangel_worm.archangel_worm.hide()
