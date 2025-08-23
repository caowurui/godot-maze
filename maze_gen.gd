extends TileMapLayer

var x = 9
var y = 5
var pos = Vector2i(0,0)
const wall_pos = Vector2i(0,0)
const road_pos = Vector2i(1,0)
const myUp = Vector2i(0,-1)
const myDown = Vector2i(0,1)
const myLeft = Vector2i(-1,0)
const myRight = Vector2i(1,0)

var maze = []

func initMaze()->void:
	for i in range(x):
		maze.append([])
		for j in range(y):
			maze[i].append(0)

func dfs(rx:int,ry:int)->void:
	var tmpArr = [1,2,3,4]
	# 1 for Up,2 for Down,3 for Left,4 for Right
	tmpArr.shuffle()
	maze[rx][ry]=1
	var myPos = Vector2i(2*rx+1,2*ry+1)
	for i in tmpArr:
		match i:
			1:
				if ry>0 and maze[rx][ry-1]==0:
					set_cell(myPos+myUp,0,road_pos)
					dfs(rx,ry-1)
			2:
				if ry<y-1 and maze[rx][ry+1]==0:
					set_cell(myPos+myDown,0,road_pos)
					dfs(rx,ry+1)
			3:
				if rx>0 and maze[rx-1][ry]==0:
					set_cell(myPos+myLeft,0,road_pos)
					dfs(rx-1,ry)
			4:
				if rx<x-1 and maze[rx+1][ry]==0:
					set_cell(myPos+myRight,0,road_pos)
					dfs(rx+1,ry)

func genetateMaze()->void:
	initMaze()
	dfs(0,0)

func _ready()->void:
	genetateMaze()
