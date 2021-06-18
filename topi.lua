local component = require("component")
local event = require("event")
local computer = require("computer")
local gpu = component.gpu
local term = require("term")
 
local version = "1.0"
 
local h, w = gpu.getResolution()
 
API = require("buttonAPI")

local function base()
  gpu.setBackground(0x0000cc)
  gpu.fill(1,1,h,1," ")
  gpu.set((h / 2) - 5,1,"TopiGui v"..version)
  gpu.setBackground(0xcccccc)
  gpu.fill(1,2,h,w, " ")

  while true do
    gpu.setBackground(0x0000cc)
    memoryPercentage = computer.freeMemory() * 100 / computer.totalMemory()
    energyPercentage = computer.energy() * 100 / computer.maxEnergy()
    gpu.set(h / 1.25,1,"RAM: "..string.format(" %2.0f", memoryPercentage).." % Free")
    gpu.set(h / 1.1,1,"Energy: "..string.format(" %2.0f", energyPercentage).." % ") 
    os.sleep(1)
  end
end 

function API.fillTable()
  API.setTable("Exit", exit, 10,20,3,5)
  API.screen()
end

function getClick()
  local _, _, x, y = event.pull(1,touch)
  if x == nil or y == nil then
    local h, w = gpu.getResolution()
    gpu.set(h, w, ".")
    gpu.set(h, w, " ")
  else 
    API.checkxy(x,y)
  end
end

function tor()
  computer.shutdown()
end

base()
API.fillTable() 

while true do
  getClick()
end