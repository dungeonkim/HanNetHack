-- dknethack's English tutorial level 1 (found before dat/tut-1.lua: i18n.c get_localized_filename)
--
-- The hints describe dknethack's simplified controls (keyboard / gamepad / mouse / touch), not NetHack's
-- keys: engravings carry "{tut:<name>}" tokens that the front end (games/dknethack/src/tutorial.js,
-- TUTORIAL_EN) fills with the sentence for the input device last used. {tut:act} = the action menu,
-- {tut:inv} = opening the inventory. Back-translated from dat/locale/ko/tut-1.lua; keep the two in step.

des.level_init({ style = "solidfill", fg = " " });
des.level_flags("mazelevel", "noflip",
                "nomongen", "nodeathdrops", "noautosearch");

des.map([[
---------------------------------------------------------------------------
|-.--|.......|......|..S....|.F.......|.............|.......|.............|
|.-..........|......|--|....|.F.....|.|S-------.....|.....................|
||.--|.......|..T......|....|.F.....|.|.......|.....|.......|.............|
||.|.|.......|......|-.|....|.F.....|.|.......|.....|--------.............|
||.|.|.......|......||.|-.-----------.-.......|-S----.....................|
|-+-S---------..---.||........................|...|.......................|
|......|          |.-------------------.......|...|....--S----............|
|......|  ######  |.........|      |..S.......|...|....|.....|............|
|----.-| -+-   #  |.....---.|######+..|.......S...|....|.....|............|
|----+----.----+---.|.--|.|.|#     ------------...|....|.....F............|
|........|.|......|.|...F...|#  ........|.....+...|....|.....|............|
|.P......-S|......|------.---# .........|.....|...|....-------........----|
|..........|......+.|...|.|.S# ..--S-----.....|LLL|..................|..| |
|.W......---......|.|.|.|.|.|# ..|......|.....|LLL|..................|..--|
|....Z.L.S.F......|.|.|.|.---#   |......+.....|...|..................|..|.|
|........|--......|...|.....|####+......|.....|...+..................||...|
---------------------------------------------------------------------------
]]);


des.region(selection.area(01,01, 73, 16), "lit");

des.non_diggable();

des.teleport_region({ region = { 9,3, 9,3 } });

-- TODO:
--  - save (more of) hero state when entering

-- turn on some newbie-friendly options
nh.parse_config("OPTIONS=mention_walls");
nh.parse_config("OPTIONS=mention_decor");
nh.parse_config("OPTIONS=lit_corridor");

des.engraving({ coord = { 9,3 }, type = "engrave", text = "{tut:move}", degrade = false });
des.engraving({ coord = { 5,2 }, type = "engrave", text = "{tut:diag}", degrade = false });

if (u.role == "Knight") then
   des.engraving({ coord = { 12,1 }, type = "engrave", text = "Knights can jump: choose 'Other actions' {tut:act}", degrade = false });
end

--

des.engraving({ coord = { 2,4 }, type = "engrave", text = "Some actions may take several tries to succeed", degrade = false });
des.engraving({ coord = { 2,5 }, type = "engrave", text = "Move into a door to open it", degrade = false });
des.door({ coord = { 2,6 }, state = "closed" });

des.engraving({ coord = { 2,7 }, type = "engrave", text = "{tut:close}", degrade = false });


--

des.engraving({ coord = { 4,5 }, type = "engrave", text = "You can leave the tutorial through the magic portal.", degrade = false });
des.trap({ type = "magic portal", coord = { 4,4 }, seen = true });

--

des.engraving({ coord = { 5,9 }, type = "engrave", text = "This door is locked. {tut:kick}", degrade = false });
des.door({ coord = { 5,10 }, state = "locked" });

-- The original explained the Ctrl key notation here; dknethack has none, so this introduces the default action button.
des.engraving({ coord = { 6,8 }, type = "engrave", text = "{tut:default}", degrade = false });


des.engraving({ coord = { 5,12 }, type = "engrave", text = "{tut:look}", degrade = false });

--

des.engraving({ coord = { 10,13 }, type = "engrave", text = "{tut:search}", degrade = false });

des.engraving({ coord = { 10,15 }, type = "engrave", text = "False clue", degrade = false });

--

des.engraving({ coord = { 10,10 }, type = "engrave", text = "Beyond this door is a dark corridor", degrade = false });
des.door({ coord = { 10,9 }, state = percent(50) and "locked" or "closed" });
des.region(selection.match("#"), "unlit");
des.region(selection.match(" "), "unlit");
des.door({ coord = { 15,10 }, state = percent(50) and "locked" or "closed" });

--

des.engraving({ coord = { 15,11 }, type = "engrave", text = "There are four traps around here. Find them", degrade = false });
local locs = { {14,11}, {14,12}, {15,12}, {16,12}, {16,11} };
shuffle(locs);
for i = 1, 4 do
   des.trap({ type = percent(50) and "sleep gas" or "board",
              coord = locs[i], victim = false });
end

des.engraving({ coord = { 15,15 }, type = "engrave", text = "{tut:untrap}", degrade = false });
des.trap({ coord = { 15,16 }, type = "web", spider_on_web = false });

--

des.door({ coord = { 18,13 }, state = "closed" });

des.engraving({ coord = { 19,13 }, type = "engrave", text = "{tut:pickup}", degrade = false });

local armor = (u.role == "Monk") and "leather gloves" or "leather armor";

des.object({ id = armor, spe = 0, buc = "cursed", coord = { 19,14} });

des.engraving({ coord = { 19,15 }, type = "engrave", text = "{tut:inv} pick the armor to put it on", degrade = false });

des.object({ id = "dagger", spe = 0, buc = "not-cursed", coord = { 21,15} });

des.engraving({ coord = { 21,14 }, type = "engrave", text = "{tut:inv} pick the weapon to wield it", degrade = false });


des.engraving({ coord = { 22,13 }, type = "engrave", text = "{tut:attack}", degrade = false });

des.monster({ id = "lichen", coord = { 23,15 }, waiting = true, countbirth = false });

--

des.engraving({ coord = { 24,16 }, type = "engrave", text = "You have learned the basics. You can leave the tutorial through the magic portal.", degrade = false });

des.engraving({ coord = { 26,16 }, type = "engrave", text = "Entering this portal ends the tutorial", degrade = false });
des.trap({ type = "magic portal", coord = { 27,16 }, seen = true });

--

des.engraving({ coord = { 25,13 }, type = "engrave", text = "Move into a boulder to push it", degrade = false });
des.object({ id = "boulder", coord = {25,12} });

--

des.engraving({ coord = { 27,9 }, type = "engrave", text = "{tut:inv} pick the armor you wear to take it off", degrade = false });

--

des.object({ class = "?", id = "remove curse", buc = "blessed", coord = {23,11} })
des.engraving({ coord = { 22,11 }, type = "engrave", text = "The same kind of object can look different in every game", degrade = false });
des.engraving({ coord = { 23,11 }, type = "engrave", text = "Pick up the scroll, then {tut:inv} read it and try taking off the armor again", degrade = false });

--

des.engraving({ coord = { 19,10 }, type = "engrave", text = "Another magic portal. You can leave the tutorial here too", degrade = false });
des.trap({ type = "magic portal", coord = { 19,11 }, seen = true });

--

-- rock fall
des.object({ coord = {14, 5}, id = "rock", quantity = math.random(50,99) });
des.object({ coord = {15, 5}, id = "rock", quantity = math.random(10,30) });
des.object({ coord = {14, 4}, id = "rock", quantity = math.random(10,30) });
des.object({ coord = {15, 6}, id = "rock", quantity = math.random(30,60) });
des.object({ coord = {14, 6}, id = "rock", quantity = math.random(30,60) });
des.object({ coord = {14, 6}, id = "boulder" });

des.door({ coord = { 20,3 }, state = percent(50) and "open" or "closed" });

des.engraving({ coord = { 21,3 }, type = "engrave", text = "Carrying too much slows you down", degrade = false });
des.engraving({ coord = { 22,3 }, type = "engrave", text = "{tut:inv} pick something to drop it", degrade = false });
des.engraving({ coord = { 22,4 }, type = "engrave", text = "{tut:dropcount}", degrade = false });

--

des.monster({ id = "yellow mold", coord = { 26,2 }, waiting = true, countbirth = false });

des.engraving({ coord = { 25,5 }, type = "engrave", text = "{tut:throw}", degrade = false });

des.trap({ type = "magic portal", coord = { 21,1 }, seen = true });

--

des.monster({ id = "wolf", coord = { 29,2 }, peaceful = 0, waiting = true, countbirth = false });

des.engraving({ coord = { 37,4 }, type = "engrave", text = "Ammunition like rocks works better fired from the right launcher", degrade = false });

des.object({ coord = { 37,3 }, id = "sling", buc = "not-cursed", spe = 9 });
des.engraving({ coord = { 37,3 }, type = "engrave", text = "{tut:inv} pick the sling to wield it", degrade = false });
des.engraving({ coord = { 36,1 }, type = "engrave", text = "{tut:fire}", degrade = false });

des.engraving({ coord = { 35,4 }, type = "engrave", text = "Ready your ammunition first. {tut:inv} pick the rocks to ready them for ranged attacks", degrade = false });

des.engraving({ coord = { 33,4 }, type = "engrave", text = "{tut:wait}", degrade = false });


--

des.door({ coord = { 38,6 }, state = "closed" });

des.engraving({ coord = { 39,6 }, type = "engrave", text = "{tut:loot}", degrade = false });

des.object({ coord = { 41,6 }, id = "large box", broken = true, trapped = false,
             contents = function(obj)
                des.object({ id = "secret door detection", class = "/", spe = 30 }); end
});
des.engraving({ coord = { 42,6 }, type = "engrave", text = "You can empty the box at once: choose 'What can I do here' {tut:act}", degrade = false });

des.engraving({ coord = { 45,6 }, type = "engrave", text = "{tut:inv} pick the wand to zap it", degrade = false });

--

des.door({ coord = { 35,9 }, state = "nodoor" });
des.engraving({ coord = { 34,9 }, type = "engrave", text = "{tut:run}", degrade = false });

--

des.door({ coord = { 33,16 }, state = "nodoor" });
des.engraving({ coord = { 35,15 }, type = "engrave", text = "{tut:travel}", degrade = false });

--

des.trap({ type = "magic portal", coord = { 27,14 }, seen = true });

--

des.engraving({ coord = { 48,1 }, type = "burn", text = "{tut:eat}", degrade = false });

des.object({ coord = { 50,3 }, id = "apple", buc = "not-cursed"  });
des.object({ coord = { 50,3 }, id = "candy bar", buc = "not-cursed"  });

des.object({ coord = { 50,3 }, id = "corpse", montype = "lichen", buc = "not-cursed" });

--

des.door({ coord = { 46,11 }, state = "closed" });

des.engraving({ coord = { 43,11 }, type = "burn", text = "Turn on two-weapon combat: choose 'Other actions' {tut:act}", degrade = false });
des.object({ coord = { 43,13 }, id = "knife", buc = "uncursed" });
des.object({ coord = { 43,14 }, id = "dagger", buc = "blessed" });

des.engraving({ coord = { 43,16 }, type = "burn", text = "Choose 'Swap weapons' {tut:act} to switch weapons quickly. It can go in a quick slot too", degrade = false });

des.door({ coord = { 40,15 }, state = "random" });

--

des.object({ coord = { 48,7 }, id = "ring of levitation", buc = "not-cursed" });

des.engraving({ coord = { 48,10 }, type = "burn", text = "{tut:inv} pick a ring or amulet to put it on", degrade = false });

des.engraving({ coord = { 48,16 }, type = "burn", text = "{tut:inv} pick the ring or amulet you wear to remove it", degrade = false });

des.door({ coord = { 50,16 }, state = "closed" });


--

des.engraving({ coord = { 58,9 }, type = "burn", text = "{tut:down}", degrade = false });
des.stair({ dir = "down", coord = { 58,10 } });

--

-- Where the original's second Ctrl notation hint was: looking around and zooming.
des.engraving({ coord = { 64,4 }, type = "burn", text = "{tut:camera}", degrade = false });

des.engraving({ coord = { 65,3 }, type = "burn", text = "Under construction", degrade = false });

des.trap({ type = "magic portal", coord = { 66,2 }, seen = true });

--

-- squeezing through small gaps

des.engraving({ coord = { 69,12 }, type = "burn", text = "If you cannot get through, check whether you carry too much", degrade = false });

-- try to squeeze over boulders, find a trap door

des.object({ id = "boulder", coord = {71,16} });
des.object({ id = "boulder", coord = {72,16} });
des.object({ id = "boulder", coord = {73,16} });
des.trap({ type = "trap door", coord = { 73,15 } });

--

des.engraving({ coord = { 60,2 }, type = "engrave", text = "Spellcasting", degrade = false });
if (u.uenmax < 5) then
   -- TODO: make sure hero has enough Pw to cast the spell (5 pw) instead?
   -- TODO: ensure the first cast of this spell succeeds?
   des.engraving({ coord = { 59,2 }, type = "engrave", text = "You do not have enough energy to cast a spell.", degrade = false });
end
des.engraving({ coord = { 57,2 }, type = "engrave", text = "{tut:pickup}", degrade = false });
des.object({ coord = { 57,2 }, id = "spellbook of light", buc = "blessed" });
des.engraving({ coord = { 55,2 }, type = "engrave", text = "{tut:inv} pick the spellbook to read it", degrade = false });
des.engraving({ coord = { 53,2 }, type = "engrave", text = "Cast the spell: choose 'Cast a spell' {tut:act}", degrade = false });
des.region(selection.area(53,01, 59, 3), "unlit");

--

des.engraving({ coord = { 72,2 }, type = "engrave", text = "{tut:inv} pick the potion to drink it", degrade = false });
des.object({ coord = { 72,2 }, id = "potion of object detection", buc = "blessed" });


----------------

-- entering and leaving tutorial _branch_ now handled by core
-- // nh.callback("cmd_before", "tutorial_cmd_before");
-- // nh.callback("level_enter", "tutorial_enter");
-- // nh.callback("level_leave", "tutorial_leave");
-- // nh.callback("end_turn", "tutorial_turn");
