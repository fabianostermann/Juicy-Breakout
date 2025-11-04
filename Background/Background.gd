extends ColorRect

@onready var HUD = get_node("/root/Game/HUD")
var c = 0

var tween : Tween = null

var colors = [
	Color(0.44, 0.226, 0.062, 1.0),	
	Color(0.36, 0.104, 0.36, 1.0),	
	Color(0.152, 0.172, 0.46, 1.0),	
	Color(0.119, 0.325, 0.34, 1.0),	
	Color(0.109, 0.32, 0.228, 1.0),	
]


func _ready():
	HUD.connect("changed", Callable(self, "_on_HUD_changed"))
	update_color()


func update_color():
	if HUD.color_background:
		tween = get_tree().create_tween()
		tween.tween_property(self, "color", colors[c], $Timer.wait_time-0.01).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	else:
		if tween:
			tween.stop()
		color = Color(0.2,0.2,0.2)

func _on_HUD_changed():
	update_color()


func _on_Timer_timeout():
	if HUD.color_background:
		c = wrapi(c+1, 0, colors.size())
		update_color()
