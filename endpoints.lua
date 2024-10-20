local endpoints = {}

function endpoints.purge()
  for n=#endpoints, 1, -1 do
    table.remove(endpoints, n) -- purge des endpoints
  end
end
--

function endpoints.new(l,c)
  local boxpoint = {lig=l, col=c, x=0, y=0, w=64, h=64, data=endpoints.imgdata}
  boxpoint.w, boxpoint.h = boxpoint.data:getDimensions()
  --
  local cell = Map[boxpoint.lig][boxpoint.col]
  boxpoint.x = cell.x
  boxpoint.y = cell.y
  --
  boxpoint.x = boxpoint.x + ( (Map.w-boxpoint.w) /2 )
  boxpoint.y = boxpoint.y + ( (Map.h-boxpoint.h) /2 )
  --
  table.insert(endpoints, boxpoint)
end
--

function endpoints.UnderCrate(l, c)
  for n=1, #endpoints do -- je parcours ts les endpoints
    local boxpoint = endpoints[n] -- reference a un enpoint

    if boxpoint.lig == l and boxpoint.col == c then -- je verifies si le endpoint est dessous :
      return true -- si c'est le cas je renvois VRAI
    end

  end

  return false -- ici aucun endpoint n'est present sous la Caisse
end
--

function endpoints.load()
  endpoints.imgdata = love.graphics.newImage("Assets/EndPoints/EndPoint_Brown.png")
end
--

function endpoints.update(dt)
  local victory = true -- je mets la condition de victoire a vrai

  for n=1, #endpoints do -- je parcours ts les endpoints
    local boxpoint = endpoints[n] -- ici je fais uen reference au endpoint avec une var local pour simplifier le code
    if Crates.OnEndPoint(boxpoint.lig, boxpoint.col) == false then
      victory = false -- si un endpoint ne possede pas de caisse, je change la valeur de victory à faux !
    end
  end

  return victory -- renvois true ou false (true si la condition de victoire est rempli)
end
--

function endpoints.draw()
  for n=1, #endpoints do
    local boxpoint = endpoints[n]
    love.graphics.draw(boxpoint.data, boxpoint.x, boxpoint.y)
  end
end
--

return endpoints