extends Node2D

@onready var archangel_worm = get_node("/root/Game/UI/Archangel Worm")
@onready var m_button = get_node("/root/Game/UI/m_button")


func _ready():
	update_ui()
	check_unlocks()


func _on_leave_pressed():
	hide()


func _on_buy_rebirth_pressed():
	if GameManager.buy_rebirth():
		hide()
		update_ui()
		check_unlocks()


func update_ui():
	$"Rebirth Cost".text = "Rebirth Cost: " + str(GameManager.rebirth_cost)
	$Rebirths.text = "Rebirths: " + str(GameManager.rebirths)


func check_unlocks():

	if GameManager.archangel_worm_unlocked:
		archangel_worm.show()

	if GameManager.mines_unlocked:
		m_button.emit_signal("show_m_button")
