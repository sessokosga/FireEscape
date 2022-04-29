-- title:  Fire Escape
-- author: Sesso Kosga
-- desc:   Adventure Game, escape from your burning house
-- script: lua

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
	r.d={}
	table.insert(lstR,r)
	return r
end


function init()

	lstR={}
	inv={}
	curR=nil
	smoke=0
	smokeMax=2*60*1000
	sub = time()
	state="Normal"
	victory = false
	failure=false

	r_p = addR()
	r_p.na="Principal room"
	r_p.id="PRINCIPAL"
	r_p.see={{na="A locked door",id="DOOR"}}
	r_p.n="COULOIR1"
	r_p.e="COULOIR2"
	r_p.d={"The exit door is ","right in front of you","But it's locked","Smoke is filling","the room"}

	r_c1=addR()
	r_c1.na="Couloir"
	r_c1.id="COULOIR1"
	r_c1.w="ROOM"
	r_c1.s="PRINCIPAL"
	r_c1.d={"The couloir is hot","and dark","The whole house","is being filled","by smoke","The smoke bar is","in the top right"}

	r_c2=addR()
	r_c2.na="Couloir"
	r_c2.id="COULOIR2"
	r_c2.w="PRINCIPAL"
	r_c2.e="KITCHEN"
	r_c2.d={"The couloir is hot","and dark.","When the smoke bar","will be full, you'll","faint and die"}

	r_r=addR()
	r_r.na="Room"
	r_r.id="ROOM"
	r_r.see={{na="A locked box",id="BOX"}}
	r_r.e="COULOIR1"
	r_r.d={"There is a yellow box","On a table next","to your bed"}

	r_k=addR()
	r_k.na="Kitchen"
	r_k.id="KITCHEN"
	r_k.w="COULOIR2"
	r_k.see={{na="A big hammer",id="HAMMER"}}
	r_k.d={"The kitchen is filled"," with smoke","You barely see a","hammer on the ground"}

	curR = r_p
	choice=0
	subchoice=0
	cant=false

end

init()

function TIC()
	cls()
	if victory then
		print("CONGRATULATIONS.",70,6,12)
		print("You escaped from the burning house.",25,22,12)
		print("Thanks for playing",65,70,11)
		print("By Sesso Kosga",70,90,12)
		print("kosgasesso@gmail.com",55,100,12)
	elseif failure then
		print("YOU FAINTED.",80,6,2)
		print("You got burned in the burning house.",25,22,2)
		print("Press 'space' to restart",45,70,11)
		if keyp(48) then -- Space
			init()
		end
	else
		-- Show the smoke quantity
		print("Smoke : ",128,5,12)
		rect(174,5,40,6,15)
		rect(174,5,smoke*40/smokeMax,6,12)
		if smoke < smokeMax then
			smoke = time()-sub
		else
			failure = true
		end

		dir=""	
		print(curR.na,25,3,12)
		-- Directions
		print("Directions: ",128,15,12)
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
		print(dir,135,23,12)
		
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

		-- Show the actions
		yUI=35
		print("Actions : ",128,yUI,12)
		yUI=yUI+8
		print("[1] Open",135,yUI,12)
		yUI=yUI+8
		print("[2] Take",135,yUI,12)
		yUI=yUI+8
		print("[3] Use",135,yUI,12)
		yUI=yUI+10
		-- Show what the player see
		print("I see : ",128,yUI,12)
		for i=1, #curR.see do
			print("["..i.."] "..curR.see[i].na,135,yUI+i*8,12)
		end

		-- Show room descriptions
		rectb(3,10,122,90,12)
		for i=1,#curR.d do
			print(curR.d[i],5,8+i*11,12)
		end

		-- Show what the player own
		yUI=yUI+20
		print("I own : ",128,yUI,12)
		for i=1, #inv do
			print("["..i.."] "..inv[i].na,135,yUI+i*10,12)
		end
		-- Perform actions
		if state ==	"Normal" then
			print("Which action do you want to perform ?",10,128,12)
			if keyp(28) then --1
				state='Open'
				choice=0
				cant=false
			elseif keyp(29) then -- 2			
				state = "Take"			
			elseif keyp(30) then -- 3
				state = "Use"
				choice=0
				subchoice=0
				cant=false
			end
		elseif state=="Open" then
			if not cant then
				print("What do you wanna open ?",10,128,12)
			end
			if choice==1 then
				if curR.see[1].id=="UNLDOOR"  then
					victory = true
				else
					print("It failed to open.",10,118,12)
					print("Press 'space' to go back",15,128,12)
					cant=true
					if keyp(48) then -- Space
						state = "Normal"
					end
				end
			end
			if keyp(28) then
				choice=1
			end
		elseif state=="Take" then
			if #curR.see >0 and (curR.id=="KITCHEN" or (curR.id=="ROOM" and curR.see[1].id=="KEY")) then
				print("What do you wanna take ?",10,128,12)
				if keyp(28) then -- 1
					table.insert(inv,curR.see[1])
					table.remove(curR.see,1)
					table.remove(curR.d,#curR.d)
					table.remove(curR.d,#curR.d)
					if curR.id=="ROOM" then
						curR.d={}
					end
					state = "Normal"
				end
			else
				print("There's nothing to take here.",10,118,12)
				print("Press 'space' to go back",15,128,12)
				if keyp(48) then -- Space
					state = "Normal"
				end
			end
		elseif state=="Use" then
			if #inv >0 then
				if choice==0 then
					print("What do you wanna use ?",10,128,12)
				end
				
				if choice==1 and inv[1].id=="HAMMER" then
					if not cant then
						print("Wanna use this Hammer on what ?",10,128,12)
					end
					if keyp(28) then
						subchoice=1
					end
					if subchoice==1  then
						if curR.see[1].id=="BOX" then
							table.remove(curR.see,1)
							table.remove(inv,1)
							table.insert(curR.see,{na="A key",id="KEY"})	
							table.insert(curR.d,"You broke the box")
							table.insert(curR.d,"And found a key")							
							state="Normal"
						else
							print("You can't do that.",10,118,12)
							print("Press 'space' to go back",15,128,12)
							cant=true
							if keyp(48) then -- Space
								state = "Normal"
							end
						end				
					end
				elseif choice==1 and inv[1].id=="KEY" then
					if not cant then
						print("Wanna use this Key on what ?",10,128,12)
					end
					if keyp(28) then
						subchoice=1
					end
				
					if subchoice==1 then  
						if curR.see[1].id=="DOOR"  then
							table.remove(curR.see,1)
							table.remove(inv,1)
							table.insert(curR.see,{na="An unlocked door",id="UNLDOOR"})	
							table.insert(curR.d,"You unlocked the door")
							table.insert(curR.d,"With the key")
							state="Normal"
						else
							print("You can't do that.",10,118,12)
							print("Press 'space' to go back",15,128,12)
							cant=true
							if keyp(48) then -- Space
								state = "Normal"
							end
						end
					end
				end
				if keyp(28) then -- 1
					choice=1				
				end			
			else
				print("There's nothing to use here.",10,118,12)
				print("Press 'space' to go back",15,128,12)
				if keyp(48) then -- Space
					state = "Normal"
				end
			end
		end
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

