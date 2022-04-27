-- title:  Escpace Adventure
-- author: Sesso Kosga
-- desc:   Adventure Game, escape from your burning house
-- script: lua
lstR={}
lstInv={}
curR=nil

function addR()
	local r={}
	r.na=""
	r.id=""
	r.see={}
	r.e=""
	r.w=""
	r.n=""
	r.s=""
	table.insert(lstR,r)
	return r
end


r_p = addR()
r_p.na="Principal room"
r_p.id="PRINCIPAL"
r_p.see={"Door"}
r_p.n="COULOIR1"
r_p.e="COULOIR2"

r_c1=addR()
r_c1.na="Couloir"
r_c1.id="COULOIR1"
r_c1.w="ROOM"
r_c1.s="PRINCIPAL"

r_c2=addR()
r_c2.na="Couloir"
r_c2.id="COULOIR2"
r_c2.w="PRINCIPAL"
r_c2.e="KITCHEN"

r_r=addR()
r_r.na="Room"
r_r.id="ROOM"
r_r.see={"BOX"}
r_r.e="COULOIR1"

r_k=addR()
r_k.na="Kitchen"
r_k.id="KITCHEN"
r_k.w="COULOIR2"
r_k.see={"HAMMER"}

curR = r_p

function TIC()
	cls()
	dir=""	
	print(curR.na,20,0,12)
	-- Directions
	if curR.e~="" then
		dir=dir.."E"
	end
	if curR.w~="" then
		dir=dir.." W"
	end
		if curR.n~="" then
		dir=dir.." N"
	end	if curR.s~="" then
		dir=dir.." S"
	end
	print(dir,5,40,12)
	
	
	
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

