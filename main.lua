
require("Globals")
--
Game = require("game")
Player = require("player")
Crates = require("crates")
EndPoints = require("endpoints")
MapManager = require("mapManager")
--
local key = ""

function love.load()
  Player.load()
  Crates.load()
  EndPoints.load()
  --
  MapManager.load()
  --
  Game.load()
end
--

function love.update(dt)
  Player.update(dt)
  Crates.update(dt)
  Game.victory = EndPoints.update(dt) -- condition de victoire rempli ?
  MapManager.update(dt)
  --
  Game.update(dt)
end
--

function love.draw()
  MapManager.draw()
  --
  EndPoints.draw()
  Crates.draw()
  --
  Player.draw()
  --
  Game.draw()
end
--

function love.keypressed(k, scan)
  Player.keypressed(k, scan)
  Game.keypressed(k, scan)
end
--

function love.mousepressed(x,y,button)
  Player.mousepressed(x,y,button)
  Game.mousepressed(x,y,button)
end
--
