pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- backgammon

music(0)
pips = { }
width = 8

sel = 2
selecting = false

red = 1
blue = 2
turn = red
move = 0
function Pip(num, own)
	return {num=num, top=own, bot=own}
end

function _init()
	for i=1, 26 do
		add(pips, {top=0, bot = 0, num = 0})
	end
	pips[2] = Pip(2,blue)
	pips[7] = Pip(5,red)
	pips[9] = Pip(3,red)
	pips[13] = Pip(5,blue)
	pips[14] = Pip(5,red)
	pips[18] = Pip(3,blue)
	pips[20] = Pip(5,blue)
	pips[25] = Pip(2,red)
end

function id_to_x(id)
	if id >= 20 then return (id-12) * 8
	elseif id >= 14 then return (id-13) * 8
	elseif id >= 8 then return (14-id) * 8
	else return (15-id) * 8 end
end

function drawStack(id)
	count = pips[id].num

	top = pips[id].top
	bot = pips[id].bot

	if id > 13 then
		y = 0
		pos = 1
	else
		y = 120
		pos = -1
	end

	spr(bot, id_to_x(id), y)
	
	for i=1,count-1 do
		spr(top, id_to_x(id), y + 8*i*pos)
	end
end


function _draw()
	cls()

	--background
	rectfill(120,127,0,0,3)


	--draw rectangle board
	-- for i=2, 13 do
	-- 	x = id_to_x(i)
	-- 	rectfill(x,0, x+7, 50, (i % 2) + 4)
	-- 	rectfill(x,78,x+7, 128, ((1+i) % 2) + 4)
	-- end

	for i=2,13 do
		x=id_to_x(i)
		if i % 2 == 0 then pal()
		else pal (4,5) end
		spr(12, x, 0, 1, 4, 0, 1)
		spr(30, x, 32, 1, 3, 0, 1)

		if i % 2 == 0 then pal(4,5)
		else pal() end
		spr(12, x, 96, 1, 4)
		spr(30, x, 72, 1, 3)
	end

	for i=2,26 do
		if (pips[i].num != 0) then
			drawStack(i)
		end
	end

	num = pips[sel].num > 1 and pips[sel].num - 1 or 0

	--draw selector
	if sel > 13 then y = 0 + num*8; offset = 4
	else y = 120 - num*8; offset = -4 end
	if selecting then
		spr(move, id_to_x(sel), y+offset)
	else spr(3, id_to_x(sel), y) end
	
	
	-- print("this is pico-8",
	--  37, 70, 14) 
	-- print("nice to meet you",
	--  34, 80, 12) 
	-- spr(1, 64-4, 90) -- ♥
end

function take(id)
	--can you take it
	local size = pips[id].num
	if size > 0 then
		move = pips[id].top
		selecting = true
		pips[id].num -= 1;
		if size == 1 then
			pips[id].top = 0
			pips[id].bot = 0
		elseif size == 2 then
			pips[id].top = pips[id].bot
		end
	end
end

function put(id)
	if true then
		selecting = false
		if pips[id].num == 0 then pips[id].bot = move end
		pips[id].num += 1
		pips[id].top = move
	end
end

function _update()
	if btnp(❎) then
		if selecting then
			put(sel)
		else
			take(sel)
		end
	end
	if (sel < 14) then
		if (btnp(⬅️)) then sel = min(sel+1,26) sfx(0)
		elseif (btnp(➡️)) then sel = max(sel-1,1) sfx(0)
		elseif (btnp(⬆️)) then sel = (27-sel) sfx(0)
		elseif (btnp(⬇️)) then sel = (27-sel) sfx(0) end
	else
		if (btnp(⬅️)) then sel = max(sel-1,1) sfx(0)
		elseif (btnp(➡️)) then sel = min(sel+1,26) sfx(0)
		elseif (btnp(⬆️)) then sel = (27-sel) sfx(0)
		elseif (btnp(⬇️)) then sel = (27-sel) sfx(0) end
	end
end













__gfx__
00000000002222000011110077000077000000000000000000000000000000000000000000000000000000000000000000044400000000000000000000000000
000000000288882001cccc1070000007000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000288868821ccc6cc100000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000288886821cccc6c100000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000288888821cccccc100000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000288888821cccccc100000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
000000000288882001cccc1070000007000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000002222000011110077000077000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444440000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000000400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000004440000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000004440000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000004440000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004444444000000000004440000000000
00000000000000000000000000000000000000000880880000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000008888878000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000008888888000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000000888880000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000000088800000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000044444444400000000004440000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044444444400000000004440000000000
__sfx__
0110000000472004620c3400c34318470004311842500415003700c30500375183750c3000c3751f4730c375053720536211540114330c37524555247120c3730a470163521d07522375164120a211220252e315
01100000183732440518433394033c65539403185432b543184733940318433394033c655306053940339403184733940318423394033c655394031845321433184733940318473394033c655394033940339403
01100000247552775729755277552475527755297512775524755277552b755277552475527757297552775720755247572775524757207552475227755247522275526757297552675722752267522975526751
01100000001750c055003550c055001750c055003550c05500175180650c06518065001750c065003650c065051751106505365110650c17518075003650c0650a145160750a34516075111451d075113451d075
011000001b5771f55722537265171b5361f52622515265121b7771f76722757267471b7461f7362271522712185771b5571d53722517187361b7261d735227122454527537295252e5171d73514745227452e745
01100000275422754227542275422e5412e5452b7412b5422b5452b54224544245422754229541295422954224742277422e7422b7422b5422b5472954227542295422b742307422e5422e7472b547305462e742
0110000030555307652e5752b755295622e7722b752277622707227561297522b072295472774224042275421b4421b5451b5421b4421d542295471d442295422444624546245472444727546275462944729547
0110000000200002000020000200002000020000200002000020000200002000020000200002000020000200110171d117110171d227131211f227130371f2370f0411b1470f2471b35716051221571626722367
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002e775000002e1752e075000002e1752e77500000
__music__
00 00044208
00 00044108
00 00010304
00 00010304
01 00010203
00 00010203
00 00010305
00 00010306
00 00010305
00 00010306
00 00010245
02 00010243

