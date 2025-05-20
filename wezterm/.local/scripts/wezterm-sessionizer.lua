#!/usr/bin/env lua

local wez = require("wez")

local M = {}

local home = os.getenv("HOME")

local searchDirs = {
    home .. "/dev",
    home .. "/dev/personal",
    home .. "/dev/extern",
    home .. "/School",
}

local function findProjects(paths)
    local projs = {}

    for _, base in ipairs(paths) do
        local success, stdout, _ = wez.run_child_process({ "find", base, "-mindepth", "1", "-maxdepth", "1", "-type", "d" })

        if success then
            for line in stdout:gmatch("[^\r\n]+") do
                table.insert(projs, line)
            end
        end
    end
    table.sort(projs)
    return projs
end

local function buildMenu(projs)
    local items = {}
    for _, path in ipairs(projs) do
        local name = path:match("[^/]+)$")
        table.insert(items, { label = name, id = path })
    end
    return items
end

-- wez.on("trigger-project-launcher",
local function main(window, pane)
    local projects = findProjects()
    local menu = buildMenu(projects)

    window:perform_action(
        wez.action.PromptInputLine {
            description = "Open Project",
            action = wez.action_callback(function(_, line)
                local selected = line and line ~= "" and line or nil
                if not selected then return end

                -- If it's not a full path (typed manually), attempt to match
                for _, project_path in ipairs(projects) do
                    if project_path:match("/" .. selected .. "$") then
                        selected = project_path
                        break
                    end
                end

                if wez.target_triple:match("windows") then
                    selected = selected:gsub("/", "\\")
                end

                local project_name = selected:match("([^/\\]+)$"):gsub("%.", "_")

                window:perform_action(
                    wez.action.SpawnCommandInNewTab {
                        cwd = selected,
                        label = project_name,
                        args = { wez.shell },
                    },
                    pane
                )
            end),
        },
        pane
    )
end

main()

-- wez.action.EmitEvent("trigger-project-launcher")



return {
    keys = {
        {
            key = "P",
            mods = "CTRL|SHIFT",
            action = wez.action.EmitEvent("trigger-project-launcher"),
        },
    },

    -- Set default shell
    default_prog = { wez.shell },
}
