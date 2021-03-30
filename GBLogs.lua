frame = CreateFrame("FRAME", "frame")
frame:RegisterEvent("BANKFRAME_OPENED")
charname = UnitName("player")

function eventHandler()
	if bank == nil then
		bank = ""
	end
	if event == "BANKFRAME_OPENED" then
		bank = table.concat({bank, charname, "*"})
		local i = 0
		for bag = -1, 10 do
			local slots = GetContainerNumSlots(bag)
			for slot = 1, slots do
				local itemLink = GetContainerItemLink(bag,slot)
				if itemLink then
					local icon, itemCount = GetContainerItemInfo(bag, slot)
					local itemName = GetItemName(itemLink)
					bank = table.concat({bank, itemCount, "~", itemName, "*"})
					i = i + 1
				end
			end
		end
		bank = table.concat({bank, tostring(GetMoney()), "~Money", "$"})
		DEFAULT_CHAT_FRAME:AddMessage("Bank logs have been updated, " .. i .. " entries")
	end
end

frame:SetScript("OnEvent", eventHandler)

function GetItemName(some_string)
	local name_start = string.find(some_string, "%[") + 1
	local name_end = string.find(some_string, "%]") - 1
	return string.sub(some_string, name_start, name_end)
end


	
