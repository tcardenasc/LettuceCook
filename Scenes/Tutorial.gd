extends Control

@onready var image = $TextureReact
@onready var page_label = $SlideNumber
@onready var description_label = $Description

var images = []

var descriptions = ["Welcome to Beast Brigade! In this tutorial we will teach you everything you need to know to play this game, don't worry is very simple!",
					"Controls: Click LMB to throw a punch to the face of your enemies!.
					Click RMB to throw a lettuce to heal your pets and deal damage to your foes (is still
					a lettuce though...).
					Move your character using WASD, and that is all the controls, simple right?.",
					
					"Enemies and capture: You will be faced against multiple enemies, that when defeated will drop gems for you to collect.
					If the enemy don't dissaper and insted glows then that means you can capture it, throw a lettuce at it and watch it become your friend.
					You can invoke the beasts captured, they will defend you and defeat your foes!.",
					
					"Interface: Pay attention to your health, if it reaches 0 you lose!, you can check the number of gems you have, make sure to pick them all!.
					The inventory shows the beasts you have captured so far (and the lettuce you have picked).
					Press the 1 to 9 keys to invoke the beast shown or throw the lettuce"]

var curr_slide = 0

var n_slides = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_images(loaded_images):
	images = loaded_images
	update_image()

func update_image():
	
	image.texture = images[curr_slide]
	
	description_label.text = descriptions[curr_slide]
	
	page_label.text = "%d of %d" % [curr_slide + 1, images.size()]
	

func _on_next_pressed():
	$ButtonPressSound.play()
	if curr_slide < images.size() - 1:
		curr_slide += 1
		update_image()
		
	pass # Replace with function body.


func _on_next_mouse_entered():
	$ButtonPressSound.play()
	pass # Replace with function body.


func _on_previous_pressed():
	$ButtonPressSound.play()
	if curr_slide > 0:
		curr_slide -= 1
		update_image()
		
	pass # Replace with function body.


func _on_previous_mouse_exited():
	$ButtonHoverSound.play()
	pass # Replace with function body.


func _on_exit_pressed():
	$ButtonPressSound.play()
	hide()
	curr_slide = 0
	update_image()
	pass # Replace with function body.


func _on_exit_mouse_entered():
	$ButtonHoverSound.play()
	pass # Replace with function body.


func _on_previous_mouse_entered():
	$ButtonHoverSound.play()
	pass # Replace with function body.
