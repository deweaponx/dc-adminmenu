local vehicles = {}
-- Original function without sort

local function OpenCarModelsMenu(category)
    VehNameMenu:ClearItems()
    MenuV:OpenMenu(VehNameMenu)
    for k, v in pairs(category) do
        VehNameMenu:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function()
                TriggerServerEvent('qb-admin:server:spawnVehicle', k)
            end
        })
    end
end

-- Adding sort
-- local function OpenCarModelsMenu(category)

--     VehNameMenu:ClearItems()
--     MenuV:OpenMenu(VehNameMenu)

--     local categories = {}

--     for k, v in pairs(category) do
--         table.insert(categories, {k,v})
--     end

--     table.sort(categories, function(a, b)
--         return a.name < b.name
--     end)

--     for i, n in ipairs(categories) do
--         VehNameMenu:AddButton({
--             label = n["name"],
--             value = i,
--             description = 'Spawn ' .. n["name"],
--             select = function()
--                 TriggerServerEvent('qb-admin:server:spawnVehicle', i)
--             end
--         })
--     end
-- end

VehicleMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = VehCategorieMenu,
    description = Lang:t("desc.spawn_vehicle_desc"),
    select = function()
        VehCategorieMenu:ClearItems()
        for k, v in pairs(QBCore.Shared.Vehicles) do
            local category = v["category"]
            if vehicles[category] == nil then
                vehicles[category] = { }
            end
            vehicles[category][k] = v
        end
        for k, v in pairs(vehicles) do
            VehCategorieMenu:AddButton({
                label = k,
                value = v,
                description = Lang:t("menu.category_name"),
                select = function(btn)
                    local select = btn.Value
                    OpenCarModelsMenu(select)
                end
            })
        end
    end
})

VehicleMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    description = Lang:t("desc.fix_vehicle_desc"),
    select = function()
        TriggerServerEvent('QBCore:CallCommand', "fix", {})
    end
})

VehicleMenu:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    description = Lang:t("desc.buy_desc"),
    select = function()
        TriggerServerEvent('QBCore:CallCommand', "admincar", {})
    end
})

VehicleMenu:AddButton({
    icon = '☠',
    label = Lang:t("menu.remove_vehicle"),
    description = Lang:t("desc.remove_vehicle_desc"),
    select = function()
        TriggerServerEvent('QBCore:CallCommand', "dv", {})
    end
})

VehicleMenu:AddButton({
    icon = '🛠️',
    label = Lang:t("menu.tune_car"),
    description = Lang:t("desc.tune_car"),
    select = function()
        local ped = PlayerPedId()
        local override = {
            coords = GetEntityCoords(ped),
            heading = GetEntityHeading(ped),
            categories = {
                mods = true,
                repair = true,
                armor = true,
                respray = true,
                liveries = true,
                wheels = true,
                tint = true,
                plate = true,
                extras = true,
                neons = true,
                xenons = true,
                horn = true,
                turbo = true,
                cosmetics = true,
            },
        }
        TriggerEvent('qb-customs:client:EnterCustoms', override)
        MenuV:CloseAll()
    end
})

VehicleMenu:AddButton({
    icon = '⚡️',
    label = Lang:t("menu.max_mods"),
    description = Lang:t("desc.max_mods_desc"),
    select = function()
        TriggerServerEvent('QBCore:CallCommand', "maxmods", {})
        --TriggerServerEvent('qb-admin:server:maxmodVehicle', src)
    end
})

VehicleMenu:AddButton({
    icon = '🪧',
    label = Lang:t("menu.plate_car"),
    description = Lang:t("desc.plate_car"),
    select = function()
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.plate_car"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "GEB654TY",
                    name = "plate",
                    type = "text",
                    isRequired = true
                }
            }
        })
        if dialog then
            TriggerServerEvent('qb-admin:server:vehicleplate', dialog.plate)
        end
    end
})
