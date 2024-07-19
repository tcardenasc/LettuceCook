extends Control

@onready var credits_label = $ScrollContainer/VBoxContainer/RichTextLabel

var credits_text = ""

func _ready():
	load_credits()
	credits_label.bbcode_text = credits_text

func load_credits():
	var file = FileAccess.open("res://Creditos.txt", FileAccess.READ)
	if file:
		credits_text = file.get_as_text()
		file.close()
	else:
		push_error("Archivo de créditos no encontrado	.")


func _on_button_pressed():
	hide()
	$ButtonPressSound.play()
	pass # Replace with function body.


func _on_button_mouse_entered():
	$ButtonHoverSound.play()
	pass # Replace with function body.
