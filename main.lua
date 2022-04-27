-- title:  Escpace Adventure
-- author: Sesso Kosga
-- desc:   Adventure Game, escape from your burning house
-- script: lua
lstR={}
lstInv={}
curR=nil
smoke=0
smokeMax=60*1000

function goTo(pID)
	for i=1,#lstR do
		if pID == lstR[i].id then
			curR = lstR[i]
			break
		end
	end
end

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
r_p.see={{na="A locked door",id="DOOR"}}
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
r_r.see={{na="A closed box",id="BOX"}}
r_r.e="COULOIR1"

r_k=addR()
r_k.na="Kitchen"
r_k.id="KITCHEN"
r_k.w="COULOIR2"
r_k.see={{na="A big hammer",id="HAMMER"}}

curR = r_p
z=0
function TIC()
	cls()
	dir=""	
	print(curR.na,50,0,12)
	-- Directions
	print("Directions: ",160,25,12)
	if curR.e~="" then
		dir=dir.."E "
	end
	if curR.w~="" then
		dir=dir.."W "
	end
		if curR.n~="" then
		dir=dir.."N "
	end	if curR.s~="" then
		dir=dir.."S "
	end
	print(dir,165,33,12)
	
	-- Move to other rooms
	if keyp(5) and curR.e~="" then -- E
		goTo(curR.e)
	end
	if keyp(23) and curR.w~="" then -- W
		goTo(curR.w)
	end
	
	if keyp(14) and curR.n~="" then -- N
		goTo(curR.n)
	end
	if keyp(19) and curR.s~="" then -- S
				goTo(curR.s)
	end
	
	-- Show what the player see
	print("I see : ",160,42,12)
	for i=1, #curR.see do
		print(curR.see[i].na,165,40+i*10,12)
	end
	
	-- Show the smoke quantity
	print("Smoke : ",160,10,13)
	rect(200,10,40,5,15)
	rect(200,10,smoke*40/smokeMax,5,13)
	if smoke < smokeMax then
		smoke = time()
	end

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

