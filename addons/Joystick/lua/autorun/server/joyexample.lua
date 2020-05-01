if ( true ) then
	return
end
--[[
The only things you should use from a joystick register:

reg.IsJoystickReg
reg:GetValue()
reg:GetType()
reg:GetDescription()
reg:GetCategory()
reg:IsBound()
]]

-- Example registering controls
local exjcon = {}

local joyexample = function()
    util.AddNetworkString( "joystick.example" )

	exjcon.pitch = jcon.register{
		uid = "ex_1",
		type = "analog",
		description = "Pitch",
		category = "Fight Air",
	}
	
	exjcon.yaw = jcon.register{
		uid = "ex_2",
		type = "analog",
		description = "Yaw",
		category = "Fight Air",
	}
	
	exjcon.roll = jcon.register{
		uid = "ex_3",
		type = "analog",
		description = "Roll",
		category = "Fight Air",
	}
	
	exjcon.thrust = jcon.register{
		uid = "ex_4",
		type = "analog",
		description = "Thrust",
		category = "Fight Air",
	}
	
	exjcon.airbrake = jcon.register{
		uid = "ex_5",
		type = "analog",
		description = "Air brake",
		category = "Fight Air",
	}
	
	exjcon.fireprimary = jcon.register{
		uid = "ex_6",
		type = "digital",
		description = "Fire Primary",
		category = "Fight Air",
	}
	
	exjcon.firesecondary = jcon.register{
		uid = "ex_7",
		type = "digital",
		description = "Fire Secondary",
		category = "Fight Air",
	}
	
	exjcon.landinggear = jcon.register{
		uid = "ex_8",
		type = "digital",
		description = "Landing Gear",
		category = "Fight Air",
	}
	
	exjcon.beacon = jcon.register{
		uid = "ex_9",
		type = "digital",
		description = "Beacon",
		category = "Fight Air",
	}
	
	exjcon.eject = jcon.register{
		uid = "ex_10",
		type = "digital",
		description = "Eject",
		category = "Fight Air",
	}
	
	exjcon.flare = jcon.register{
		uid = "ex_11",
		type = "digital",
		description = "Flare",
		category = "Fight Air",
	}
	
	exjcon.chaff = jcon.register{
		uid = "ex_12",
		type = "digital",
		description = "Chaff",
		category = "Fight Air",
	}
	
	exjcon.shoot = jcon.register{
		uid = "ex_13",
		type = "digital",
		description = "Shoot",
		category = "Fight Ground",
	}
	
	exjcon.dive = jcon.register{
		uid = "ex_14",
		type = "digital",
		description = "Dive",
		category = "Fight Sea",
	}
	
	hook.Add( "Think", "joystick.example", function()
		for _, ply in ipairs( player.GetAll() ) do
			if ( not ply:IsConnected() ) then continue end
		
			net.Start( "joystick.example" )
				for k,v in pairs( exjcon ) do
					if ( type( v ) == "table" and v.IsJoystickReg ) then
						local val = joystick.Get( ply, v.uid )
						if ( v.type == "digital" ) then
							net.WriteUInt( 1, 3 )
							net.WriteString( v.uid )
							net.WriteBool( val or false )
						else
							net.WriteUInt( 2, 3 )
							net.WriteString( v.uid )
							net.WriteFloat( val or 0 )
						end
					end
				end
				net.WriteUInt( 0, 3 )
			net.Send( ply )
		end
	end)
end
hook.Add( "JoystickInitialize", "joyexample", joyexample )