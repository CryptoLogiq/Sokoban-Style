local game = {victory = false, currentLevel = 1}

function game.load()
  game.victory = false
  game.currentLevel = 1
end
--

function game.update(dt)
end
--

function game.draw()
  if game.victory then
    love.graphics.print("LEVEL SUCCES".."\n".."Move Count : "..tostring(Player.moveCount).."\n".."Press Enter to continue", 580, 40, 0, 2, 2)
  end
end
--

function game.keypressed(k, scan)
  if game.victory then
    if k == "enter" and game.currentLevel < MapManager.nbLevels then
      game.currentLevel = game.currentLevel + 1
      MapManager.levelLoad(game.currentLevel)
    else
      -- titre de fin, page de victoire, autres ?
    end
  elseif k == "escape" then
    love.event.quit()
  end
end
--

function game.mousepressed(x,y,button)
end
--

return game