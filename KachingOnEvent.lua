-- KachingOnEvent: plays kaching.mp3 when an auction sells, an herb is gathered, or ore is mined

local ADDON, ns = ...

-- sound file shipped in the addon folder
local SOUND = "Interface\\AddOns\\" .. ADDON .. "\\kaching.mp3"
-- base spells whose localized names identify gathering casts
local HERB_SPELL, MINING_SPELL = 2366, 2575
-- settings with their chat command, label, and description
local TRIGGERS = {
  { key = "auction", label = "Auction sold", help = "an auction of yours sells" },
  { key = "herb", label = "Herb gathered", help = "you gather an herb" },
  { key = "mining", label = "Ore mined", help = "you mine a deposit" },
}

-- chat pattern for a format string such as ERR_AUCTION_SOLD_S
local function Pattern(format)
  local escaped = format:gsub("[%^%$%(%)%.%[%]%*%+%-%?]", "%%%0")
  return "^" .. escaped:gsub("%%s", ".+") .. "$"
end

-- whether a value is hidden from addons (12.x secret values)
local function Secret(value)
  return issecretvalue ~= nil and issecretvalue(value)
end

-- localized "auction sold" system message, if the client defines it
local auctionSold = ERR_AUCTION_SOLD_S and Pattern(ERR_AUCTION_SOLD_S)

-- play the sound when the setting for this trigger is on
local function Kaching(key)
  if ns.db ~= nil and ns.Get(key) then
    PlaySoundFile(SOUND, "Master")
  end
end

-- current state of every trigger
local function Status()
  for _, trigger in ipairs(TRIGGERS) do
    ns.Status(trigger.label, ns.OnOff(ns.Get(trigger.key)))
  end
  ns.Status("per character", ns.OnOff(ns.char.perCharacter))
end

-- event handlers by event name
local events = {}

-- system chat line: auction sold
function events.CHAT_MSG_SYSTEM(text)
  if auctionSold and type(text) == "string" and not Secret(text) and text:match(auctionSold) then
    Kaching("auction")
  end
end

-- own cast finished: herb gathering or mining
function events.UNIT_SPELLCAST_SUCCEEDED(_, _, spellID)
  if not spellID or Secret(spellID) then
    return
  end
  local name = C_Spell.GetSpellName(spellID)
  if not name then
    return
  end
  if name == C_Spell.GetSpellName(HERB_SPELL) then
    Kaching("herb")
  elseif name == C_Spell.GetSpellName(MINING_SPELL) then
    Kaching("mining")
  end
end

-- one frame dispatching all events above
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
frame:SetScript("OnEvent", function(_, event, ...)
  events[event](...)
end)

-- saved state; settings page once loaded
ns.Store("KachingOnEventDB", { auction = true, herb = true, mining = true }, function()
  ns.Settings()
  for _, trigger in ipairs(TRIGGERS) do
    ns.Checkbox(trigger.key, trigger.label, "Play the kaching sound when " .. trigger.help)
  end
end)

-- one on|off chat command per trigger
for _, trigger in ipairs(TRIGGERS) do
  ns.Command({
    name = trigger.key,
    help = "kaching when " .. trigger.help,
    args = { { name = "state", choices = { "on", "off" } } },
    run = function(args)
      ns.Set(trigger.key, args.state == "on")
      ns.Status(trigger.label, ns.OnOff(ns.Get(trigger.key)))
    end,
  })
end
ns.Command({
  name = "character",
  help = "use settings for this character only, or the account's",
  args = { { name = "state", choices = { "on", "off" } } },
  run = function(args)
    ns.Set("perCharacter", args.state == "on")
    Status()
  end,
})
ns.Command({ name = "config", help = "open the settings page", run = ns.OpenSettings })
ns.Slash("/kaching", Status)
