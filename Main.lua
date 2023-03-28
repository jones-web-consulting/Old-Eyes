local Frame = CreateFrame("Frame")
local SCALE_VALUE = 1.25;

-- Event Registration
Frame:RegisterEvent("PLAYER_LOGIN")
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LOGOUT")

OldEyes = {};
OldEyes.panel = CreateFrame("Frame", "Old Eyes", UIParent);
OldEyes.panel.name = "Old Eyes";
InterfaceOptions_AddCategory(OldEyes.panel);

ScaleMerchFrameCheckButton = CreateFrame("CheckButton", "ScaleMerchFrameCheckButton_GlobalName", OldEyes.panel, "InterfaceOptionsCheckButtonTemplate");
ScaleMerchFrameCheckButton:SetPoint("TOPLEFT", 32, -32);
ScaleMerchFrameCheckButton_GlobalNameText:SetText("Scale Merchant Frame (Requires UI Reload)");
ScaleMerchFrameCheckButton.tooltip = "Sets whether or not to scale the merchant frame.";
 
ScaleMerchFrameCheckButton:SetScript("OnClick", 
function()

	ScaleMerchantFrame = ScaleMerchFrameCheckButton:GetChecked();

end
);

-- arg1 is the addon name.
Frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "Old Eyes" then

		-- If no saved data for the addon variable...
		if ScaleMerchantFrame == nil then

			ScaleMerchantFrame = true; -- Set default value.

		end
	
		-- If there is saved data for the addon variable, use it to update the check button.
		ScaleMerchFrameCheckButton:SetChecked(ScaleMerchantFrame);

		elseif event == "PLAYER_LOGOUT" then

			-- Save changes so they can be restored during the next gaming session.
			ScaleMerchantFrame = ScaleMerchFrameCheckButton:GetChecked();

		elseif event == "PLAYER_LOGIN" then

			QuestFrame:SetScale(SCALE_VALUE);		-- Quest Text
			GossipFrame:SetScale(SCALE_VALUE);		-- Gossip/Speaking ??
			ItemTextFrame:SetScale(SCALE_VALUE);	-- Books

			-- Scale merchant frame if player requests it.
			if (ScaleMerchantFrame == true) then

				MerchantFrame:SetScale(SCALE_VALUE);

			end

			-- Display the copyright and version line in chat.
			print("Old Eyes (2.0) Loaded. Developed by Kenneth R. Jones.");
		end
	end
)