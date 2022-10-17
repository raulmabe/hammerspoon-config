local wifiMenu = hs.menubar.new()

function ssidChangedCallback()
    SSID = hs.wifi.currentNetwork()

    if SSID == nil then
        SSID = "Disconnected"
    end

    wifiMenu:setTitle( SSID )
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
ssidChangedCallback()


function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
