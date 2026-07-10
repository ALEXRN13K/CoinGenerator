extends Node2D


@onready var archangel_worm = get_node("/root/Game/UI/Archangel Worm")
@onready var m_button = get_node("/root/Game/UI/m_button")


func _ready():

	GameManager.unlock_archangel.connect(unlock_archangel)
	GameManager.unlock_mines.connect(unlock_mines)

	update_ui()


func _on_leave_pressed():
	hide()


func _on_buy_rebirth_pressed():

	if GameManager.buy_rebirth():
		hide()
		update_ui()


func update_ui():

	$"Rebirth Cost".text = "Rebirth Cost: " + str(GameManager.rebirth_cost)
	$Rebirths.text = "Rebirths: " + str(GameManager.rebirths)


func unlock_archangel():

	archangel_worm.unlock_archangel_worm()


func unlock_mines():

	m_button.emit_signal("show_m_button")
