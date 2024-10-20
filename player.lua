local player = {lig=1, col=1, currentAnim=3, moveCount=0}

local animDir = {left=1, right=3, down=5, up=8}

function player.load()
  player.anims = LoadImagesOf("Characters")
end
--

function player.update(dt)
  local cell = Map[player.lig][player.col]
  player.x = cell.x
  player.y = cell.y
  --
  local currentAnim = player.anims[player.currentAnim]
  --
  player.x = player.x + ( (Map.w-currentAnim.w) /2 )
  player.y = player.y + ( (Map.h-currentAnim.h) /2 )
end
--

function player.draw()
  -- player imgdata
  local currentAnim = player.anims[player.currentAnim]
  love.graphics.draw(currentAnim.data, player.x, player.y)

  -- move count
  if not Game.victory then
    love.graphics.print("Move Count : "..tostring(player.moveCount), 580, 20, 0, 2, 2)
  end
end
--

function player.keypressed(k, scan)
  if not Game.victory then

    local l = player.lig
    local c = player.col
    local move = false
    local dir = nil
    --
    if scan == "up" or scan == "w" or scan == "down" or scan == "s" or scan == "left" or scan == "a" or scan == "right" or scan == "d" then
      player.moveCount = player.moveCount + 1
    end
    --
    if scan == "up" or scan == "w" then
      if player.lig - 1 >= 1 then
        if Map[l-1][c].id == 0 then
          l = l - 1
          if Crates.canMove(l, c, "up") then
            move = true
            dir = "up"
          end
        end
      end
    end

    if scan == "down" or scan == "s" then
      if player.lig + 1 <= Map.lig then
        if Map[l+1][c].id == 0 then
          l = l + 1
          if Crates.canMove(l, c, "down") then
            move = true
            dir = "down"
          end
        end
      end
    end

    if scan == "left" or scan == "a" then
      if player.col - 1 >= 1 then
        if Map[l][c-1].id == 0 then
          c = c - 1
          if Crates.canMove(l, c, "left") then
            move = true
            dir = "left"
          end
        end
      end
    end

    if scan == "right" or scan == "d" then
      if player.col + 1 <= Map.col then
        if Map[l][c+1].id == 0 then
          c = c + 1
          if Crates.canMove(l, c, "right") then
            move = true
            dir = "right"
          end
        end
      end
    end
    --
    if move == true then
      player.lig = l
      player.col = c
      player.currentAnim = animDir[dir]
    end

  end
end
--

function player.mousepressed(x,y,button)
end
--

return player