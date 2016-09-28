if GetObjectName(myHero) ~= "Skarner" then return end

require('OpenPredict')

print("SkarnerNation // By:Vikk")

local SkarnerE = {delay = 0.25, speed = 1500, width = 70, range = 1000} 

local SkarnerMenu = Menu("SkarnerNation", "SkarnerNation")
--Combo Menu
  SkarnerMenu:Menu("Combo", "Combo")
  SkarnerMenu.Combo:Boolean("useQ", "Use Q", true)
  SkarnerMenu.Combo:Boolean("useW", "Use W", true)
  SkarnerMenu.Combo:Boolean("useE", "Use E", true)
  SkarnerMenu.Combo:Boolean("useR", "Use R", true)
  OlafMenu.Combo:Boolean("useTiamat", "Use Tiamat", true)
  OlafMenu.Combo:Boolean("useHydra", "Use Ravenous Hydra", true)
  OlafMenu.Combo:Boolean("useTitanic", "Use Titanic Hydra", true)
-- Harass Menu
  SkarnerMenu:Menu("Harass", "Harass")
--Q
  SkarnerMenu.Combo:Boolean("useQ", "Use Q", true)   
  SkarnerMenu.Harass:Slider("manaQ","Mana-Manager | Q", 60, 0, 100, 1)
--W
  SkarnerMenu.Combo:Boolean("useW", "Use W", true) 
  SkarnerMenu.Harass:Slider("manaW","Mana-Manager | W", 40, 0, 100, 1)
--E
  SkarnerMenu.Combo:Boolean("useE", "Use E", true)
  SkarnerMenu.Harass:Slider("manaE","Mana-Manager | E", 20, 0, 100, 1) 
-- KillSteal Menu
  SkarnerMenu:Menu("KillSteal", "KillSteal")
  SkarnerMenu.KillSteal:Boolean("useE", "Use E", true)




OnTick(function()

    if IOW:Mode() == "Combo" then
       
        local target = GetCurrentTarget() 
         
        if ValidTarget(target,SkarnerE.range) and CanUseSpell(myHero,_E) == READY and SkarnerMenu.Combo.useE:Value() then
                        
            local ePred = GetPrediction(target,SkarnerE)
                         
            if qPred and qPred.hitChance >= 0.25 then 
                CastSkillShot(_E,qPred.castPos)
            end
        end
       
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_W) == READY and SkarnerMenu.Combo.useW:Value() then
          CastSpell(_W) 
        end
        
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_Q) == READY and SkarnerMenu.Combo.useE:Value() then
          CastSpell(_Q)
        end
        
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_R) == READY and SkarnerMenu.Combo.useR:Value() then
          CastTargetSpell(target,_R)
        end

         if GetItemSlot(myHero, 3077) > 0 and IsReady(GetItemSlot(myHero, 3077)) and SkarnerMenu.Combo.useTiamat:Value() then
       CastSpell(GetItemSlot(myHero, 3077))
      end
    if GetItemSlot(myHero, 3074) > 0 and IsReady(GetItemSlot(myHero, 3074)) and SkarnerMenu.Combo.useHydra:Value() then
       CastSpell(GetItemSlot(myHero, 3074))
      end
    if GetItemSlot(myHero, 3748) > 0 and IsReady(GetItemSlot(myHero, 3748)) and SkarnerMenu.Combo.useTitanic:Value() then
        CastSpell(GetItemSlot(myHero, 3748))
      end 
    end
end)
  
SkarnerMenu:SubMenu("SkinChanger", "SkinChanger")

local skinMeta = {["Skarner"] = {"Classic", "Sandscourge", "Earthrune", "Battlecast Alpha", "Guardian of the Sands"},
SkarnerMenu.SkinChanger:DropDown('skin', myHero.charName.. " Skins", 1, skinMeta[myHero.charName], HeroSkinChanger, true)
SkarnerMenu.SkinChanger.skin.callback = function(model) HeroSkinChanger(myHero, model - 1) print(skinMeta[myHero.charName][model] .." ".. myHero.charName .. " Loaded!") end
