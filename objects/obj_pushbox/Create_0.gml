// main vars
pos = new Position(x, y, 0.90, 0.97, self)

rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions(true)
	}
}

function apply_interaction(obj, dir) {
	with obj {
		switch (dir) {
			case Direction.None:
			case Direction.Down:
				// Adjust speed
				var new_speed = (pos.y_speed + other.pos.y_speed) / 2 * 0.95
				pos.y_speed = new_speed
				other.pos.y_speed = new_speed
			
				// Snap obj
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				pos.setPos(
					pos.point.getX(),
					other.pos.point.getY() - boxSize.h / 2 - objSize.h / 2 + 1
				)
			break
		
			case Direction.Up:
				// Adjust speed
				var new_speed = (pos.y_speed + other.pos.y_speed) / 2
				pos.y_speed = new_speed
				other.pos.y_speed = new_speed
			
				// Snap box
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				other.pos.setPos(
					other.pos.point.getX(),
					pos.point.getY() - boxSize.h / 2 - objSize.h / 2
				)
			break
		
			case Direction.Right:
				// Adjust speed
				var speed_change = pos.x_speed / 20
				pos.x_speed -= speed_change
				other.pos.x_speed += speed_change
			
				// Snap to box
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				pos.setPos(
					other.pos.point.getX() - boxSize.w / 2 - objSize.w / 2,
					pos.point.getY()
				)
			break
		
			case Direction.Left:
				// Adjust speed
				var speed_change = pos.x_speed / 20
				pos.x_speed -= speed_change
				other.pos.x_speed += speed_change
			
				// Snap to box
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				pos.setPos(
					other.pos.point.getX() + boxSize.w / 2 + objSize.w / 2,
					pos.point.getY()
				)
			break
		}
	}
}