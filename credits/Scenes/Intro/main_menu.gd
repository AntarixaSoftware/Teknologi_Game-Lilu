class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var setting_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Setting_Button as Button
@onready var quit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Quit_Button as Button
@onready var setting_menu: SettingMenu = $Setting as SettingMenu
@onready var credits_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer
@onready var start_level = preload("res://credits/Scenes/main_scene.tscn") as PackedScene
@onready var credits = preload("res://credits/Scenes/Credits/GodotCredits.tscn") as PackedScene

func _ready():
	handle_connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_setting_pressed() -> void:
	margin_container.visible = false
	setting_menu.set_process(true)
	setting_menu.visible = true

func on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits)

func on_quit_pressed() -> void:
	get_tree().quit()

func on_exit_setting_menu() -> void:
	margin_container.visible = true
	setting_menu.visible = false

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	setting_button.button_down.connect(on_setting_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	quit_button.button_down.connect(on_quit_pressed)
	setting_menu.exit_setting_menu.connect(on_exit_setting_menu)
