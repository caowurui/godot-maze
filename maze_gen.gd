extends TileMapLayer

var x = 9
var y = 5
var pos = Vector2i(0,0)
const road_pos = Vector2i(5,7)
const myUp = Vector2i(0,-1)
const myDown = Vector2i(0,1)
const myLeft = Vector2i(-1,0)
const myRight = Vector2i(1,0)

var maze = []

func _ready()->void:
	genetateMaze()
	updateMaze()



func genetateMaze()->void:
	initMaze()
	dfs(0,0)

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



func updateMaze()->void:
	set_cell(Vector2i(0,0),0,Vector2i(3,5))# 左上角
	set_cell(Vector2i(2*x,0),0,Vector2i(0,5))# 右上角
	set_cell(Vector2i(0,2*y),0,Vector2i(0,6))# 左下角
	set_cell(Vector2i(2*x,2*y),0,Vector2i(3,6))# 右下角
	
	var i:int
	var j:int
	# 正上方
	i=1
	while i<2*x:
		if i%2 == 0 and not_road(i,1):
			set_cell(Vector2i(i,0),0,Vector2i(2,7))
		else:
			set_cell(Vector2i(i,0),0,Vector2i(1,0))
		i+=1
	
	#正下方
	i=1
	while i<2*x:
		if i%2 == 0 and not_road(i,2*y-1):
			set_cell(Vector2i(i,2*y),0,Vector2i(1,7))
		else:
			set_cell(Vector2i(i,2*y),0,Vector2i(1,0))
		i+=1
	
	# 正左方
	i=1
	while i<2*y:
		if i%2 == 0 and not_road(1,i):
			set_cell(Vector2i(0,i),0,Vector2i(3,7))
		else:
			set_cell(Vector2i(0,i),0,Vector2i(3,2))
		i+=1
	
	# 正右方
	i=1
	while i<2*y:
		if i%2 == 0 and not_road(2*x-1,i):
			set_cell(Vector2i(2*x,i),0,Vector2i(0,7))
		else:
			set_cell(Vector2i(2*x,i),0,Vector2i(3,2))
		i+=1
	
	# 节点处
	i=1
	j=1
	while i<2*x:
		j=1
		while j<2*y:
			if not not_road(i,j):
				j+=1
				continue
			var state = not_road(i,j-1)*8+not_road(i,j+1)*4+not_road(i-1,j)*2+not_road(i+1,j)
			# state: 上下左右
			match state:
				0b0000:
					set_cell(Vector2i(i,j),0,Vector2i(3,0))
				0b0001:
					set_cell(Vector2i(i,j),0,Vector2i(0,0))
				0b0010:
					set_cell(Vector2i(i,j),0,Vector2i(2,0))
				0b0011:
					set_cell(Vector2i(i,j),0,Vector2i(1,0))
				0b0100:
					set_cell(Vector2i(i,j),0,Vector2i(3,1))
				0b0101:
					set_cell(Vector2i(i,j),0,Vector2i(3,5))
				0b0110:
					set_cell(Vector2i(i,j),0,Vector2i(0,5))
				0b0111:
					set_cell(Vector2i(i,j),0,Vector2i(2,7))
				0b1000:
					set_cell(Vector2i(i,j),0,Vector2i(3,3))
				0b1001:
					set_cell(Vector2i(i,j),0,Vector2i(0,6))
				0b1010:
					set_cell(Vector2i(i,j),0,Vector2i(3,6))
				0b1011:
					set_cell(Vector2i(i,j),0,Vector2i(1,7))
				0b1100:
					set_cell(Vector2i(i,j),0,Vector2i(3,2))
				0b1101:
					set_cell(Vector2i(i,j),0,Vector2i(3,7))
				0b1110:
					set_cell(Vector2i(i,j),0,Vector2i(0,7))
				0b1111:
					set_cell(Vector2i(i,j),0,Vector2i(4,7))
			j+=1
		i+=1

func not_road(tx:int,ty:int)->int:
	return 1 if get_cell_atlas_coords(Vector2i(tx,ty))!=road_pos else 0
