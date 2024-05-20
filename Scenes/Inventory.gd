extends Control

@onready var healthLabel = $PlayerInformation/Health
@onready var gemLabel = $PlayerInformation/Gem

func _update_health(currentHealth):
	healthLabel.text = str(currentHealth)

func _update_gems(currentGems):
	gemLabel.text = str(currentGems)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
