class_name SettingsMenu
extends Menu

@onready var _camera_invert_x: CheckBox = $"VBoxContainer/GridContainer/Camera Invert X"
@onready var _camera_invert_y: CheckBox = $"VBoxContainer/GridContainer/Camera Invert Y"
@onready var _volume: HSlider = $VBoxContainer/GridContainer/Volume
@onready var _close: Button = $VBoxContainer/Close

func _ready():
	# Set the settings value and connect the signals
	_camera_invert_x.toggled.connect(_on_camera_invert_x_toggled)
	_camera_invert_x.button_pressed = File.settings.camera_invert_x
	
	_camera_invert_y.toggled.connect(_on_camera_invert_x_toggled)
	_camera_invert_y.button_pressed = File.settings.camera_invert_y
	
	_volume.value_changed.connect(_on_volume_value_changed)
	_volume.value = File.settings.volume
	
	_close.pressed.connect(close)

func _on_camera_invert_x_toggled(toggled_on: bool):
	File.settings.camera_invert_x = toggled_on
	
func _on_camera_invert_y_toggled(toggled_on: bool):
	File.settings.camera_invert_y = toggled_on
	
func _on_volume_value_changed(value: float):
	File.settings.volume = value
	Music._set_linear_volume(value)
