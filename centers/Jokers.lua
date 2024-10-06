-- GET RID OF ALL discovered = true BEFORE PUBLISHING MOD

local chip_bag = {
    key = "chip_bag",
    loc_txt = {
        name = "Chip Bag",
        text = { "{C:chips}+#1#{} Chips" }
    },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    discovered = true,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                message = localize { type = "variable", key = "a_chips", vars = { card.ability.chips }},
                chip_mod = card.ability.chips,
                colour = G.C.CHIPS
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    set_ability = function (self, card, initial, delay_sprites)
        card.ability.chips = 50
    end
}

local final_girl = {
    key = "final_girl",
    loc_txt = {
        name = "Final Girl",
        text = { 
            "If {C:attention}final hand{} of",
            "the round is a {C:attention}#2#{},",
            "{X:mult,C:white}X#1#{} mult"
        }
    },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { x_mult = 2.5, poker_hand = 'High Card' } },
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_name == 'High Card' and G.GAME.current_round.hands_left == 0 then
            return {
                message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.RED
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.poker_hand } }
    end
}

local pop = {
    key = "pop",
    loc_txt = {
        name = "Pop Joker",
        text = {
            "This Joker gains {C:mult}+1",
            "Mult if played hand is a",
            "{C:attention}Pair, Three, or Four of a Kind",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
        }
    },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { pop_add = 0 } },
    calculate = function (self, card, context)
        if context.cardarea == G.jokers then
            if card.ability.extra.pop_add > 0 and context.joker_main then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.pop_add}},
                    mult_mod = card.ability.extra.pop_add,
                    colour = G.C.RED
                }
            end
            if (context.scoring_name == 'Pair' or context.scoring_name == 'Three of a Kind' or context.scoring_name == 'Four of a Kind' or context.scoring_name == 'Five of a Kind') and not context.blueprint and context.before then
                card.ability.extra.pop_add = 1 + card.ability.extra.pop_add
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.pop_add } }
    end
}

local pilot = {
    key = "pilot",
    loc_txt = {
        name = "Pilot Joker",
        text = {
            "Retrigger all",
            "played {C:attention}Aces"
        }
    },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { repetitions = 1 } },
    calculate = function (self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.repetitions,
                card = card
            }
        end
    end
}

return { items = {chip_bag, final_girl, pop, pilot} }