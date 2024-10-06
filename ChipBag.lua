--- STEAMODDED HEADER
--- MOD_NAME: Chip Bag
--- MOD_ID: ChipBag
--- MOD_AUTHOR: [WhatJoSaid]
--- MOD_DESCRIPTION: A collection of vanilla-like additions to Balatro.
--- PREFIX: cbag
--- VERSION: 0.1.0

----------------------------------------------
------------MOD CODE -------------------------

local config = {
    -- Common Jokers
    j_cbag_chipbag = true,
    j_cbag_pop = true,
    j_cbag_finalgirl = true,
    j_cbag_scalper = true,
    j_cbag_uno = true,
    j_cbag_pencil = true,
    -- Uncommon Jokers
    j_cbag_please = true,
    j_cbag_bagsbunny = true,
    j_cbag_fancypants = true,
    j_cbag_recon = true,
    j_cbag_transfer = true,
    j_cbag_ddecker = true,
    -- Rare Jokers
    j_cbag_excavator = true,
    j_cbag_judge = true,
    j_cbag_musicbox = true,
    j_cbag_polydactyly = true,
    -- Legendary Jokers
    j_cbag_lucretia = true
}

-- Load Jokers
local function load_jokers()
    local j, e = SMODS.load_file("centers/Jokers.lua")
    if e then print("Error loading files! Reason: "..e) else
        local jokers = j()
        for i, v in ipairs(jokers.items) do
            SMODS.Joker(v)
        end
    end
end

load_jokers()