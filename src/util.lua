--[[
__author__="Pichai Kankuekul"
__copyright__="Copyright 2017, XCompass Intelligence Ltd."
]]

local torch = require 'torch'
local struct = require 'struct'
local image = require 'image'

function saveByteTensor(file, tensor)
  f = io.open(file, 'w')

  dim = tensor:size():size()
  f:write(struct.pack('i', dim))
  for i = 1, dim do
    f:write(struct.pack('i', tensor:size()[i]))
  end

  storage = tensor:storage()
  for i = 1, storage:size() do
    do
      f:write(struct.pack('B', storage[i]))
    end
  end
  f:close()
end

function loadByteTensor(file)
  f = io.open(file, 'r')

  dim = struct.unpack('i', f:read(4))
  size = torch.LongStorage(dim)
  for i = 1, dim do
    size[i] = struct.unpack('i', f:read(4))
  end

  tensor = torch.ByteTensor(size)
  storage = tensor:storage()
  for i = 1, storage:size() do
    storage[i] = struct.unpack('B', f:read(1))
  end
  f:close()
  return tensor
end

function getBlackImage(w, h)
  img = image.lena()
  --assert(img:isContiguous() and img:dim()==3)
  img = image.scale(img, w, h)
  for j = 1, 3 do
    data = img[j]:data()
    for k = 1, w*h-1 do 
      data[k] = 0
    end
  end
  return img
end

function isNan(val)
  return val ~= val
end

function split(string, delimiter)
  delimiter = delimiter or "%S"
  ret = {}
  idx = 1
  for sub in string.gmatch(string, delimiter .. "+") do
    ret[idx] = sub
    idx = idx + 1
  end
  return ret
end

function dofilec(aFile)
  local ok, ret = pcall(paths.dofile, aFile)
  if not ok then
    ret = paths.dofile(aFile .. 'c')
  end
  return ret
end
