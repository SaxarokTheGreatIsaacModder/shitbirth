--ULTRA BIG THANKS TO ilise rose#3446,Yusyuriv#4287 FROM MODDING OF ISAAC DISCORD SERVER

local pbb = RegisterMod("prettyboybow", 1)

TearFlags = {
  TEAR_NO_EFFECT = 0,
  TEAR_SPECTRAL = 1,
  TEAR_PIERCING = 1<<1,
  TEAR_HOMING = 1<<2,
  TEAR_SLOWING = 1<<3,
  TEAR_POISONING = 1<<4,
  TEAR_FREEZING = 1<<5,
  TEAR_PARASITE = 1<<6,
  TEAR_LUMP_OF_COAL = 1<<7,
  TEAR_MY_REFLECTION = 1<<8,
  TEAR_POLYPHEMUS = 1<<9,
  TEAR_WIGGLE_WORM = 1<<10,
  TEAR_UNKNOWN_2 = 1<<11,
  TEAR_IPECAC = 1<<12,
  TEAR_CHARMING = 1<<13,
  TEAR_CONFUSING = 1<<14,
  TEAR_ENEMIES_DROP_HEARTS = 1<<15,
  TEAR_TINY_PLANET = 1<<16,
  TEAR_ANTI_GRAVITY = 1<<17,
  TEAR_CRICKETS_BODY = 1<<18,
  TEAR_RUBBER_CEMENT = 1<<19,
  TEAR_FEAR = 1<<20,
  TEAR_PROPTOSIS = 1<<21,
  TEAR_BURNING = 1<<22,
  TEAR_STRANGE_ATTRACTOR = 1<<23,
  TEAR_UNKNOWN_5 = 1<<24,
  TEAR_PULSE_WORM = 1<<25,
  TEAR_RING_WORM = 1<<26,
  TEAR_FLAT_WORM = 1<<27,
  TEAR_UNKNOWN_6 = 1<<28,
  TEAR_UNKNOWN_7 = 1<<29,
  TEAR_UNKNOWN_8 = 1<<30,
  TEAR_HOOK_WORM = 1<<31,
  TEAR_GODHEAD = 1<<32,
  TEAR_UNKNOWN_9 = 1<<33,
  TEAR_UNKNOWN_10 = 1<<34,
  TEAR_EXPLOSIVO = 1<<35,
  TEAR_CONTINUUM = 1<<36,
  TEAR_HOLY_LIGHT = 1<<37,
  TEAR_HEAD_OF_KEEPER = 1<<38,
  TEAR_UNKNOWN_11 = 1<<39,
  TEAR_UNKNOWN_12 = 1<<40,
  TEAR_GODS_FLESH = 1<<41,
  TEAR_UNKNOWN_13 = 1<<42,
  TEAR_MYSTERIOUS_LIQUID = 1<<43,
  TEAR_OUROBOROS_WORM = 1<<44,
  TEAR_GLAUCOMA = 1<<45,
  TEAR_SINUS_INFECTION = 1<<46,
  TEAR_PARASITOID = 1<<47,
  TEAR_UNKNOWN_14 = 1<<48,
  TEAR_SPLIT = 1<<49,
  TEAR_DEAD_EYE = 1<<50,
  TEAR_MIDAS = 1<<51,
  TEAR_EUTHANASIA = 1<<52,
  TEAR_JACOBS_LADDER = 1<<53,
  TEAR_LITTLE_HORN = 1<<54,
  TEAR_GHOST_PEPPER = 1<<55
}

  local BoomelaserDelay = 0


local prettyBoyBow_item = Isaac.GetItemIdByName( "Pretty Boy Bow" )
local prettyBoyBow_costume = Isaac.GetCostumeIdByPath("gfx/characters/prettyboybow.anm2")
local temPrettyBoyBow = false

local techZ_item = Isaac.GetItemIdByName( "Tech Z" )
local techZ_costume = Isaac.GetCostumeIdByPath("gfx/characters/tech_z.anm2")
local temTechZ = false
local techZTears = {};

local currentRoom = 0;

--function CompareEntity(a,b) -- Checks to make sure the Entity being referenced is the right Entity
    -- IF the type, variant, subtype and index are all the same, it SHOULD be the Entity we're looking for
--    return a.Type == b.Type and a.Variant == b.Variant and a.SubType == b.SubType and a.Index == b.Index
--end

--function HasParent(entity,parent) -- Loops through all Parent to check if an Entity is an ancestor to another Entity
--    while entity ~= nil do -- While the Entity exists
--       -- If the Entity has a Parent and it's the Parent we're looking for
--        if entity.Parent ~= nil and CompareEntity(entity.Parent,parent) then
--            return true
--        end
--        -- We didn't find the Parent, so check the Parent's Parent
--        entity = entity.Parent
--    end
    -- We never found the parent, so the Entity we're checking is not an ancestor
--    return false
--end


function pbb:newRun( )
  local player = Isaac.GetPlayer(0)
  temPrettyBoyBow = false
  temTechZ = false
  BoomelaserDelay = 0
end


function pbb:debug_text()
    Isaac.RenderText(debug_text, Isaac.GetPlayer(0).Position.X, Isaac.GetPlayer(0).Position.Y, 255, 0, 0, 255)
end
--function pbb:TechZ()
--   local   player = Isaac.GetPlayer(0)
--      roomEntities = Isaac.GetRoomEntities()
 --   for i,entity in pairs(roomEntities) do
 --       if entity.Type == EntityType.ENTITY_TEAR and HasParent(entity,player) and not entity:GetData().custom then
 --           local customTear = Isaac.Spawn(EntityType.ENTITY_TEAR, 65,0,entity.Position, entity.Velocity,player)
 --           customTear:GetData().custom = true
 --           
 --       if player:GetFireDirection() == 1 then
  --          customTear:GetSprite():Play("MoveUp",1)
--
	--	        elseif player:GetFireDirection() == 2 then
  --        customTear:GetSprite():Play("MoveRight",1)
 --           
 --           elseif player:GetFireDirection() == 3 then
  --          customTear:GetSprite():Play("MoveDown",1)
 --           
 --           elseif player:GetFireDirection() == 0 then
 --           customTear:GetSprite():Play("MoveLeft",1)
 --           end
 --           
--            
--            entity:Remove()
--        end
--    end
--  end

function pbb:check() 
  debug_text = "PEW"
  local player = Isaac.GetPlayer(0)

  local tempRoom = Game():GetRoom():GetDecorationSeed();
  if currentRoom ~= tempRoom then
    currentRoom = tempRoom;
    techZTears = {};
  end

  if temPrettyBoyBow == false and player:HasCollectible(prettyBoyBow_item) then
    temPrettyBoyBow = true
    player:AddNullCostume(prettyBoyBow_costume)
    player:AddSoulHearts(2)
  end
  
  if temTechZ == false and player:HasCollectible(techZ_item) then
    temTechZ = true
    player:AddNullCostume(techZ_costume)
    player:AddSoulHearts(2)
    player:EvaluateItems()
  end

  for idx,entity in pairs(techZTears) do
    if not entity[1]:Exists() then
      local splash = Isaac.Spawn(1000, 169, 0, entity[1].Position, Vector(0,0), nil);
      splash.SpriteRotation = entity[2];
      splash:GetSprite():Play("Poof", true);
      techZTears[idx] = nil;
    end
  end
	
  if player:HasCollectible(techZ_item) then

    local entities = Isaac.GetRoomEntities();
    for i = 1, #entities do
      local e = entities[i];
      if e.Type == EntityType.ENTITY_TEAR and e.Parent.Type == EntityType.ENTITY_PLAYER and e.Variant ~= 65 then
        local BoomelaserTear = player:FireTear(e.Position, e.Velocity, false, false, true);
        BoomelaserTear:ChangeVariant(65);
          debug_text = "PEW"
        BoomelaserTear.TearFlags = BoomelaserTear.TearFlags | TearFlags.TEAR_PIERCING;
        BoomelaserTear:GetSprite():Play("MoveUp", true);
        BoomelaserTear.SpriteRotation = e.Velocity:Normalized():GetAngleDegrees() + 90;
        tear.Scale = 0.5 + (player.Damage / 3.5) * 0.5;
        tear.SpriteScale = Vector(tear.Scale, tear.Scale);

        -- Add to the splash table if the player doesn't have ipecac
        if BoomelaserTear.TearFlags & TearFlags.TEAR_IPECAC == 0 then
          techZTears[BoomelaserTear.TearIndex] = {BoomelaserTear, BoomelaserTear.SpriteRotation}
        end

        e:Remove();
      end
    end

  end
end

--pbb:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, pbb.TechZ)
pbb:AddCallback(ModCallbacks.MC_POST_RENDER, pbb.debug_text)
pbb:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT , pbb.newRun)
pbb:AddCallback(ModCallbacks.MC_POST_UPDATE, pbb.check)
