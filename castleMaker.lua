-- Clear board
forge.clear()

-- Soze vars
worldWidth = 10
worldHeight = 10
wallHeight = 3

-- Create plateau
for x = 0, worldWidth, 1 do 
	for z = 0, worldHeight, 1 do 
		forge.build("Bricks/plate_2x2", {x, 0, z}, {0, 0, 0})
	end
end

-- Wall Vars
lowerRandom =(wallHeight/2)
upperRandom = (wallHeight- wallHeight/5)
windowHeight = math.random( lowerRandom,upperRandom )
windowSize = {1.5, 1.5,1}
blockSize = {1,1,1}
windowYOffset = -0.2
skipNext = false
blockSize = {1,1,1}

-- Create outer walls
for y = 0, wallHeight, 1 do 
	for x = 0, worldWidth, 1 do 
		makeWindow = x%2 == 0

		-- Skipped windows
		if(y == wallHeight)	then
			blockSize = {1,0.6,1}
			skipNext = x%2 == 0
		end

		-- To prevent windows being built on edges
		nearCross =
			math.abs(x-worldWidth)<2 or 
			math.abs(y-worldWidth)<2 or
			(x<2 and y<2) 

		-- If no window, then block!
		if(not makeWindow or y != windowHeight or nearCross ) then			
			if( not skipNext ) then
				forge.build("Bricks/brick_1x2", {x, y, 0}, {0, 180, 0},blockSize)	
				forge.build("Bricks/brick_1x2", {x, y, worldWidth}, {0, 0, 0},blockSize)	
				forge.build("Bricks/brick_1x2", {worldWidth, y, x}, {0, 90, 0},blockSize)	
				forge.build("Bricks/brick_1x2", {0, y, x}, {0, -90, 0},blockSize)
			end
		else	
		-- Build window
			forge.build("Bricks/brickWindow_1x2%", {x, y+ windowYOffset, 0}, {0, 180, 0},windowSize)	
			forge.build("Bricks/brickWindow_1x2%", {x, y + windowYOffset , worldWidth}, {0, 0, 0},windowSize)	
			forge.build("Bricks/brickWindow_1x2%", {worldWidth, y+windowYOffset, x}, {0, 90, 0},windowSize)		
			forge.build("Bricks/brickWindow_1x2%", {0, y+ windowYOffset, x}, {0, -90, 0},windowSize)			
		end
	end
end