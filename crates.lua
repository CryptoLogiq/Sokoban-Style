local crates = {}

function crates.purge()
  for n=#crates, 1, -1 do
    table.remove(crates, n) -- purge des caisses
  end
end
--

function crates.new(l,c)
  local box = {lig=l, col=c, x=0, y=0, w=64, h=64, data=crates.imgdata, OnEndPoint=false}
  box.w, box.h = box.data:getDimensions()
  --
  box.x = (box.col-1) * Map.w
  box.y = (box.lig-1) * Map.h
  --
  box.x = box.x + ( (Map.w-box.w) /2 )
  box.y = box.y + ( (Map.h-box.h) /2 )
  table.insert(crates, box)
end
--

function crates.canMove(startL, startC, dir)
  local moveL = startL
  local moveC = startC
  local crate = nil
  --
  for k, v in ipairs(crates) do
    if v.lig == startL and v.col == startC then
      crate = v
      break
    end
  end
  --
  if crate then
    if dir == "up" then
      moveL = moveL - 1
    elseif dir == "down" then
      moveL = moveL + 1
    elseif dir == "left" then
      moveC = moveC - 1
    elseif dir == "right" then
      moveC = moveC + 1
    end
    -- y a t'il une autre caisse la ou on veut deplacer la caisse ?
    for k, v in ipairs(crates) do
      if v.lig == moveL and v.col == moveC then
        return false -- si c'est le cas on renvois que c est pas possible !
      end
    end
    --
    local cell = Map[moveL][moveC]
    --
    if cell.id == 0 then
      crate.lig = moveL
      crate.col = moveC
      --
      return true
    else
      return false
    end
    --
  else
    return true
  end
end
--

function crates.OnEndPoint(l, c)
  for n=1, #Crates do -- je parcours ttes les caisses
    local crate = Crates[n] -- ici pareil reference a une caisse

    if crate.lig == l and crate.col == c then -- je verifies si la caisse est dessus :
      return true -- si c'est le cas je renvois VRAI
    end

  end

  return false -- ici aucune caisse n'est presente sur le EndPoint
end
--

function crates.load()
  crates.imgdata = love.graphics.newImage("Assets/Crates/Crate_Brown.png")
end
--

function crates.update(dt)
  for n=1, #crates do
    local box = crates[n]
    local cell = Map[box.lig][box.col]
    box.x = cell.x
    box.y = cell.y
    --
    box.x = box.x + ( (Map.w-box.w) /2 )
    box.y = box.y + ( (Map.h-box.h) /2 )
    --
    box.OnEndPoint = EndPoints.UnderCrate(box.lig, box.col)
  end
end
--

function crates.draw()
  for n=1, #crates do
    local box = crates[n]
    --
    if box.OnEndPoint then
      love.graphics.setColor(0.25,1,0.25,1) -- Tonalité Verte (sous un endpoint)
    else
      love.graphics.setColor(1,1,1,1) -- normal (pas sous un endpoint)
    end
    --
    love.graphics.draw(box.data, box.x, box.y)
    --
    love.graphics.setColor(1,1,1,1) -- on remet la couleur standard pour les autres drawcalls
  end
end
--

return crates