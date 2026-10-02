-- Korean translation of tut-1.lua
-- 튜토리얼 레벨 1 한국어 번역
--
-- dknethack: 조작 안내는 원작 키가 아니라 간편 조작계(키보드 / 게임패드 / 마우스 / 터치)를 설명한다.
-- 각인은 "{tut:이름}" 토큰으로 쓰고, 프런트엔드(games/dknethack/src/tutorial.js)가 메시지를 그릴 때
-- 마지막으로 쓴 입력 장치에 맞는 문장으로 채운다. {tut:act} = 행동 메뉴, {tut:inv} = 소지품 열기.

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
   des.engraving({ coord = { 12,1 }, type = "engrave", text = "기사는 {tut:act} '그 외의 행동들'에서 점프할 수 있습니다", degrade = false });
end

--

des.engraving({ coord = { 2,4 }, type = "engrave", text = "일부 행동은 여러 번 시도해야 성공할 수 있습니다", degrade = false });
des.engraving({ coord = { 2,5 }, type = "engrave", text = "문 쪽으로 이동하면 문이 열립니다", degrade = false });
des.door({ coord = { 2,6 }, state = "closed" });

des.engraving({ coord = { 2,7 }, type = "engrave", text = "{tut:close}", degrade = false });


--

des.engraving({ coord = { 4,5 }, type = "engrave", text = "마법 포털로 튜토리얼을 나갈 수 있습니다.", degrade = false });
des.trap({ type = "magic portal", coord = { 4,4 }, seen = true });

--

des.engraving({ coord = { 5,9 }, type = "engrave", text = "이 문은 잠겨 있습니다. {tut:kick}", degrade = false });
des.door({ coord = { 5,10 }, state = "locked" });

-- 원작은 여기서 Ctrl 조합 표기를 설명했다. dknethack에는 없으니 기본 행동 버튼을 소개한다.
des.engraving({ coord = { 6,8 }, type = "engrave", text = "{tut:default}", degrade = false });


des.engraving({ coord = { 5,12 }, type = "engrave", text = "{tut:look}", degrade = false });

--

des.engraving({ coord = { 10,13 }, type = "engrave", text = "{tut:search}", degrade = false });

des.engraving({ coord = { 10,15 }, type = "engrave", text = "가짜 단서", degrade = false });

--

des.engraving({ coord = { 10,10 }, type = "engrave", text = "이 문 너머는 어두운 복도입니다", degrade = false });
des.door({ coord = { 10,9 }, state = percent(50) and "locked" or "closed" });
des.region(selection.match("#"), "unlit");
des.region(selection.match(" "), "unlit");
des.door({ coord = { 15,10 }, state = percent(50) and "locked" or "closed" });

--

des.engraving({ coord = { 15,11 }, type = "engrave", text = "주변에 함정이 네 개 있습니다. 찾아보세요", degrade = false });
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

des.engraving({ coord = { 19,15 }, type = "engrave", text = "{tut:inv} 갑옷을 골라 입으세요", degrade = false });

des.object({ id = "dagger", spe = 0, buc = "not-cursed", coord = { 21,15} });

des.engraving({ coord = { 21,14 }, type = "engrave", text = "{tut:inv} 무기를 골라 장착하세요", degrade = false });


des.engraving({ coord = { 22,13 }, type = "engrave", text = "{tut:attack}", degrade = false });

des.monster({ id = "lichen", coord = { 23,15 }, waiting = true, countbirth = false });

--

des.engraving({ coord = { 24,16 }, type = "engrave", text = "이제 기본 조작을 익혔습니다. 마법 포털로 튜토리얼을 나갈 수 있습니다.", degrade = false });

des.engraving({ coord = { 26,16 }, type = "engrave", text = "이 포털에 들어가면 튜토리얼이 끝납니다", degrade = false });
des.trap({ type = "magic portal", coord = { 27,16 }, seen = true });

--

des.engraving({ coord = { 25,13 }, type = "engrave", text = "바위를 향해 이동하면 밀 수 있습니다", degrade = false });
des.object({ id = "boulder", coord = {25,12} });

--

des.engraving({ coord = { 27,9 }, type = "engrave", text = "{tut:inv} 입고 있는 갑옷을 골라 벗으세요", degrade = false });

--

des.object({ class = "?", id = "remove curse", buc = "blessed", coord = {23,11} })
des.engraving({ coord = { 22,11 }, type = "engrave", text = "같은 종류의 아이템도 판마다 설명이 달라질 수 있습니다", degrade = false });
des.engraving({ coord = { 23,11 }, type = "engrave", text = "스크롤을 주운 뒤 {tut:inv} 스크롤을 읽고 갑옷을 다시 벗어 보세요", degrade = false });

--

des.engraving({ coord = { 19,10 }, type = "engrave", text = "또 다른 마법 포털입니다. 여기로도 튜토리얼을 나갈 수 있습니다", degrade = false });
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

des.engraving({ coord = { 21,3 }, type = "engrave", text = "짐이 무거우면 느려집니다", degrade = false });
des.engraving({ coord = { 22,3 }, type = "engrave", text = "{tut:inv} 물건을 골라 버리세요", degrade = false });
des.engraving({ coord = { 22,4 }, type = "engrave", text = "{tut:dropcount}", degrade = false });

--

des.monster({ id = "yellow mold", coord = { 26,2 }, waiting = true, countbirth = false });

des.engraving({ coord = { 25,5 }, type = "engrave", text = "{tut:throw}", degrade = false });

des.trap({ type = "magic portal", coord = { 21,1 }, seen = true });

--

des.monster({ id = "wolf", coord = { 29,2 }, peaceful = 0, waiting = true, countbirth = false });

des.engraving({ coord = { 37,4 }, type = "engrave", text = "돌멩이 같은 탄은 맞는 발사기로 쏘면 더 효과적입니다", degrade = false });

des.object({ coord = { 37,3 }, id = "sling", buc = "not-cursed", spe = 9 });
des.engraving({ coord = { 37,3 }, type = "engrave", text = "{tut:inv} 새총을 골라 장착하세요", degrade = false });
des.engraving({ coord = { 36,1 }, type = "engrave", text = "{tut:fire}", degrade = false });

des.engraving({ coord = { 35,4 }, type = "engrave", text = "쏠 탄은 미리 준비합니다. {tut:inv} 돌멩이를 골라 원거리 공격용으로 준비하세요", degrade = false });

des.engraving({ coord = { 33,4 }, type = "engrave", text = "{tut:wait}", degrade = false });


--

des.door({ coord = { 38,6 }, state = "closed" });

des.engraving({ coord = { 39,6 }, type = "engrave", text = "{tut:loot}", degrade = false });

des.object({ coord = { 41,6 }, id = "large box", broken = true, trapped = false,
             contents = function(obj)
                des.object({ id = "secret door detection", class = "/", spe = 30 }); end
});
des.engraving({ coord = { 42,6 }, type = "engrave", text = "{tut:act} '여기서 할 수 있는 행동 보기'에서 상자 내용물을 모두 비울 수 있습니다", degrade = false });

des.engraving({ coord = { 45,6 }, type = "engrave", text = "{tut:inv} 마법봉을 골라 사용하세요", degrade = false });

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

des.engraving({ coord = { 43,11 }, type = "burn", text = "{tut:act} '그 외의 행동들'에서 쌍수 전투를 켤 수 있습니다", degrade = false });
des.object({ coord = { 43,13 }, id = "knife", buc = "uncursed" });
des.object({ coord = { 43,14 }, id = "dagger", buc = "blessed" });

des.engraving({ coord = { 43,16 }, type = "burn", text = "{tut:act} '보조 무기로 바꾸기'로 무기를 빠르게 교체합니다. 퀵슬롯에도 넣을 수 있습니다", degrade = false });

des.door({ coord = { 40,15 }, state = "random" });

--

des.object({ coord = { 48,7 }, id = "ring of levitation", buc = "not-cursed" });

des.engraving({ coord = { 48,10 }, type = "burn", text = "{tut:inv} 반지나 목걸이를 골라 착용하세요", degrade = false });

des.engraving({ coord = { 48,16 }, type = "burn", text = "{tut:inv} 착용한 반지나 목걸이를 골라 벗으세요", degrade = false });

des.door({ coord = { 50,16 }, state = "closed" });


--

des.engraving({ coord = { 58,9 }, type = "burn", text = "{tut:down}", degrade = false });
des.stair({ dir = "down", coord = { 58,10 } });

--

-- 원작의 두 번째 Ctrl 표기 안내 자리: 둘러보기와 확대·축소를 소개한다.
des.engraving({ coord = { 64,4 }, type = "burn", text = "{tut:camera}", degrade = false });

des.engraving({ coord = { 65,3 }, type = "burn", text = "공사 중", degrade = false });

des.trap({ type = "magic portal", coord = { 66,2 }, seen = true });

--

-- squeezing through small gaps

des.engraving({ coord = { 69,12 }, type = "burn", text = "지나가기 어렵다면 짐이 너무 많은지 확인해 보세요", degrade = false });

-- try to squeeze over boulders, find a trap door

des.object({ id = "boulder", coord = {71,16} });
des.object({ id = "boulder", coord = {72,16} });
des.object({ id = "boulder", coord = {73,16} });
des.trap({ type = "trap door", coord = { 73,15 } });

--

des.engraving({ coord = { 60,2 }, type = "engrave", text = "주문 시전", degrade = false });
if (u.uenmax < 5) then
   -- TODO: make sure hero has enough Pw to cast the spell (5 pw) instead?
   -- TODO: ensure the first cast of this spell succeeds?
   des.engraving({ coord = { 59,2 }, type = "engrave", text = "주문을 시전할 마나가 부족합니다.", degrade = false });
end
des.engraving({ coord = { 57,2 }, type = "engrave", text = "{tut:pickup}", degrade = false });
des.object({ coord = { 57,2 }, id = "spellbook of light", buc = "blessed" });
des.engraving({ coord = { 55,2 }, type = "engrave", text = "{tut:inv} 마법책을 골라 읽으세요", degrade = false });
des.engraving({ coord = { 53,2 }, type = "engrave", text = "{tut:act} '주문 외우기'로 주문을 시전하세요", degrade = false });
des.region(selection.area(53,01, 59, 3), "unlit");

--

des.engraving({ coord = { 72,2 }, type = "engrave", text = "{tut:inv} 물약을 골라 마시세요", degrade = false });
des.object({ coord = { 72,2 }, id = "potion of object detection", buc = "blessed" });


----------------

-- entering and leaving tutorial _branch_ now handled by core
-- // nh.callback("cmd_before", "tutorial_cmd_before");
-- // nh.callback("level_enter", "tutorial_enter");
-- // nh.callback("level_leave", "tutorial_leave");
-- // nh.callback("end_turn", "tutorial_turn");
