extends Node

signal main_scene_loaded

var quests : Array = []
var current_index : int = 0
const REQUIRED_PUZZLE_ITEMS = ["Pz1", "Pz2", "Pz3", "Pz4"]
var collected_puzzle_items : Array[String] = []
var collected_puzzles : int = 0 
var items : Array = []
var has_puzzle : bool = false
