local v1 = game:GetService("ReplicatedStorage")
require(v1.Modules.AnimationLibrary)
local v_u_2 = require(v1.Modules.ItemLibrary)
require(v1.Modules.Utility)
return {
	{
		"Equip Cooldown",
		{ "EquipCooldown" },
		"Time"
	},
	{
		"Move Speed",
		{ "WalkSpeedMultiplier" },
		"Custom",
		function(_, p3)
			if p3 == 1 then
				return "Normal"
			end
			local v4 = p3 > 1 and "+" or ""
			local v5 = (p3 - 1) * 100 + 0.5
			return v4 .. math.floor(v5) .. "%"
		end
	},
	{
		"Double Jumps",
		{ "MaxDoubleJumps" }
	},
	{
		"Damage",
		{
			"ShootDamage",
			"BurnDamage",
			"AttackDamage",
			"Damage",
			"DirectHitDamage"
		},
		"Custom",
		function(p6, p7)
			-- upvalues: (copy) v_u_2
			if p7 ~= 0 then
				local v8 = v_u_2.Items[p6]
				local v9
				if v8.ShootPellets and v8.ShootPellets > 1 then
					v9 = string.format("%.1f\195\151%s", p7 / v8.ShootPellets, v8.ShootPellets) or p7
				else
					v9 = p7
				end
				local v10 = not v8.RaycastDamageDropoffMultiplier or v8.ShootPellets and v8.ShootPellets > 1 and string.format("%.1f\195\151%s", p7 / v8.ShootPellets * v8.RaycastDamageDropoffMultiplier, v8.ShootPellets) or (string.format("%.1f", p7 * v8.RaycastDamageDropoffMultiplier) or "")
				return v9 .. (v10 == "" and v10 and v10 or " \226\134\146 " .. v10)
			end
		end
	},
	{
		"Damage Dropoff Range",
		{ "RaycastDamageDropoffStartDistance" },
		"Custom",
		function(p11, p12)
			-- upvalues: (copy) v_u_2
			return p12 .. "<font weight=\"600\" size=\"6\">studs</font> \226\134\146 " .. v_u_2.Items[p11].RaycastDamageDropoffEndDistance .. "<font weight=\"600\" size=\"6\">studs</font>"
		end
	},
	{
		"Splash Radius",
		{ "ShootExplosionRadius" },
		"Custom",
		function(_, p13)
			if p13 > 0 then
				return p13
			end
		end
	},
	{
		"Damage Per Second",
		{ "DamagePerSecond" }
	},
	{
		"Afterburn Damage",
		{ "AfterburnDamage" }
	},
	{
		"Splash Damage",
		{ "SplashDamage" }
	},
	{
		"Explosion Damage",
		{ "ExplosionDamage" }
	},
	{
		"Critical Damage",
		{ "CriticalExplosionDamage" }
	},
	{
		"Explosion Radius",
		{ "ExplosionRadius" }
	},
	{
		"Cooldown",
		{ "ShootCooldown", "AttackCooldown", "Cooldown" },
		"Time"
	},
	{
		"Spread",
		{ "ShootSpread" },
		"Custom",
		function(_, p14)
			if p14 > 0 then
				return string.format("%.1f\194\176", p14)
			end
		end
	},
	{
		"Aim Spread",
		{ "AimSpreadMultiplier" },
		"Custom",
		function(p15, p16)
			-- upvalues: (copy) v_u_2
			if p16 > 0 then
				return string.format("%.1f\194\176", v_u_2.Items[p15].ShootSpread * p16)
			end
		end
	},
	{
		"Dynamic Spread",
		{ "ShootSpreadPerVelocityUnit" },
		"Custom",
		function(_, p17)
			if p17 > 0 then
				return string.format("%0.2f\194\176", p17) .. "/studs/s"
			end
		end
	},
	{
		"Recoil",
		{ "ShootCameraDisplacementRecoil" },
		"Custom",
		function(_, p18)
			if p18.Magnitude > 0 then
				return string.format("%.0f%%", p18.X / 25 * 100)
			end
		end
	},
	{
		"Aim Recoil",
		{ "ShootCameraDisplacementRecoilWhileAiming" },
		"Custom",
		function(_, p19)
			if p19.Magnitude > 0 then
				return string.format("%.0f%%", p19.X / 25 * 100)
			end
		end
	},
	{
		"Bounces",
		{ "RaycastBounceCount" },
		"Custom",
		function(_, p20)
			if p20 > 0 then
				return p20
			end
		end
	},
	{
		"Burst",
		{ "BurstCount" },
		"Custom",
		function(_, p21)
			if p21 > 1 then
				return p21
			end
		end
	},
	{
		"Burst Delay",
		{ "BurstCooldown" },
		"Custom",
		function(_, p22)
			if p22 > 0 then
				return string.format("%.2f", p22) .. "s"
			end
		end
	},
	{
		"Fan Cooldown",
		{ "QuickShotCooldown" },
		"Time"
	},
	{
		"Attack Delay",
		{ "AttackDelay" },
		"Custom",
		function(_, p23)
			if p23 > 0 then
				return string.format("%.2f", p23) .. "s"
			end
		end
	},
	{
		"Reach",
		{ "Reach" }
	},
	{
		"Attack Reach",
		{ "AttackReach" }
	},
	{
		"Heavy Damage",
		{ "HeavyAttackDamage" }
	},
	{
		"Heavy Cooldown",
		{ "HeavyAttackCooldown" },
		"Time"
	},
	{
		"Heavy Reach",
		{ "HeavyAttackReach" }
	},
	{
		"Critical Damage",
		{ "CriticalDamage" },
		"Custom",
		function(p24, p25)
			-- upvalues: (copy) v_u_2
			if p25 ~= 0 then
				local v26 = v_u_2.Items[p24]
				local v27
				if v26.ShootPellets and v26.ShootPellets > 1 then
					v27 = string.format("%.1f\195\151%s", p25 / v26.ShootPellets, v26.ShootPellets) or p25
				else
					v27 = p25
				end
				local v28 = not v26.RaycastDamageDropoffMultiplier or v26.ShootPellets and v26.ShootPellets > 1 and string.format("%.1f\195\151%s", p25 / v26.ShootPellets * v26.RaycastDamageDropoffMultiplier, v26.ShootPellets) or (string.format("%.1f", p25 * v26.RaycastDamageDropoffMultiplier) or "")
				return v27 .. (v28 == "" and v28 and v28 or " \226\134\146 " .. v28)
			end
		end
	},
	{
		"Ammo",
		{ "MaxAmmo" },
		"Custom",
		function(p29, p30)
			-- upvalues: (copy) v_u_2
			local v31 = (p29 == "Chainsaw" or p29 == "Flamethrower") and "\226\136\158" or ((v_u_2.Items[p29].MaxAmmoReserve or 0) > 0 and v_u_2.Items[p29].MaxAmmoReserve or nil)
			return (p30 >= (1 / 0) and "\226\136\158" or p30) .. (not v31 and "" or " <font weight=\"600\" size=\"9\">" .. v31 .. "</font>")
		end
	},
	{
		"Reload",
		{ "ReloadFiles" },
		"Custom",
		function(_, p32)
			local v33 = p32.Reload
			if v33 then
				v33 = p32.Reload[1]
			end
			if v33 and v33.ActionTimestamp then
				return string.format("%.2fs", v33.ActionTimestamp)
			end
		end
	},
	{
		"Reload 2",
		{ "ReloadFiles" },
		"Custom",
		function(_, p34)
			local v35 = p34.Reload
			if v35 then
				v35 = p34.Reload[1]
			end
			local v36 = p34.Reload
			if v36 then
				v36 = p34.Reload[2]
			end
			if v36 and v36.ActionTimestamp then
				local v37 = v36.ActionTimestamp - (v35 and v35.ActionTimestamp or 0)
				if math.abs(v37) > 0.001 then
					return string.format("%.2fs", v36.ActionTimestamp)
				end
			end
		end
	},
	{
		"Empty Reload",
		{ "ReloadFiles" },
		"Custom",
		function(_, p38)
			local v39 = p38.Reload
			if v39 then
				v39 = p38.Reload[1]
			end
			local v40 = p38.EmptyReload
			if v40 then
				v40 = p38.EmptyReload[2]
			end
			if v40 and v40.ActionTimestamp then
				local v41 = v40.ActionTimestamp - (v39 and v39.ActionTimestamp or 0)
				if math.abs(v41) > 0.001 then
					return string.format("%.2fs", v40.ActionTimestamp)
				end
			end
		end
	},
	{
		"Reload",
		{ "ReloadType" },
		"Custom",
		function(_, p42)
			if p42 == "Segmented" then
				return p42
			end
		end
	},
	{
		"Ability Speed Boost",
		{ "HoldSpeedBoostMax" },
		"Custom",
		function(_, p43)
			local v44 = p43 * 100 + 0.5
			return "+" .. math.floor(v44) .. "%"
		end
	},
	{
		"Ability Damage Per Second",
		{ "HoldDamageMultiplier" },
		"Custom",
		function(p45, _)
			-- upvalues: (copy) v_u_2
			return v_u_2.Items[p45].AttackDamage * v_u_2.Items[p45].HoldDamageMultiplier
		end
	},
	{
		"Airblast Cooldown",
		{ "AirblastCooldown" },
		"Time"
	},
	{
		"Long Heal",
		{ "LongHeal", "Heal" }
	},
	{
		"Long Heal Time",
		{ "LongActionTimestamp" },
		"Time"
	},
	{
		"Quick Heal",
		{ "QuickHeal" }
	},
	{
		"Quick Heal Time",
		{ "QuickActionTimestamp" },
		"Time"
	},
	{
		"Fire Radius",
		{ "FireRadius" }
	},
	{
		"Fire Lifetime",
		{ "FireDuration" },
		"Time"
	},
	{
		"Blind Duration",
		{ "BlindDuration" },
		"Time"
	},
	{
		"Smoke Radius",
		{ "SmokeRadius" }
	},
	{
		"Smoke Lifetime",
		{ "SmokeDuration" },
		"Time"
	},
	{
		"Deflect Cooldown",
		{ "DeflectCooldown" },
		"Time"
	},
	{
		"Deflect Duration",
		{ "DeflectDuration" },
		"Time"
	},
	{
		"Blade Cooldown",
		{ "BladeCooldown" },
		"Time"
	},
	{
		"Blade Reach",
		{ "BladeReach" }
	},
	{
		"Blade Damage",
		{ "BladeDamage" }
	},
	{
		"Blade Critical Damage",
		{ "BladeCriticalDamage" }
	},
	{
		"Dash Cooldown",
		{ "DashCooldown" },
		"Time"
	},
	{
		"Build Cooldown",
		{ "BuildCooldown" },
		"Time"
	},
	{
		"Build Reach",
		{ "BuildReach" }
	},
	{
		"Max Bricks",
		{ "MaxBricks" }
	},
	{
		"Brick Lifetime",
		{ "BrickLifetime" },
		"Time"
	},
	{
		"Full Charge Time",
		{ "ChargeLevelTimestamps" },
		"Custom",
		function(_, p46)
			return string.format("%.2fs", p46[#p46])
		end
	},
	{
		"Full Charge Damage",
		{ "ChargeLevelDamageMultipliers" },
		"Custom",
		function(p47, p48)
			-- upvalues: (copy) v_u_2
			return string.format("%.0f", v_u_2.Items[p47].ShootDamage * p48[#p48])
		end
	},
	{
		"Charge Damage",
		{ "ChargeDamage" }
	},
	{
		"Charge Knockback",
		{ "ChargeKnockbackForce" }
	},
	{
		"Charge Time",
		{ "ChargeIntro" },
		"Time"
	},
	{
		"Detonate Delay",
		{ "DetonateDelay" },
		"Time"
	},
	{
		"Splash Radius",
		{ "SplashRadius" }
	},
	{
		"Speed Boost",
		{ "SpeedBoost" },
		"Custom",
		function(_, p49)
			local v50 = p49 * 100 + 0.5
			return "+" .. math.floor(v50) .. "%"
		end
	},
	{
		"Speed Duration",
		{ "SpeedBoostDuration" },
		"Time"
	},
	{
		"Spin Damage",
		{ "SpinDamage" }
	},
	{
		"Spin Radius",
		{ "SpinRadius" }
	},
	{
		"Spin Cooldown",
		{ "SpinCooldown" },
		"Time"
	},
	{
		"Charging Windup Time",
		{ "ChargingWindUpLength" },
		"Time"
	},
	{
		"Charging Move Speed",
		{ "ChargingSpeedBoost" },
		"Custom",
		function(_, p51)
			if p51 == 0 then
				return "Normal"
			end
			local v52 = p51 > 0 and "+" or ""
			local v53 = p51 * 100 + 0.5
			return v52 .. math.floor(v53) .. "%"
		end
	},
	{
		"Vortex Cooldown",
		{ "VortexCooldown" },
		"Time"
	},
	{
		"Vortex Radius",
		{ "VortexRadius" }
	},
	{
		"Vortex Lifetime",
		{ "VortexLifetime" },
		"Time"
	},
	{
		"Knockback",
		{ "KnockbackForce" }
	},
	{
		"Slam Cooldown",
		{ "SlamCooldown" },
		"Time"
	},
	{
		"Slam Damage",
		{ "SlamDamage" }
	},
	{
		"Slam Radius",
		{ "SlamRadius" }
	},
	{
		"Minimum Slam Altitude",
		{ "SlamFloorDistance" },
		"Custom",
		function(_, p54)
			return p54 .. "studs"
		end
	},
	{
		"Slow Duration",
		{ "SlowDuration" },
		"Time"
	},
	{
		"Slow",
		{ "SlowBoost" },
		"Custom",
		function(_, p55)
			local v56 = p55 * 100 + 0.5
			return math.floor(v56) .. "%"
		end
	},
	{
		"Max Slow",
		{ "MaxSlowBoost" },
		"Custom",
		function(_, p57)
			local v58 = p57 * 100 + 0.5
			return math.floor(v58) .. "%"
		end
	},
	{
		"Max Slow Stacks",
		{ "MaxSlowStacks" }
	},
	{
		"Max Freeze Duration",
		{ "MaxFreezeDuration" },
		"Time"
	},
	{
		"Freeze Duration",
		{ "FreezeDuration" },
		"Time"
	},
	{
		"Miss Cooldown",
		{ "MissedCooldown" },
		"Time"
	},
	{
		"Hook Speed",
		{ "HookSpeed" }
	},
	{
		"Hook Range",
		{ "HookRange" }
	},
	{
		"Pull Speed",
		{ "SelfPullForce" }
	},
	{
		"Enemy Pull Speed",
		{ "EnemyPullForce" }
	},
	{
		"Throw Cooldown",
		{ "ThrowCooldown" },
		"Time"
	},
	{
		"Throw Damage",
		{ "ThrowDamage" }
	},
	{
		"Throw Radius",
		{ "ThrowRadius" }
	},
	{
		"Critical Throw Damage",
		{ "CriticalThrowDamage" }
	},
	{
		"Throw Knockback",
		{ "ThrowKnockbackForce" }
	},
	{
		"Thrown Spear Length",
		{ "ThrownSpearLength" }
	},
	{
		"Thrown Spear Lifetime",
		{ "ThrownSpearLifetime" },
		"Time"
	},
	{
		"Grenade Cooldown",
		{ "GrenadeCooldown" },
		"Time"
	},
	{
		"Grenade Explosion Radius",
		{ "GrenadeExplosionRadius" }
	},
	{
		"Grenade Splatter Lifetime",
		{ "GrenadeSplatterDuration" },
		"Time"
	},
	{
		"Max Health",
		{ "MaxAbsorption" }
	},
	{
		"Damage Reduction",
		{ "AbsorptionPercent" },
		"Custom",
		function(_, p59)
			local v60 = p59 * 100 + 0.5
			return math.floor(v60) .. "%"
		end
	},
	{
		"Lifetime",
		{ "Lifetime" },
		"Time"
	},
	{
		"Holodome Radius",
		{ "HolodomeRadius" }
	},
	{
		"Projector Health",
		{ "ProjectorHealth" }
	},
	{
		"Dynamic Auto Shoot",
		{ "AutoShootReactionTime" },
		"Custom",
		function(_, p61)
			-- upvalues: (copy) v_u_2
			if p61 >= 0 then
				local v62 = string.format
				local v63 = v_u_2.AUTO_SHOOT_REACTION_TIME_MIN
				local v64 = v_u_2.AUTO_SHOOT_REACTION_TIME_MAX
				return v62("%.0f", math.clamp(p61, v63, v64) * 1000) .. "ms"
			end
		end
	}
}