local bump = require "libs/bump"

local collisionManager = class("collisionManager")

function collisionManager:initialize(parent)
	self.game = parent
	self.world = bump.newWorld()
end

--add a physics component to the world
function collisionManager:addToWorld(comp)
	self.world:add(comp, comp.x, comp.y, comp.w, comp.h)
	return self.world
end

function collisionManager:update(dt)
	
	--for each physics component
	for i, phys in ipairs(self.world:getItems()) do
		--collide that thing
		if phys.col then
			self:collide(phys)
		end
		self.world:update(phys, phys.x, phys.y)
	end
	
end

function collisionManager:resetWorld()
	self.world = bump.newWorld()
end

function collisionManager:collide(e1)
	
	local entity = e1.parent
	local cols, len = self.world:queryRect(e1.x-4, e1.y-4, e1.w+8, e1.h+8)
	
	--all: a table of collisions.
	--stores the entity collided with, the collision direction, and the number of collisions
	--counter = 1 is a side collision; counter = 2 is a corner collision
	local all = {}
	
	local sideHit = false
	
	--for each entry in collideOrder:
	for q, cond in ipairs(e1.collideOrder) do
		
		for i, e2 in lume.ripairs(cols) do
			if e1 ~= e2 and cond(e2) then
				-- remove from queryRect collection
				table.remove(cols, i)
				
				local col = self:detectCollisions(e1, e2)
				if col ~= nil then
					all[#all+1] = col
					if col.counter == 1 then sideHit = true end
				end
			end
		end
		
		-- for each detected collision:
		for i, col in ipairs(all) do
			--ignore all corner collisions as long as there's at least one side collision
			if col.counter == 1 or sideHit == false then
				-- resolve collisions (hitSide)
				e1:hitSide(col.other, col.side)
			end
			-- call sideHit
			entity:notifyComponents("sideHit", col)
		end
		
	end
	
	--for remaining entities in queryRect:
	for i, e2 in ipairs(cols) do
		-- detect collisions
		local col = self:detectCollisions(e1, e2)
		if col ~= nil then
			all[#all+1] = col
		end
	end
	
	entity:notifyComponents("collisionDetected", all)

end

function collisionManager:detectCollisions(e1, e2)
	-- detect collisions w/other objects
	local other = nil; local side = nil; local counter = 0

	--find collision direction
	if e1.y+e1.h>e2.y and e1.y<e2.y+e2.h then --left/right
		if e1.px+e1.w-0.1 <= e2.px and e1.x+e1.w > e2.x then --left
			other = e2; side = "left"; counter = counter + 1
		end
		if e1.px+0.1 >= e2.px+e2.w and e1.x < e2.x+e2.w then --right
			other = e2; side = "right"; counter = counter + 1
		end
	end
	if e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then --up/down
		if e1.py+e1.h-0.1 <= e2.py and e1.y+e1.h > e2.y then --from above
			other = e2; side = "up"; counter = counter + 1
		end
		if e1.py+0.1 >= e2.py+e2.h and e1.y < e2.y+e2.h then --below
			other = e2; side = "down"; counter = counter + 1
		end
	end
	if other == nil and e1.y+e1.h>e2.y and e1.y<e2.y+e2.h and e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then
		--if they were already colliding last frame, it's an "in" collision
		other = e2; side = "in"
	end
	
	if other ~= nil then
		return {other=other, side=side, counter=counter}
	end
end

return collisionManager