local mapManager = {nbLevels=0}

local files = love.filesystem.getDirectoryItems("")
for k, v in ipairs(files) do
  if string.match(v, "level_") then
    local number
    if mapManager.nbLevels < 10 then
      number = string.sub(v, 7,7)
    elseif mapManager.nbLevels < 100 then
      number = string.sub(v, 7,8)
    elseif mapManager.nbLevels < 1000 then
      number = string.sub(v, 7,9)
    end
    number = tonumber(number)
    if number > mapManager.nbLevels then
      mapManager.nbLevels = number
    end
  end
end
print("Nombre de niveaux : " .. tostring(mapManager.nbLevels))
--

Map = {}

function mapManager.levelLoad(number)
  Map={}
  Crates.purge()
  EndPoints.purge()
  --
  Game.victory = false
  Player.moveCount = 0
  --
  local level = require("level_"..tostring(number))
  Map = {lig=#level, col=#level[1], w=64, h=64}
  local x = 0
  local y = 0
  local w = Map.w
  local h = Map.h
  --
  for l=1, Map.lig do
    Map[l]={}
    for c=1, Map.col do
      Map[l][c]={x=x,y=y,w=w,h=h,id=level[l][c]}
      local cell = Map[l][c]
      if cell.id == "p" then
        Player.lig = l
        Player.col = c
        cell.id = 0
      elseif cell.id == "c" then
        Crates.new(l,c)
        cell.id = 0
      elseif cell.id == "e" then
        EndPoints.new(l,c)
        cell.id = 0
      end
      --
      x=x+w
    end
    x=0
    y=y+h
  end
end
--

function mapManager.load()
  mapManager.levelLoad(Game.currentLevel)
  --
  mapManager.ground = love.graphics.newImage("Assets/Grounds/GroundGravel_Concrete.png")
  mapManager.wall = love.graphics.newImage("Assets/Walls/WallRound_Black.png")
end
--

function mapManager.update(dt)
end
--

function mapManager.draw()
  for l=1, #Map do
    for c=1, #Map[l] do
      local cell = Map[l][c]
      
      -- on dessine le ground quoi qu il arrive il faut un sol
      if mapManager.debug then
        love.graphics.rectangle("line", cell.x, cell.y, cell.w, cell.h)
      else
        love.graphics.draw(mapManager.ground, cell.x, cell.y)
      end

      -- si on a un mur alors on dessine le mur :
      if cell.id == 1 then
        if mapManager.debug then
          love.graphics.rectangle("fill", cell.x, cell.y, cell.w, cell.h)
        else
          love.graphics.draw(mapManager.wall, cell.x, cell.y)
        end
      end
      
    end
  end
end
--

return mapManager