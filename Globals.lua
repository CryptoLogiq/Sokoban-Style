function LoadImagesOf(pImgStyle)
  print("Chargement des images contenus dans le dossier [Assets/"..pImgStyle.."]")
  local imgs = {}
  local folder = "Assets/"..pImgStyle
  local files = love.filesystem.getDirectoryItems(folder)
  --
  print(#files, "fichiers trouvés")
  --
  for index, fichier in pairs(files) do
    local new = {file=fichier, data=love.graphics.newImage(folder.."/"..fichier)}
    new.w, new.h = new.data:getDimensions()
    --
    table.insert(imgs, new)
  end
  return imgs
end
--