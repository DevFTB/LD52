extends TextureRect

var active_page = 0
@onready var amount_of_pages = $Info/Pages.get_child_count()
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Combat.tscn")
	pass # Replace with function body.


func _on_info_button_pressed():
	$Info.visible = true
	active_page = 0
	$Info/LeftButton.visible = false
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_right_button_pressed():
	active_page += 1
	update_gui()
	
	pass # Replace with function body.

func update_gui():
	if active_page == 0:
		$Info/LeftButton.visible = false
	else:
		$Info/LeftButton.visible = true
	if active_page == amount_of_pages - 1:
		$Info/RightButton.visible = false
	else:
		$Info/RightButton.visible = true
	for page in range($Info.get_child_count()):
		$Info/Pages.get_child(page).visible = page == active_page
func _on_left_button_pressed():
	active_page -= 1
	update_gui()
	pass # Replace with function body.


func _on_texture_button_pressed():
	$Info.visible = false
	pass # Replace with function body.
