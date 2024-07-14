extends Node2D
class_name DJ

func play_sound(stream: AudioStream, dB: int):
	var instance = AudioStreamPlayer.new()
	instance.volume_db=dB
	instance.stream=stream
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	instance.play()

func remove_node(instance: AudioStreamPlayer):
	instance.queue_free()

	
