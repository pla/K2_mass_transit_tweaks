local util = require("__core__.lualib.util")

local recipe = data.raw.recipe
local technology = data.raw.technology
-- levels abfragen
local crawlertrain_tier_amount = settings.startup["angels-crawlertrain-tier-amount"].value
local smeltingtrain_tier_amount = settings.startup["angels-smeltingtrain-tier-amount"].value
local petrotrain_tier_amount = settings.startup["angels-petrotrain-tier-amount"].value
--[[
  kr-nuclear-locomotive
  crawler-locomotive
  crawler-locomotive-2
  crawler-locomotive-wagon
  petro-locomotive-1
  petro-locomotive-1-2
  smelting-locomotive-1
  smelting-locomotive-tender
  smelting-locomotive-tender-3
  smelting-locomotive-1-3
cargo-wagon
]]
--get source
local source_loco = data.raw["locomotive"]["kr-nuclear-locomotive"]
local fusion_fuel = data.raw["fuel-category"]["fusion"]
local antimatter_fuel = data.raw["fuel-category"]["antimatter"]

local nuclear_burner = source_loco.burner
local fusion_burner = util.table.deepcopy(nuclear_burner) --[[@as LuaBurnerPrototype]]
fusion_burner.fuel_category = "fusion-fuel"
local antimatter_burner = util.table.deepcopy(nuclear_burner) --[[@as LuaBurnerPrototype]]
antimatter_burner.fuel_category = "antimatter-fuel"

--edit angels
local locomotives = {
  -- crawlertrain_tier_amount >= 1 and "crawler-locomtive" or nil,
  crawlertrain_tier_amount >= 2 and "crawler-locomotive-2" or nil,
  crawlertrain_tier_amount >= 3 and "crawler-locomotive-3" or nil,
  crawlertrain_tier_amount >= 4 and "crawler-locomotive-4" or nil,
  crawlertrain_tier_amount >= 5 and "crawler-locomotive-5" or nil,

  -- crawlertrain_tier_amount >= 1 and "crawler-locomotive-wagon" or nil,
  crawlertrain_tier_amount >= 2 and "crawler-locomotive-wagon-2" or nil,
  crawlertrain_tier_amount >= 3 and "crawler-locomotive-wagon-3" or nil,
  crawlertrain_tier_amount >= 4 and "crawler-locomotive-wagon-4" or nil,
  crawlertrain_tier_amount >= 5 and "crawler-locomotive-wagon-5" or nil,

  -- smeltingtrain_tier_amount >= 1 and "smelting-locomotive-1" or nil,
  smeltingtrain_tier_amount >= 2 and "smelting-locomotive-1-2" or nil,
  smeltingtrain_tier_amount >= 3 and "smelting-locomotive-1-3" or nil,
  smeltingtrain_tier_amount >= 4 and "smelting-locomotive-1-4" or nil,
  smeltingtrain_tier_amount >= 5 and "smelting-locomotive-1-5" or nil,

  -- smeltingtrain_tier_amount >= 1 and "smelting-locomotive-tender" or nil,
  smeltingtrain_tier_amount >= 2 and "smelting-locomotive-tender-2" or nil,
  smeltingtrain_tier_amount >= 3 and "smelting-locomotive-tender-3" or nil,
  smeltingtrain_tier_amount >= 4 and "smelting-locomotive-tender-4" or nil,
  smeltingtrain_tier_amount >= 5 and "smelting-locomotive-tender-5" or nil,

  -- petrotrain_tier_amount >= 1 and "petro-locomotive-1" or nil,
  petrotrain_tier_amount >= 2 and "petro-locomotive-1-2" or nil,
  petrotrain_tier_amount >= 3 and "petro-locomotive-1-3" or nil,
  petrotrain_tier_amount >= 4 and "petro-locomotive-1-4" or nil,
  petrotrain_tier_amount >= 5 and "petro-locomotive-1-5" or nil,
}

for _, prototype in pairs(locomotives) do
  local loco = data.raw["locomotive"][prototype]
  if string.sub(prototype, -1) == "2" then
    -- insert nuclear energy source
    loco.burner = nuclear_burner
    loco.weight = source_loco.weight
    loco.max_power = "3MW"
    loco.braking_force = loco.braking_force + 2
    table.insert(recipe[loco.name].ingredients, { "electronic-components", 200 })
  elseif string.sub(prototype, -1) == "3" then
    -- insert fusion energy source
    loco.burner = fusion_burner
    loco.weight = loco.weight + 10000
    loco.max_power = "4MW"
    loco.braking_force = loco.braking_force + 3
    table.insert(recipe[loco.name].ingredients, { "fusion-reactor-equipment", 1 })
  elseif string.sub(prototype, -1) == "4" then
    -- inser antimatter energy source
    loco.burner = antimatter_burner
    loco.weight = loco.weight + 10000
    loco.max_power = "6MW"
    loco.braking_force = loco.braking_force + 5
    table.insert(recipe[loco.name].ingredients, { "antimatter-reactor-equipment", 1 })
  elseif string.sub(prototype, -1) == "5" then
    -- inser antimatter energy source
    loco.burner = antimatter_burner
    loco.weight = loco.weight + 10000
    loco.max_power = "6MW"
    loco.braking_force = loco.braking_force + 6
    table.insert(recipe[loco.name].ingredients, { "antimatter-reactor-equipment", 2 })
  end
  data.raw["locomotive"][prototype] = loco
end

-- Adjust technologies
--[[
  angels-crawler-train
  angels-petro-train
  angels-smelting-train

  kr-nuclear-locomotive

]]
local angel_techs = {
  crawlertrain_tier_amount >= 1 and "angels-crawler-train" or nil,
  crawlertrain_tier_amount >= 2 and "angels-crawler-train-2" or nil,
  crawlertrain_tier_amount >= 3 and "angels-crawler-train-3" or nil,
  crawlertrain_tier_amount >= 4 and "angels-crawler-train-4" or nil,
  crawlertrain_tier_amount >= 5 and "angels-crawler-train-5" or nil,
  smeltingtrain_tier_amount >= 1 and "angels-smelting-train" or nil,
  smeltingtrain_tier_amount >= 2 and "angels-smelting-train-2" or nil,
  smeltingtrain_tier_amount >= 3 and "angels-smelting-train-3" or nil,
  smeltingtrain_tier_amount >= 4 and "angels-smelting-train-4" or nil,
  smeltingtrain_tier_amount >= 5 and "angels-smelting-train-5" or nil,
  petrotrain_tier_amount >= 1 and "angels-petro-train" or nil,
  petrotrain_tier_amount >= 2 and "angels-petro-train-2" or nil,
  petrotrain_tier_amount >= 3 and "angels-petro-train-3" or nil,
  petrotrain_tier_amount >= 4 and "angels-petro-train-4" or nil,
  petrotrain_tier_amount >= 5 and "angels-petro-train-5" or nil,

}--
-- adjust ingredients
for _, tech_name in pairs(angel_techs) do
  if string.sub(tech_name, -1) == "2" then
    table.insert(technology[tech_name].prerequisites, "kr-nuclear-locomotive")
    technology[tech_name].unit.ingredients =
        util.table.deepcopy(technology["nuclear-power"].unit.ingredients)
    table.insert(technology[tech_name].unit.ingredients, { "production-science-pack", 1 })
  elseif string.sub(tech_name, -1) == "3" then
    table.insert(technology[tech_name].prerequisites, "fusion-reactor-equipment")
    technology[tech_name].unit.ingredients =
        util.table.deepcopy(technology["fusion-reactor-equipment"].unit.ingredients)
  elseif string.sub(tech_name, -1) == "4" then
    table.insert(technology[tech_name].prerequisites, "kr-antimatter-reactor-equipment")
    technology[tech_name].unit.ingredients =
        util.table.deepcopy(technology["kr-antimatter-reactor-equipment"].unit.ingredients)
  elseif string.sub(tech_name, -1) == "5" then
    table.insert(technology[tech_name].prerequisites, "kr-antimatter-reactor-equipment")
    technology[tech_name].unit.ingredients =
        util.table.deepcopy(technology["kr-antimatter-reactor-equipment"].unit.ingredients)
  end
end

-- adjust recipes

-- adjust wagons inventory_size
--todo  setting anlegen
local option1 = { 20, 30, 40, 50, 60 }
local option2 = { 40, 45, 50, 55, 60 }
local option
if settings.startup["K2AMT-cargo-wagon-size"].value == "Option 1" then
  option = option1
elseif settings.startup["K2AMT-cargo-wagon-size"].value == "Option 2" then
  option = option2
end


local tankers = {
  petrotrain_tier_amount >= 1 and "petro-tank1" or nil,
  petrotrain_tier_amount >= 2 and "petro-tank1-2" or nil,
  petrotrain_tier_amount >= 3 and "petro-tank1-3" or nil,
  petrotrain_tier_amount >= 4 and "petro-tank1-4" or nil,
  petrotrain_tier_amount >= 5 and "petro-tank1-5" or nil,
  petrotrain_tier_amount >= 1 and "petro-tank2" or nil,
  petrotrain_tier_amount >= 2 and "petro-tank2-2" or nil,
  petrotrain_tier_amount >= 3 and "petro-tank2-3" or nil,
  petrotrain_tier_amount >= 4 and "petro-tank2-4" or nil,
  petrotrain_tier_amount >= 5 and "petro-tank2-5" or nil,
}
local wagons = {

  smeltingtrain_tier_amount >= 1 and "smelting-wagon-1" or nil,
  smeltingtrain_tier_amount >= 2 and "smelting-wagon-1-2" or nil,
  smeltingtrain_tier_amount >= 3 and "smelting-wagon-1-3" or nil,
  smeltingtrain_tier_amount >= 4 and "smelting-wagon-1-4" or nil,
  smeltingtrain_tier_amount >= 5 and "smelting-wagon-1-5" or nil,
  crawlertrain_tier_amount >= 1 and "crawler-wagon" or nil,
  crawlertrain_tier_amount >= 2 and "crawler-wagon-2" or nil,
  crawlertrain_tier_amount >= 3 and "crawler-wagon-3" or nil,
  crawlertrain_tier_amount >= 4 and "crawler-wagon-4" or nil,
  crawlertrain_tier_amount >= 5 and "crawler-wagon-5" or nil,
  crawlertrain_tier_amount >= 1 and "crawler-bot-wagon" or nil,
  crawlertrain_tier_amount >= 2 and "crawler-bot-wagon-2" or nil,
  crawlertrain_tier_amount >= 3 and "crawler-bot-wagon-3" or nil,
  crawlertrain_tier_amount >= 4 and "crawler-bot-wagon-4" or nil,
  crawlertrain_tier_amount >= 5 and "crawler-bot-wagon-5" or nil,
}

if option~=nil then
  for key, prototype in pairs(wagons) do
    local wagon = data.raw["cargo-wagon"][prototype]
    if string.sub(prototype, -1) == "2" then
      wagon.inventory_size=option[2]
    elseif string.sub(prototype, -1) == "3" then
      wagon.inventory_size=option[3]
    elseif string.sub(prototype, -1) == "4" then
      wagon.inventory_size=option[4]
    elseif string.sub(prototype, -1) == "5" then
      wagon.inventory_size=option[5]
    else
      wagon.inventory_size=option[1]
    end
  end
end