--------О скрипте--------
script_name('Miku Project Reborn')
script_version('0.8.2')
script_author('t.me/mikureborn')
script_description('MultiCheat named *Miku* for Arizona Mobile. Type /miku to open menu. Our channel: t.me/mikureborn')
--------Библиотеки--------
local imgui = require 'mimgui'
local fa = require 'fAwesome6_solid'
local mem = require 'memory'
local events = require 'samp.events'
local ffi = require 'ffi' 
local effil = require 'effil'
local sf = require 'sampfuncs'
local monet = require 'MoonMonet'
local inicfg = require 'inicfg'
local Vector3D = require 'vector3d'
local widgets = require 'widgets'
local memory = require 'memory'
local raknet = require 'samp.raknet'
local ltn12 = require 'ltn12'
local http = require 'socket.http'
--------Кодировка--------
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
--------Конфиг--------
local directIni = 'MikuProject.ini'
local ini = inicfg.load({
    silent = {
        salo = (false),
        canSee = (true),
        radius = (100),
        ignoreCars = (true),
        distance = (500),
        useWeaponRadius = (true),
        useWeaponDistance = (true),
        ignoreObj = (true),
        line = (true),
        circle = (true),
        fpscircle = (true),
        printString = (true),
        misses = (false),
        miss_ratio = (3),
        removeAmmo = (false),
        doubledamage = (false),
        tripledamage = (false),
        offsetx = (0.0),
        offsety = (0.0)
    },
    cfg = {
        autosave = (false)
    },
    theme = {
        moonmonet = (759410733)
    },
    ESP = {
        enabled_boxes = (false),
        enabled_bones = (false),
        enabled_nicks = (false),
        enabled_lines = (false),
        boxthinkness = (0.005),
        skeletonthinkness = (3),
        nicknamesize = (0.0180),
        lineposition = (0),
        linethinkness = (2)
    },
    main = {
        airbrakewidget = (false),
        clickwarpcoord = (false),
        quitinformer = (false),
        informerinstream = (false),
        gzinfo = (false),
        gzposx = (30),
        gzposy = (500),
        gzsize = (13),
        gzname = (false),
        offdontflood = (false),
        radiuslavki = (false)
    },
    ped = {
        godmode_enabled = (false),
        noreload = (false),
        setskills = (false),
        animspeed = (false),
        hpbar = (false),
        speedint = (1),
        rapidfire = (false),
        rapidint = (1),
        skinid = (0),
        cjrun = (false),
        autoplusc = (false),
        infiniterun = (false),
    },
    car = {
        godmode2_enabled = (false),
        flycar = (false),
        nobike = (false),
        drift = (false),
        slappower2 = (0),
        atrradius = (150),
        atractive = (false),
        antisync = (false)
    },
    render = {
        ruda = (false),
        narkotiki = (false),
        podarok = (false),
        musortsr = (false),
        kladrender = (false),
        yabloki = (false),
        slivu = (false),
        kokosi = (false),
        derevovishkac = (false),
        semena = (false),
        graffiti = (false),
        rtime = (370),
        mtrsize = (10)
    },
    menu = {
        slideropenbuttonwidth = (100),
        slideropenbuttonheight = (95),
        openbutton = (true),
        onechildwidth = (130),
        onechildheight = (433),
        twochildwidth = (677),
        twochildheight = (433),
        onechildposx = (11),
        onechildposy = (32),
        twochildposx = (152),
        twochildposy = (32),
        menuwidth = (845),
        menuheight = (482),
        sendalt = (false),
        sendaltwidth = (180),
        sendaltheight = (50),
        showinfo = (true),
        samelinetabs = (false),
        tabswidth = (140),
        tabsheight = (40)
    },
    dgun = {
        gunsList = (0),
        ammo = (500)
    },
    teleport = {
        tpwait = (1000),
        tpbar = (true),
        infosize = (12),
        tpwaiting = (1000),
        x = (10),
        y = (400)
    },
    objects = {
        autormlsa = (false),
        autormsfa = (false),
        autormblockpost = (false)
    },
    tsr = {
        tsrbotwait = (1200),
        autormcell = (false),
        autormdoors = (false),
        autormfence = (false)
    },
    tglogger = {
        state = (false),
        chat_id = (''),
        token = (''),
        updateid = ('')
    }
}, directIni)
inicfg.save(ini, directIni)

local settings = {
    silent = {
        salo = imgui.new.bool(ini.silent.salo),
        canSee = imgui.new.bool(ini.silent.canSee),
        radius = imgui.new.int(ini.silent.radius),
        ignoreCars = imgui.new.bool(ini.silent.ignoreCars),
        distance = imgui.new.int(ini.silent.distance),
        useWeaponRadius = imgui.new.bool(ini.silent.useWeaponRadius),
        useWeaponDistance = imgui.new.bool(ini.silent.useWeaponDistance),
        ignoreObj = imgui.new.bool(ini.silent.ignoreObj),
        line = imgui.new.bool(ini.silent.line),
        circle = imgui.new.bool(ini.silent.circle),
        fpscircle = imgui.new.bool(ini.silent.fpscircle),
        printString = imgui.new.bool(ini.silent.printString),
        misses = imgui.new.bool(ini.silent.misses),
        miss_ratio = imgui.new.int(ini.silent.miss_ratio),
        removeAmmo = imgui.new.bool(ini.silent.removeAmmo),
        doubledamage = imgui.new.bool(ini.silent.doubledamage),
        tripledamage = imgui.new.bool(ini.silent.tripledamage),
        offsetx = imgui.new.float(ini.silent.offsetx),
        offsety = imgui.new.float(ini.silent.offsety)
    },
    ESP = {
        enabled_bones = imgui.new.bool(ini.ESP.enabled_bones),
        enabled_boxes = imgui.new.bool(ini.ESP.enabled_boxes),
        enabled_nicks = imgui.new.bool(ini.ESP.enabled_nicks),
        enabled_lines = imgui.new.bool(ini.ESP.enabled_lines),
        boxthinkness = imgui.new.float(ini.ESP.boxthinkness),
        skeletonthinkness = imgui.new.int(ini.ESP.skeletonthinkness),
        nicknamesize = imgui.new.float(ini.ESP.nicknamesize),
        lineposition = imgui.new.int(ini.ESP.lineposition),
        linethinkness = imgui.new.int(ini.ESP.linethinkness)
    },
    main = {
        airbrakewidget = imgui.new.bool(ini.main.airbrakewidget),
        clickwarpcoord = imgui.new.bool(ini.main.clickwarpcoord),
        quitinformer = imgui.new.bool(ini.main.quitinformer),
        informerinstream = imgui.new.bool(ini.main.informerinstream),
        gzinfo = imgui.new.bool(ini.main.gzinfo),
        gzsize = imgui.new.int(ini.main.gzsize),
        gzname = imgui.new.bool(ini.main.gzname),
        offdontflood = imgui.new.bool(ini.main.offdontflood),
        radiuslavki = imgui.new.bool(ini.main.radiuslavki)
    },
    ped = {
        godmode_enabled = imgui.new.bool(ini.ped.godmode_enabled),
        noreload = imgui.new.bool(ini.ped.noreload),
        setskills = imgui.new.bool(ini.ped.setskills),
        animspeed = imgui.new.bool(ini.ped.animspeed),
        hpbar = imgui.new.bool(ini.ped.hpbar),
        speedint = imgui.new.int(ini.ped.speedint),
        rapidfire = imgui.new.bool(ini.ped.rapidfire),
        rapidint = imgui.new.int(ini.ped.rapidint),
        skinid = imgui.new.int(ini.ped.skinid),
        cjrun = imgui.new.bool(ini.ped.cjrun),
        autoplusc = imgui.new.bool(ini.ped.autoplusc),
        infiniterun = imgui.new.bool(ini.ped.infiniterun)
    },
    car = {
        godmode2_enabled = imgui.new.bool(ini.car.godmode2_enabled),
        flycar = imgui.new.bool(ini.car.flycar),
        nobike = imgui.new.bool(ini.car.nobike),
        drift = imgui.new.bool(ini.car.drift),
        slappower2 = imgui.new.int(ini.car.slappower2),
        atrradius = imgui.new.int(ini.car.atrradius),
        atractive = imgui.new.bool(ini.car.atractive),
        antisync = imgui.new.bool(ini.car.antisync)
    },
    render = {
        ruda = imgui.new.bool(ini.render.ruda),
        narkotiki = imgui.new.bool(ini.render.narkotiki),
        podarok = imgui.new.bool(ini.render.podarok),
        musortsr = imgui.new.bool(ini.render.musortsr),
        kladrender = imgui.new.bool(ini.render.kladrender),
        yabloki = imgui.new.bool(ini.render.yabloki),
        slivu = imgui.new.bool(ini.render.slivu),
        kokosi = imgui.new.bool(ini.render.kokosi),
        derevovishkac = imgui.new.bool(ini.render.derevovishkac),
        semena = imgui.new.bool(ini.render.semena),
        graffiti = imgui.new.bool(ini.render.graffiti),
        rtime = imgui.new.int(ini.render.rtime),
        mtrsize = imgui.new.int(ini.render.mtrsize)
    },
    menu = {
        slideropenbuttonwidth = imgui.new.int(ini.menu.slideropenbuttonwidth),
        slideropenbuttonheight = imgui.new.int(ini.menu.slideropenbuttonheight),
        openbutton = imgui.new.bool(ini.menu.openbutton),
        onechildwidth = imgui.new.int(ini.menu.onechildwidth),
        onechildheight = imgui.new.int(ini.menu.onechildheight),
        twochildwidth = imgui.new.int(ini.menu.twochildwidth),
        twochildheight = imgui.new.int(ini.menu.twochildheight),
        onechildposx = imgui.new.int(ini.menu.onechildposx),
        onechildposy = imgui.new.int(ini.menu.onechildposy),
        twochildposx = imgui.new.int(ini.menu.twochildposx),
        twochildposy = imgui.new.int(ini.menu.twochildposy),
        menuwidth = imgui.new.int(ini.menu.menuwidth),
        menuheight = imgui.new.int(ini.menu.menuheight),
        sendalt = imgui.new.bool(ini.menu.sendalt),
        sendaltwidth = imgui.new.int(ini.menu.sendaltwidth),
        sendaltheight = imgui.new.int(ini.menu.sendaltheight),
        showinfo = imgui.new.bool(ini.menu.showinfo),
        samelinetabs = imgui.new.bool(ini.menu.samelinetabs),
        tabswidth = imgui.new.int(ini.menu.tabswidth),
        tabsheight = imgui.new.int(ini.menu.tabsheight)
    },
    dgun = {
        gunsList = imgui.new.int(ini.dgun.gunsList),
        ammo = imgui.new.int(ini.dgun.ammo)
    },
    teleport = {
        tpwait = imgui.new.int(ini.teleport.tpwait),
        infosize = imgui.new.int(ini.teleport.infosize)
    },
    objects = {
        autormlsa = imgui.new.bool(ini.objects.autormlsa),
        autormsfa = imgui.new.bool(ini.objects.autormsfa),
        autormblockpost = imgui.new.bool(ini.objects.autormblockpost)
    },
    tsr = {
        tsrbotwait = imgui.new.int(ini.tsr.tsrbotwait),
        autormcell = imgui.new.bool(ini.tsr.autormcell),
        autormdoors = imgui.new.bool(ini.tsr.autormdoors),
        autormfence = imgui.new.bool(ini.tsr.autormfence)
    },
    tglogger = {
        state = imgui.new.bool(ini.tglogger.state)
    },
    cfg = {
        autosave = imgui.new.bool(ini.cfg.autosave)
    }
}
--      buffers     --
-- Меню
local tab = 1
local SCREEN_W, SCREEN_H = getScreenResolution()
local new = imgui.new
local window_scale = imgui.new.float(1.0)
local window_state = new.bool()
local custommimguiStyle = new.bool()
local menusettings = new.bool()
local found_update = new.bool()
-- auto updates
local lmPath = "Miku Project Reborn.lua"
local lmUrl = "https://raw.githubusercontent.com/MikuImpulse/Miku-Lua-AutoUpdates/main/Miku%20Project%20Reborn.lua"
-- tpall
local nop = false
local tpidstate = false
local skip = {}
-- togglebutton
local AI_TOGGLE = {}
local ToU32 = imgui.ColorConvertFloat4ToU32
-- tir bot
local tirst = false
local sight = false
local targets = {}
-- green zone render
local gzfont = renderCreateFont("Arial", settings.main.gzsize[0], 5)
local gz = '65535'
-- tsr rage bot
local tsrragebot = imgui.new.bool(false)
local botstep = -1
local box = 0
-- quit informer
reasons = {
    [0] = 'потеря связи/краш',
    [1] = '/q',
    [2] = 'кикнул сервер/забанил'
}
-- mine time render (mtr)
local rtime = settings.render.rtime[0]
local mtrfont, mtract,start,resources,pool_mrkr, pool_marker, pool_chkpnt = renderCreateFont('Arial', settings.render.mtrsize[0], 5), false, nil, {}, {}, {}, {}
-- attach trailer
atrtrailer = nil
-- zTeleport
local zettp = false
local tp_dist = 175
local waiting = ini.teleport.tpwaiting
local percent = 0
local tpfont = renderCreateFont('NAMU PRO', settings.teleport.infosize[0], 4)
local zettpincar, tpbar = false, ini.teleport.tpbar
local editposs = false
-- hpbar
activebar = 1
-- dgun combo
local item_list = {u8'Кулак', u8'Кастет', u8'Клюшка для гольфа', u8'Полицейская дубинка', u8'Нож', u8'Бейсбольная бита', u8'Лопата', u8'Кий', u8'Катана', u8'Бензопила', u8'Двухсторонний дилдо', u8'Дилдо', u8'Вибратор', u8'Серебряный вибратор', u8'Букет цветов', u8'Трость', u8'Граната', u8'Слезоточивый газ', u8'Коктейль Молотова', u8' ', u8' ', u8' ', u8'Пистолет', u8'USP-S (Тазер)', u8'Desert Eagle', u8'Дробовик', u8'Обрез', u8'Скорострельный дробовик', u8'UZI', u8'MP5', u8'Калаш', u8'М4', u8'TEC-9', u8'Охотничье ружье', u8'Снайперка', u8'РПГ', u8'Самонаводящееся РПГ', u8'Огнемет', u8'Миниган', u8'Сумка с тротилом', u8'Детонатор', u8'Баллончик', u8'Огнетушитель', u8'Фотоаппарат', u8'Очки ночного видения', u8'Тепловизор', u8'Парашют'}
local ImItems = imgui.new['const char*'][#item_list](item_list)
-- bot zavod
local coordinates = {{2558.9885253906, -1287.6723632813},{2558.4392089844, -1291.0050048828},{2558.6960449219, -1291.0054931641}, {2559.0173339844, -1290.9860839844}, {2560.0126953125, -1290.7293701172}, {2561.068359375, -1290.697265625}, {2564.4611816406, -1292.9296875}}
local armorbotstate, armorbotalt, point, setrounds, currentrounds, detal1, detal2, idb = false, false, 0, -1, 0, -1, -1, -1
local krugibota = imgui.new.int(0)
-- clickwarp coordmaster
local chooseActive, pointMarker, renderInfo
local tpclick, sync = false, false
local packets = 0
-- alt
local floodalt = imgui.new.bool(false)
-- gmcar lastcar buffer
local GodModeCar = {
    last_car = nil
}
-- Реконнект
local Reconnect = {
    delay = new.float(0),
    abort = false,
    waiting = false,
    remaining = 0,
    reconnecting = true
}
-- Время и погода
local WeatherAndTime = {
    weather = new.int(0),
    time = new.int(0),
    locked_time = 0,
    new_time = false,
    thread = nil
}
-- Флайкар
local FlyCar = {
    cars = 0
}
local wwwflycar = false
-- Рендер font
local font = renderCreateFont('NAMU PRO', 25, 26)
-- esp fonts, bones
local ESP2 = {
  BONES = { 3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2 },
  FONT = renderCreateFont('Arial', SCREEN_H * settings.ESP.nicknamesize[0], 1 + 4)
}
-- silent
local targetId = -1

local miss = false

local ped = nil
local fakemode = imgui.new.bool(false)

math.randomseed(os.time())

local w, h = getScreenResolution()

function getpx()
	return ((w / 2) / getCameraFov()) * settings.silent.radius[0]
end

local silentfovcolor = {
    colornew = imgui.ImVec4(0.00, 1.00, 0.00, 1.00)
}
-- render objects
local ruda1 = {
	[854] = 'Руда',
}

local narko = {
	[1575] = 'Закладка',
	[1580] = 'Закладка',
	[1576] = 'Закладка',
	[1577] = 'Закладка',
	[1578] = 'Закладка',
	[1579] = 'Закладка',
}

local gift = {
    [19054] = 'Подарок',
    [19055] = 'Подарок',
    [19056] = 'Подарок',
    [19057] = 'Подарок',
    [19058] = 'Подарок',
}

local musor = {
    [2670] = 'Мусор',
    [2673] = 'Мусор',
    [2674] = 'Мусор',
    [2677] = 'Мусор',
}

local klad = {
    [2680] = 'Клад',
    [16317] = 'Клад',
    [1271] = 'Клад',
    [16302] = 'Клад',
}

local semenanarko = {
	[859] = 'Семена нарко',
}

local derevovish = {
	[729] = 'Дерево высшего качества',
}

local apple = {
	[19576] = 'Яблоко (или слива)',
    [895] = 'Яблочное дерево'
}

local sliva = {
	[19576] = "Apple-Sliva",
    [883] = "Sliva Tree"
}

local kokos = {
	[19344] = 'Кокос',
    [674] = 'Кокосовое дерево'
}

local graffity = {
    [1490] = 'Граффити',
    [1524] = 'Граффити',
    [1525] = 'Граффити',
    [1526] = 'Граффити',
    [1527] = 'Граффити',
    [1528] = 'Граффити',
    [1529] = 'Граффити',
    [1530] = 'Граффити',
    [1531] = 'Граффити',
    [14840] = 'Граффити',
    [17969] = 'Граффити',
    [18659] = 'Граффити',
    [18660] = 'Граффити',
    [18661] = 'Граффити',
    [18662] = 'Граффити',
    [18663] = 'Граффити',
    [18664] = 'Граффити',
    [18665] = 'Граффити',
    [18666] = 'Граффити',
    [18667] = 'Граффити'
}
-- ffi get handle bones
local gta = ffi.load('GTASA')
ffi.cdef[[
  typedef struct RwV3d {
    float x, y, z;
  } RwV3d;
  // void CPed::GetBonePosition(CPed *this, RwV3d *posn, uint32 bone, bool calledFromCam) - Mangled name
  void _ZN4CPed15GetBonePositionER5RwV3djb(void* thiz, RwV3d* posn, uint32_t bone, bool calledFromCam);
]]

function getBonePosition(ped, bone)
  local pedptr = ffi.cast('void*', getCharPointer(ped))
  local posn = ffi.new('RwV3d[1]')
  gta._ZN4CPed15GetBonePositionER5RwV3djb(pedptr, posn, bone, false)
  return posn[0].x, posn[0].y, posn[0].z
end

----Imgui OnInitialize----
imgui.OnInitialize(function()
  	fa.Init()
    local tmp = imgui.ColorConvertU32ToFloat4(ini.theme['moonmonet'])
	gen_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
	mmcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
	apply_n_t()
end)
  
-- GodMode Car
gmcar_activate = function()
    lua_thread.create(function()
        while true do wait(0)
            if not settings.car.godmode2_enabled[0] then
                gmcar_reset()
            end
            if isCharInAnyCar(PLAYER_PED) then
                setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), true, true, true, true, true)
            end
        end
    end)
end
  
gmcar_reset = function()
    lua_thread.create(function()
        while true do wait(0)
            if isCharInAnyCar(PLAYER_PED) then
                setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), false, false, false, false, false)
            end
        end
    end)
end

-- Reconnect
Reconnect.activate = function()
    lua_thread.create(function()
        local ms = 500 + Reconnect.delay[0] * 1000
        if ms <= 0 then
            ms = 100
        end
        notf('Реконнектимся..', -1)
        Reconnect.waiting = true
        while ms > 0 do
            if ms <= 500 then
                Reconnect.waiting = false
                local bs = raknetNewBitStream()
                raknetBitStreamWriteInt8(bs, sf.PACKET_DISCONNECTION_NOTIFICATION)
                raknetSendBitStreamEx(bs, sf.SYSTEM_PRIORITY, sf.RELIABLE, 0)
                raknetDeleteBitStream(bs)
            end
            if Reconnect.waiting and Reconnect.abort then
                Reconnect.waiting = false
                Reconnect.abort = false
                return
            end
            Reconnect.abort = false
            Reconnect.remaining = ms
            wait(100)
            ms = ms - 100
        end
        Reconnect.waiting = false
        Reconnect.reconnecting = true
        bs = raknetNewBitStream()
        raknetEmulPacketReceiveBitStream(sf.PACKET_CONNECTION_LOST, bs)
        raknetDeleteBitStream(bs)
    end)
end
  
-- FlyCar
FlyCar.processFlyCar = function()
    local car = storeCarCharIsInNoSave(PLAYER_PED)
    local speed = getCarSpeed(car)
    local result, var_1, var_2 = isWidgetPressedEx(WIDGET_VEHICLE_STEER_ANALOG, 0)
    if result then
        local var_1 = var_1 / -64.0
        local var_2 = var_2 / 64.0
        setCarRotationVelocity(car, var_2, 0.0, var_1)
    end
    if isWidgetPressed(WIDGET_ACCELERATE) and speed <= 200.0 then
        FlyCar.cars = FlyCar.cars + 0.4
    end
    if isWidgetPressed(WIDGET_BRAKE) then
        FlyCar.cars = FlyCar.cars - 0.3
        if FlyCar.cars < 0 then FlyCar.cars = 0 end
    end
    if isWidgetPressed(WIDGET_HANDBRAKE) then
        FlyCar.cars = 0
        setCarRotationVelocity(car, 0.0, 0.0, 0.0)
        setCarRoll(car, 0.0)
    end
    setCarForwardSpeed(car, FlyCar.cars)
end

-- NoBike
nobike_activate = function()
    lua_thread.create(function()
        while true do wait(0)
            if isCharInAnyCar(PLAYER_PED) and settings.car.nobike[0] then
                setCharCanBeKnockedOffBike(PLAYER_PED, true)
                if isCharInAnyCar(PLAYER_PED) then
                    if isCarInWater(storeCarCharIsInNoSave(PLAYER_PED)) then
                        setCharCanBeKnockedOffBike(PLAYER_PED, false)
                    else
                        setCharCanBeKnockedOffBike(PLAYER_PED, true)
                    end
                end
            end
        end
    end)
end
  
nobike_reset = function()
    setCharCanBeKnockedOffBike(PLAYER_PED, false)
end
  
-- SetSkin by forget
setskin_activate = function()
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt32(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    raknetBitStreamWriteInt32(bs, settings.ped.skinid[0])
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
end
  
-- ESP
settings.ESP.processESP = function()
    while not isSampAvailable() do wait(0) end
    while true do
        wait(0)
        for _, char in ipairs(getAllChars()) do
            local result, id = sampGetPlayerIdByCharHandle(char)
            if result and isCharOnScreen(char) and char ~= PLAYER_PED then
                local opaque_color = bit.bor(bit.band(sampGetPlayerColor(id), 0xFFFFFF), 0xFF000000)
  
                if settings.ESP.enabled_bones[0] then
                    for _, bone in ipairs(ESP2.BONES) do
                        local x1, y1, z1 = getBonePosition(char, bone)
                        local x2, y2, z2 = getBonePosition(char, bone + 1)
                        local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                        local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                        if r1 and r2 then
                            renderDrawLine(sx1, sy1, sx2, sy2, settings.ESP.skeletonthinkness[0], opaque_color)
                        end
                    end
                    local x1, y1, z1 = getBonePosition(char, 2)
                    local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                    if r1 then
                        local x2, y2, z2 = getBonePosition(char, 41)
                        local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                        if r2 then
                            renderDrawLine(sx1, sy1, sx2, sy2, settings.ESP.skeletonthinkness[0], opaque_color)
                        end
                    end
                    if r1 then
                        local x2, y2, z2 = getBonePosition(char, 51)
                        local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                        if r2 then
                            renderDrawLine(sx1, sy1, sx2, sy2, settings.ESP.skeletonthinkness[0], opaque_color)
                        end
                    end
                end
                if settings.ESP.enabled_boxes[0] then
                    local x, y, z = getOffsetFromCharInWorldCoords(char, 0, 0, 0) -- To get position of char even if he is in car
                    local headx, heady = convert3DCoordsToScreen(x, y, z + 1.0)
                    local footx, footy = convert3DCoordsToScreen(x, y, z - 1.0)
                    local width = math.abs((heady - footy) * 0.25)
                    renderDrawBoxWithBorder(headx - width, heady, math.abs(2 * width), math.abs(footy - heady), 0, SCREEN_H * settings.ESP.boxthinkness[0], opaque_color)
                end
                if settings.ESP.enabled_nicks[0] then
                    local hx, hy, hz = getBonePosition(char, 5)
                    local hr, headx, heady = convert3DCoordsToScreenEx(hx, hy, hz + 0.25)
                    if hr then
                        local nickname = sampGetPlayerNickname(id)
                        local nametag = nickname .. ' [' .. tostring(id) .. '] - {FF0000}' .. string.format("%.0f", sampGetPlayerHealth(id)) .. 'hp {BBBBBB}' .. string.format("%.0f", sampGetPlayerArmor(id)) .. 'ap'
                        local nametag_len = renderGetFontDrawTextLength(ESP2.FONT, nametag)
                        local nametag_x = headx - nametag_len / 2
                        local nametag_y = heady - renderGetFontDrawHeight(ESP2.FONT)
                        renderFontDrawText(ESP2.FONT, nametag, nametag_x, nametag_y, opaque_color)
                    end
                end
                if settings.ESP.enabled_lines[0] then
                    local hx, hy, hz = getBonePosition(char, 5)
                    local hr, headx, heady = convert3DCoordsToScreenEx(hx, hy, hz + 0.25)
                    local px,py,pz = getCharCoordinates(char)
                    local sx, sy = getScreenResolution()
                    local ex, ey = convert3DCoordsToScreen(px,py,pz)
                    renderDrawLine(sx / 2, sy * settings.ESP.lineposition[0], headx, heady - 25 * MONET_DPI_SCALE, settings.ESP.linethinkness[0], opaque_color)
                    renderDrawPolygon(headx - 3.5 * MONET_DPI_SCALE, heady - 25 * MONET_DPI_SCALE, 8 * MONET_DPI_SCALE, 8 * MONET_DPI_SCALE, 5, 0.0, opaque_color)
                end
            end
        end
    end
end
  
lua_thread.create(settings.ESP.processESP)

-- tsr rage bot
ragetsrbot = function()
    lua_thread.create(function()
        while true do
            wait(0)
            if tsrragebot[0] then
                if botstep == 0 then
                    setCharCoordinates(PLAYER_PED, 257.86, 2012.86, 16.64)
                    wait(500)
                    local bs = raknetNewBitStream()
	                raknetBitStreamWriteInt8(bs, 220)
	                raknetBitStreamWriteInt8(bs, 63)
	                raknetBitStreamWriteInt8(bs, 8)
	                raknetBitStreamWriteInt32(bs, 7)
	                raknetBitStreamWriteInt32(bs, -1)
	                raknetBitStreamWriteInt32(bs, 0)
	                raknetBitStreamWriteString(bs, "")
	                raknetSendBitStreamEx(bs, 1, 7, 1)
	                raknetDeleteBitStream(bs)
	                botstep = 1
	            elseif botstep == 1 then
                    wait(settings.tsr.tsrbotwait[0])
                    setCharCoordinates(PLAYER_PED, 244.37, 2015.84, 17.66)
                    wait(100)
                    setCharCoordinates(PLAYER_PED, 239.16, 2026.78, 16.68)
                    wait(500)
                    local bs = raknetNewBitStream()
	                raknetBitStreamWriteInt8(bs, 220)
	                raknetBitStreamWriteInt8(bs, 63)
	                raknetBitStreamWriteInt8(bs, 8)
	                raknetBitStreamWriteInt32(bs, 7)
	                raknetBitStreamWriteInt32(bs, -1)
	                raknetBitStreamWriteInt32(bs, 0)
	                raknetBitStreamWriteString(bs, "")
	                raknetSendBitStreamEx(bs, 1, 7, 1)
	                raknetDeleteBitStream(bs)
                    botstep = 2
                elseif botstep == 2 then
                    wait(settings.tsr.tsrbotwait[0])
                    setCharCoordinates(PLAYER_PED, 244.37, 2015.84, 17.66)
                    wait(100)
                    botstep = 0
                    box = box + 1
                    printStringNow('Box: ' .. box, 500)
                end
            end
        end
    end)
end

---------Кнопка Menu---------
local newFrame2 = imgui.OnFrame(
    function() return settings.menu.openbutton[0] end,
    function(player)
        imgui.Begin('ZoV', settings.menu.openbutton, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
            if imgui.Button(fa.GEARS, imgui.ImVec2(settings.menu.slideropenbuttonwidth[0], settings.menu.slideropenbuttonheight[0])) then
                window_state[0] = not window_state[0]
            end
        imgui.End()
    end
)
-- found update window
imgui.OnFrame(function() return found_update[0] end, function()
    local screenx, screeny = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(screenx / 2, screeny / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'', found_update, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
    imgui.CenterText('')
    imgui.CenterText('')
    imgui.CenterText('')
    imgui.CenterText(u8'Найдено новое обновление скрипта!')
    imgui.CenterText('')
    imgui.CenterText('')
    imgui.CenterText(u8'Было найдено новое обновление скрипта, для')
    imgui.CenterText(u8'продолжения работы вам необходимо выбрать, скачать')
    imgui.CenterText(u8'обновление, или нет. Для этого выберете одну из двух кнопок ниже')
    imgui.CenterText('')
    imgui.CenterText('')
    if imgui.Button(fa.DOWNLOAD..u8' ОБНОВИТЬ') then
        updateScript(lmUrl, lmPath)
    end
    imgui.SameLine()
    if imgui.Button(fa.FORWARD..u8' ПРОПУСТИТЬ') then
       found_update[0] = not found_update[0]
       notf('Обновление скрипта пропущено.')
    end
    imgui.End()
end)
-- demo window
imgui.OnFrame(function() return custommimguiStyle[0] end, function()
    imgui.Begin("mimgui custom style")
    imgui.ShowStyleEditor()
    imgui.End()
end)
-- alt
imgui.OnFrame(function() return settings.menu.sendalt[0] end, function()
    local screenx, screeny = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(screenx / 2 , screeny - 60), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'  ', settings.menu.sendalt, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
    if imgui.Button(fa.HANDSHAKE_ANGLE..u8' Взаимодействие', imgui.ImVec2(settings.menu.sendaltwidth[0], settings.menu.sendaltheight[0])) then
        lua_thread.create(function()
            local bs = raknetNewBitStream()
	        raknetBitStreamWriteInt8(bs, 220)
	        raknetBitStreamWriteInt8(bs, 63)
            raknetBitStreamWriteInt8(bs, 8)
	        raknetBitStreamWriteInt32(bs, 7)
	        raknetBitStreamWriteInt32(bs, -1)
            raknetBitStreamWriteInt32(bs, 0)
	        raknetBitStreamWriteString(bs, "")
	        raknetSendBitStreamEx(bs, 1, 7, 1)
	        raknetDeleteBitStream(bs)
	        return
	    end)
	end
    imgui.End()
end)
-- menu settings
imgui.OnFrame(function() return menusettings[0] end, function()
    imgui.Begin(u8'Настройки меню', menusettings, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
    imgui.CenterText(fa.DIAGRAM_PROJECT..u8' Чайлд вкладок')
    imgui.Separator()
    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширина чайлда', settings.menu.onechildwidth, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.onechildwidth = settings.menu.onechildwidth[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высота чайлда', settings.menu.onechildheight, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.onechildheight = settings.menu.onechildheight[0]
            save()
        end
    end
    if imgui.SliderInt(fa.ARROWS_LEFT_RIGHT..u8' Позиция чайлда X', settings.menu.onechildposx, 0, 1000) then
        if settings.cfg.autosave[0] then
            ini.menu.onechildposx = settings.menu.onechildposx[0]
            save()
        end
    end
    if imgui.SliderInt(fa.ARROWS_UP_DOWN..u8' Позиция чайлда Y', settings.menu.onechildposy, 0, 1000) then
        if settings.cfg.autosave[0] then
            ini.menu.onechildposy = settings.menu.onechildposy[0]
            save()
        end
    end
    imgui.Separator()
    imgui.CenterText(fa.DIAGRAM_PROJECT..u8' Чайлд функций')
    imgui.Separator()
    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширинa чайлда', settings.menu.twochildwidth, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.twochildwidth = settings.menu.twochildwidth[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высотa чайлда', settings.menu.twochildheight, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.twochildheight = settings.menu.twochildheight[0]
            save()
        end
    end
    if imgui.SliderInt(fa.ARROWS_LEFT_RIGHT..u8' Пoзиция чайлда X', settings.menu.twochildposx, 0, 1000) then
        if settings.cfg.autosave[0] then
            ini.menu.twochildposx = settings.menu.twochildposx[0]
            save()
        end
    end
    if imgui.SliderInt(fa.ARROWS_UP_DOWN..u8' Пoзиция чайлда Y', settings.menu.twochildposy, 0, 1000) then
        if settings.cfg.autosave[0] then
            ini.menu.twochildposy = settings.menu.twochildposy[0]
            save()
        end
    end
    imgui.Separator()
    imgui.CenterText(fa.FOLDER..u8' Общие настройки меню')
    imgui.Separator()
    if imgui.ToggleButton(fa.TABLE_LIST..u8' Вкладки горизонтально (чайлд настраивай сам)', settings.menu.samelinetabs) then
        if settings.cfg.autosave[0] then
            ini.menu.samelinetabs = settings.menu.samelinetabs[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширина кнопок вкладок', settings.menu.tabswidth, 50, 300) then
        if settings.cfg.autosave[0] then
            ini.menu.tabswidth = settings.menu.tabswidth[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высота кнопок вкладок', settings.menu.tabsheight, 10, 100) then
        if settings.cfg.autosave[0] then
            ini.menu.tabsheight = settings.menu.tabsheight[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширина меню', settings.menu.menuwidth, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.menuwidth = settings.menu.menuwidth[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высота меню', settings.menu.menuheight, 0, 1500) then
        if settings.cfg.autosave[0] then
            ini.menu.menuheight = settings.menu.menuheight[0]
            save()
        end
    end
    imgui.Separator()
    imgui.CenterText(fa.HANDSHAKE_ANGLE..u8' Взаимодействие')
    imgui.Separator()
    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширина взаимодействия', settings.menu.sendaltwidth, 1, 400) then
        if settings.cfg.autosave[0] then
            ini.menu.sendaltwidth = settings.menu.sendaltwidth[0]
            save()
        end
    end
    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высота взаимодействия', settings.menu.sendaltheight, 1, 400) then
        if settings.cfg.autosave[0] then
            ini.menu.sendaltheight = settings.menu.sendaltheight[0]
            save()
        end
    end
    imgui.End()
end)
---------Меню---------
imgui.OnFrame(function() return window_state[0] end, function()
    local resX, resY = getScreenResolution()
    local sizeX, sizeY = 305, 435
    imgui.SetNextWindowPos(imgui.ImVec2(1100 * MONET_DPI_SCALE, 500 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(settings.menu.menuwidth[0] * MONET_DPI_SCALE, settings.menu.menuheight[0] * MONET_DPI_SCALE), imgui.Cond.Always)
    imgui.Begin(fa.STAR_OF_LIFE..u8' Miku Project Reborn '..fa.STAR_OF_LIFE, window_state, imgui.WindowFlags.NoResize)
    imgui.SetCursorPos(imgui.ImVec2(settings.menu.onechildposx[0] * MONET_DPI_SCALE, settings.menu.onechildposy[0] * MONET_DPI_SCALE))
    if imgui.BeginChild('Tabs##'..tab, imgui.ImVec2(settings.menu.onechildwidth[0] * MONET_DPI_SCALE, settings.menu.onechildheight[0] * MONET_DPI_SCALE), true) then
        if imgui.Button(fa.FIRE..u8' Основное', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 1
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.USER..u8' Персонаж', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 2
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.CAR..u8' Машина', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 3
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.EYE..u8' Подсветка', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 4
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.XMARKS_LINES..u8' ТСР Хелпер', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 5
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.SQUARE_CHECK..u8' Кнопочки', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 6
        end
        if settings.menu.samelinetabs[0] then
            imgui.SameLine()
        end
        if imgui.Button(fa.GEARS..u8' Настройки', imgui.ImVec2(settings.menu.tabswidth[0], settings.menu.tabsheight[0])) then
            tab = 7
        end
        imgui.EndChild()
    end
    imgui.SetCursorPos(imgui.ImVec2(settings.menu.twochildposx[0] * MONET_DPI_SCALE, settings.menu.twochildposy[0] * MONET_DPI_SCALE))
    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(settings.menu.twochildwidth[0] * MONET_DPI_SCALE, settings.menu.twochildheight[0] * MONET_DPI_SCALE), true) then
        if tab == 1 then
            imgui.CenterText(fa.FIRE..u8' Основное')
            imgui.Separator()
            imgui.Text(fa.WIND..u8' Аирбрейк активируется даблтапом на иконку оружия')
            if imgui.ToggleButton(fa.WAND_MAGIC_SPARKLES..u8' Виджет аирбрейка', settings.main.airbrakewidget) then
                if settings.cfg.autosave[0] then
                    ini.main.airbrakewidget = settings.main.airbrakewidget[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.COMMENT..u8' Telegram Chat Logger', settings.tglogger.state) then
                if settings.cfg.autosave[0] then
                    ini.tglogger.state = settings.tglogger.state[0]
                    save()
                end
            end
            if settings.menu.showinfo[0] then
                imgui.SameLine()
                imgui.Text(fa.INFO..u8' | t.me/tgloggermikututorxd/2')
                imgui.SameLine()
                if imgui.Button(fa.CLIPBOARD..u8' Copy') then
                    setClipboardText('t.me/tgloggermikututorxd/2')
                end
            end
            if imgui.ToggleButton(fa.FROG..u8' ClickCoordMobile', settings.main.clickwarpcoord) then
                if settings.cfg.autosave[0] then
                    ini.main.clickwarpcoord = settings.main.clickwarpcoord[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.CLIPBOARD..u8' Quit Informer', settings.main.quitinformer) then
                if settings.cfg.autosave[0] then
                    ini.main.quitinformer = settings.main.quitinformer[0]
                    save()
                end
            end
            if settings.main.quitinformer[0] then
                imgui.Text(u8'   '..fa.ARROW_TREND_DOWN)
                imgui.SameLine()
                imgui.SetCursorPosX(60)
                if imgui.ToggleButton(fa.SHEKEL_SIGN..u8' Informer в зоне стрима', settings.main.informerinstream) then
                    if settings.cfg.autosave[0] then
                        ini.main.informerinstream = settings.main.informerinstream[0]
                        save()
                    end
                end
            end
            if imgui.ToggleButton(fa.CLIPBOARD_CHECK..u8' Чекер зелёной зоны', settings.main.gzinfo) then
                if settings.cfg.autosave[0] then
                    ini.main.gzinfo = settings.main.gzinfo[0]
                    save()
                end
            end
            if settings.main.gzinfo[0] then
                imgui.Text(u8'   '..fa.ARROW_TREND_DOWN)
                imgui.SameLine()
                imgui.SetCursorPosX(60)
                if imgui.Button(fa.UP_DOWN_LEFT_RIGHT..u8' Изменить позицию') then
                    gzpos = not gzpos
                    window_state[0] = not window_state[0]
                    notf('Меню скрыто до момента, пока не сохраните позицию')
                    notf('Нажмите на место, куда хотите переместить текст' or 'Перемещение текста отключено')
                end
                imgui.Text(u8'   '..fa.ARROW_TREND_DOWN)
                imgui.SameLine()
                imgui.SetCursorPosX(60)
                if imgui.ToggleButton(fa.SIGNATURE..u8' Показывать название ЗЗ вместо "Да"', settings.main.gzname) then
                    if settings.cfg.autosave[0] then
                        ini.main.gzname = settings.main.gzname[0]
                        save()
                    end
                end
                imgui.Text(u8'   '..fa.ARROW_TREND_DOWN)
                imgui.SameLine()
                imgui.SetCursorPosX(60)
                if imgui.ToggleButton(fa.XMARK..u8' Отключить "[Ошибка] Не флуди!"', settings.main.offdontflood) then
                    if settings.cfg.autosave[0] then
                        ini.main.offdontflood = settings.main.offdontflood[0]
                        save()
                    end
                end
                imgui.Text(u8'   '..fa.ARROW_TREND_DOWN)
                imgui.SameLine()
                imgui.SetCursorPosX(60)
                imgui.PushItemWidth(180)
                if imgui.SliderInt(fa.EXPAND..u8' Размер текста', settings.main.gzsize, 5, 30) then
                    if settings.cfg.autosave[0] then
                        ini.main.gzsize = settings.main.gzsize[0]
                        save()
                    end
                end
                imgui.PopItemWidth()
            end
            if imgui.ToggleButton(fa.CIRCLE_NOTCH..u8' Радиус лавки (ЦР)', settings.main.radiuslavki) then
                if settings.cfg.autosave[0] then
                    ini.main.radiuslavki = settings.main.radiuslavki[0]
                    save()
                end
            end
            if imgui.Button(fa.TOILET..u8' Начать ссать') then
                sampSetSpecialAction(68)
            end
            if imgui.Button(fa.TOILET_PAPER..u8' Перестать ссать (или частичный сбив)') then
                sampSetSpecialAction(0)
            end
            if imgui.Button(fa.WIFI..u8' Реконнект') and not Reconnect.reconnecting and not Reconnect.waiting then
                Reconnect.activate()
            end
            if Reconnect.waiting then
                imgui.SameLine()
                imgui.Text(string.format(u8'Реконнект через %.2f секунд...', Reconnect.remaining / 1000))
                imgui.SameLine()
                if imgui.Button(fa.XMARK..u8' Отмена') then
                    Reconnect.abort = true
                end
            end
            imgui.SetNextItemWidth(imgui.GetFontSize() * 15)
            imgui.SliderFloat(fa.HOURGLASS_START..u8' Задержка реконнекта (в секундах)', Reconnect.delay, 0.0, 30.0)
            if imgui.Button(fa.WIND..u8' Установить погоду') then
                forceWeatherNow(WeatherAndTime.weather[0])
            end
            imgui.SameLine()
            imgui.SetNextItemWidth(imgui.GetFontSize() * 5)
            imgui.PushItemWidth(120)
            if imgui.InputInt(fa.SUN..u8' Погода', WeatherAndTime.weather, 1, 10) then
                if WeatherAndTime.weather[0] < 0 then
                    WeatherAndTime.weather[0] = 0
                end
                if WeatherAndTime.weather[0] > 45 then
                    WeatherAndTime.weather[0] = 45
                end
            end
            imgui.PopItemWidth()
            if imgui.Button(fa.MOON..u8' Установить время') then
                if WeatherAndTime.thread ~= nil then
                    WeatherAndTime.thread:terminate()
                end
                WeatherAndTime.locked_time = WeatherAndTime.time[0]
                WeatherAndTime.thread = lua_thread.create(function()
                    WeatherAndTime.new_time = false
                    while not WeatherAndTime.new_time do
                        setTimeOfDay(WeatherAndTime.locked_time, 0)
                        wait(0)
                    end
                    WeatherAndTime.new_time = false
                end)
            end
            imgui.SameLine()
            imgui.SetNextItemWidth(imgui.GetFontSize() * 5)
            imgui.PushItemWidth(120)
            if imgui.InputInt(fa.CLOCK..u8' Время', WeatherAndTime.time, 1, 5) then
                if WeatherAndTime.time[0] < 0 then
                    WeatherAndTime.time[0] = 0
                end
                if WeatherAndTime.time[0] > 23 then
                    WeatherAndTime.time[0] = 23
                end
            end
            imgui.PopItemWidth()
            imgui.Separator()
            imgui.CenterText(fa.MAGNIFYING_GLASS..u8' Рендер на объекты')
            imgui.Separator()
            if imgui.ToggleButton(fa.GEM..u8' Руда', settings.render.ruda) then
                if settings.cfg.autosave[0] then
                    ini.render.ruda = settings.render.ruda[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.SEEDLING..u8' Семена нарко', settings.render.semena) then
                if settings.cfg.autosave[0] then
                    ini.render.semena = settings.render.semena[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.TABLETS..u8' Закладки', settings.render.narkotiki) then
                if settings.cfg.autosave[0] then
                    ini.render.narkotiki = settings.render.narkotiki[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.TREE..u8' Дерево высшего качества', settings.render.derevovishkac) then
                if settings.cfg.autosave[0] then
                    ini.render.derevovishkac = settings.render.derevovishkac[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.GIFT..u8' Подарок', settings.render.podarok) then
                if settings.cfg.autosave[0] then
                    ini.render.podarok = settings.render.podarok[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.TOOLBOX..u8' Клад', settings.render.kladrender) then
                if settings.cfg.autosave[0] then
                    ini.render.kladrender = settings.render.kladrender[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.APPLE_WHOLE..u8' Яблочное дерево', settings.render.yabloki) then
                if settings.cfg.autosave[0] then
                    ini.render.yabloki = settings.render.yabloki[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.APPLE_WHOLE..u8' Cливовое дерево', settings.render.slivu) then
                if settings.cfg.autosave[0] then
                    ini.render.slivu = settings.render.slivu[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.APPLE_WHOLE..u8' Кокосное дерево', settings.render.kokosi) then
                if settings.cfg.autosave[0] then
                    ini.render.kokosi = settings.render.kokosi[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.SPRAY_CAN..u8' Граффити', settings.render.graffiti) then
                if settings.cfg.autosave[0] then
                    ini.render.graffiti = settings.render.graffiti[0]
                    save()
                end
            end
            imgui.Separator()
            if imgui.Button(fa.GEM..u8' Mine Time Render') then
                mtract = not mtract
                for i = 1, 3000 do
                    resources[i] = {}
                    for a = 1, 4 do
                        resources[i][a] = 0
                    end
                end
	    	    start = mtract and os.time() or nil
	    	    notf(mtract and "{FFC300}Mine Time Render {FFFFFF}включен!" or '{FFC300}Mine Time Render {FFFFFF}выключен!',-1)
            end
            imgui.PushItemWidth(250)
            if imgui.SliderInt(fa.STAR_OF_LIFE..u8' Секунд на руду', settings.render.rtime, 1, 550) then
                if settings.cfg.autosave[0] then
                    ini.render.rtime = settings.render.rtime[0]
                    save()
                end
            end
            if imgui.SliderInt(fa.STAR_OF_LIFE..u8' Размер текста рендера', settings.render.mtrsize, 1, 30) then
                if settings.cfg.autosave[0] then
                    ini.render.mtrsize = settings.render.mtrsize[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8' | Можно использовать /mine для включения')
                imgui.Text(fa.INFO..u8' | Для применения размера текста необходимо')
                imgui.Text(fa.INFO..u8' | сохранить конфиг и перезагрузить скрипт')
            end
            imgui.Separator()
            imgui.CenterText(fa.PLANE_UP..u8' zTeleport by Mintha (v3)')
            imgui.Separator()
            if imgui.Button(fa.PLANE_DEPARTURE..u8' Телепорт (метка)') then
                sampProcessChatInput('/tpz')
            end
            if imgui.Button(fa.RECEIPT..u8' Отображать информацию слева') then
                tpbar = not tpbar
                if settings.cfg.autosave[0] then
                    ini.teleport.tpbar = tpbar
                    save()
                end
            end
            if imgui.Button(fa.UP_DOWN_LEFT_RIGHT..u8' Изменить позицию инфы') then
                editposs = not editposs
                window_state[0] = not window_state[0]
                notf('Меню скрыто до момента, пока не сохраните позицию')
                notf('Для изменения положения нажми на экран в любом месте' or 'Отменено')
            end
            if imgui.Button(fa.WRENCH..u8' Установить задержку') then
                sampProcessChatInput('/tpz waiting '..settings.teleport.tpwait[0])
            end
            if imgui.SliderInt(fa.HOURGLASS_HALF..u8' Зaдeржка', settings.teleport.tpwait, 0, 10000) then
                if settings.cfg.autosave[0] then
                    ini.teleport.tpwait = settings.teleport.tpwait[0]
                    save()
                end
            end
            if imgui.SliderInt(fa.MAXIMIZE..u8' Размер инфы слева', settings.teleport.infosize, 2, 30) then
                if settings.cfg.autosave[0] then
                    ini.teleport.infosize = settings.teleport.infosize[0]
                    save()
                end
            end
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8' | Для применения размера нужно сохранить настройки')
                imgui.Text(fa.INFO..u8' | и перезагрузить скрипт')
            end
            imgui.Separator()
            if settings.menu.showinfo[0] then
                if imgui.Button(fa.INFO..u8' | Спойлер: Чат-команды') then
                    tpchatcmds = not tpchatcmds
                end
                if tpchatcmds then
                    imgui.Text(fa.INFO..u8' | /tpz - телепорт по метке')
                    imgui.Text(fa.INFO..u8' | /tpz waiting *целое число* - установить задержку')
                    imgui.Text(fa.INFO..u8' | /tpz view - отображение информации слева')
                end
            end
            imgui.Separator()
            imgui.Text(fa.PLANE..u8' Моментальный ТП для бонусников')
            imgui.Separator()
            if imgui.Button(fa.PLANE_DEPARTURE..u8' ТП по метке') then
                sampProcessChatInput('/tpc')
            end
            if settings.menu.showinfo[0] then 
                imgui.Separator()
                imgui.Text(fa.INFO..u8' | Можно использовать /tpc')
            end
            imgui.Separator()
            imgui.CenterText(fa.DIAGRAM_PROJECT..u8' Объекты')
            imgui.Separator()
            imgui.Text(fa.TRASH..u8' Удалить:')
            if imgui.Button(fa.TORII_GATE..u8' Ворота армии ЛС') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 975 then
                        deleteObject(obj)
                    end
                end
            end
            imgui.SameLine()
            if imgui.ToggleButton(fa.TRASH..u8' Автоудаление', settings.objects.autormlsa) then
                if settings.cfg.autosave[0] then
                    ini.objects.autormlsa = settings.objects.autormlsa[0]
                    save()
                end
            end
            if imgui.Button(fa.TORII_GATE..u8' Ворота армии СФ') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 988 then
                        deleteObject(obj)
                    end
                end
            end
            imgui.SameLine()
            if imgui.ToggleButton(fa.TRASH..u8' Автоудaление', settings.objects.autormsfa) then
                if settings.cfg.autosave[0] then
                    ini.objects.autormsfa = settings.objects.autormsfa[0]
                    save()
                end
            end
            if imgui.Button(fa.ROAD_BARRIER..u8' Шлагбаумы (КПП)') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 968 then
                        deleteObject(obj)
                    end
                end
            end
            imgui.SameLine()
            if imgui.ToggleButton(fa.TRASH..u8' Aвтоудаление', settings.objects.autormblockpost) then
                if settings.cfg.autosave[0] then
                    ini.objects.autormblockpost = settings.objects.autormblockpost[0]
                    save()
                end
            end
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8' | (Будет пополняться в зависимости)')
                imgui.Text(fa.INFO..u8' | (от ваших пожеланий в чате Miku Project)')
            end
        elseif tab == 2 then
            imgui.CenterText(fa.USER..u8' Персонаж')
            imgui.Separator()
            if imgui.ToggleButton(fa.BOOK_BIBLE..u8' Бессмертие', settings.ped.godmode_enabled) then
                if settings.ped.godmode_enabled[0] then
                    setCharProofs(PLAYER_PED, false, true, true, true, true)
                else
                    setCharProofs(PLAYER_PED, false, false, false, false, false)
                end
                if settings.cfg.autosave[0] then
                    ini.ped.godmode_enabled = settings.ped.godmode_enabled[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            if imgui.ToggleButton(fa.PERSON_RUNNING..u8' Бег CJ', settings.ped.cjrun) then
                if settings.cfg.autosave[0] then
                    ini.ped.cjrun = settings.ped.cjrun[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.REPEAT..u8' No Reload', settings.ped.noreload) then
                if settings.cfg.autosave[0] then
                    ini.ped.noreload = settings.ped.noreload[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            if imgui.ToggleButton(fa.WAND_SPARKLES..u8' Фейк скиллы', settings.ped.setskills) then
                if settings.cfg.autosave[0] then
                    ini.ped.setskills = settings.ped.setskills[0]
                    save()
                end
            end
            imgui.ToggleButton(fa.PAPERCLIP..u8' Флуд взаимодействием', floodalt)
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            if imgui.ToggleButton(fa.GUN..u8' Авто +С', settings.ped.autoplusc) then
                if settings.cfg.autosave[0] then
                    ini.ped.autoplusc = settings.ped.autoplusc[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.HEART_PULSE..u8' HP Bar', settings.ped.hpbar) then
                if settings.cfg.autosave[0] then
                    ini.ped.hpbar = settings.ped.hpbar[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            if imgui.ToggleButton(fa.INFINITY..u8' Бесконечный бег', settings.ped.infiniterun) then
                if settings.cfg.autosave[0] then
                    ini.ped.infiniterun = settings.ped.infiniterun[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.PERSON_RUNNING..u8' Скорость анимаций', settings.ped.animspeed) then
                if settings.cfg.autosave[0] then
                    ini.ped.animspeed = settings.ped.animspeed[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            if imgui.ToggleButton(fa.GUN..u8' Рапид', settings.ped.rapidfire) then
                if settings.cfg.autosave[0] then
                    ini.ped.rapidfire = settings.ped.rapidfire[0]
                    save()
                end
            end
            imgui.PushItemWidth(200)
            if imgui.SliderInt(u8'', settings.ped.speedint, 1, 10) then
                if settings.cfg.autosave[0] then
                    ini.ped.speedint = settings.ped.speedint[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            imgui.SameLine()
            imgui.SetCursorPosX(370)
            imgui.PushItemWidth(200)
            if imgui.SliderInt(u8' ', settings.ped.rapidint, 1, 10) then
                if settings.cfg.autosave[0] then
                    ini.ped.rapidint = settings.ped.rapidint[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            if imgui.Button(fa.PERSON..u8' Установить скин', imgui.ImVec2(420, 35)) then
                setskin_activate()
            end
            imgui.SameLine()
            imgui.SetNextItemWidth(imgui.GetFontSize() * 7)
            if imgui.InputInt(fa.ID_CARD_CLIP..u8' ID Скина', settings.ped.skinid, 1, 50) then
                if settings.cfg.autosave[0] then
                    ini.ped.skinid = settings.ped.skinid[0]
                    save()
                end
            end
            imgui.Separator()
            if imgui.Button(fa.USER..u8' Бот завод') then
                sampProcessChatInput('/armbot '..krugibota[0])
            end
            imgui.PushItemWidth(250)
            imgui.SliderInt(fa.ARROWS_SPIN..u8' Количество кругов', krugibota, 0, 50)
            imgui.PopItemWidth()
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8' | Можно использовать /armbot *кол-во кругов*')
                imgui.Text(fa.INFO..u8' | 0 - бесконечность кругов')
            end
            if imgui.Button(fa.GUN..u8' Бот тир') then
                sampProcessChatInput('/ytir')
            end
            imgui.Separator()
            imgui.CenterText(fa.LOCATION_CROSSHAIRS..u8' Silent by Langer (v2.1.1)')
            imgui.Separator()
            if imgui.ToggleButton(fa.CROSSHAIRS..u8' Silent Aim', settings.silent.salo) then
                if settings.cfg.autosave[0] then
                    ini.silent.salo = settings.silent.salo[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.CAR..u8' Игнорировать автомобили', settings.silent.ignoreCars) then
                if settings.cfg.autosave[0] then
                    ini.silent.ignoreCars = settings.silent.ignoreCars[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.OBJECT_GROUP..u8' Игнорировать объекты', settings.silent.ignoreObj) then
                if settings.cfg.autosave[0] then
                    ini.silent.ignoreObj = settings.silent.ignoreObj[0]
                    save()
                end
            end
            imgui.Separator()
            if imgui.ToggleButton(fa.GUN..u8' Автоматически выбирать дистанцию у оружие', settings.silent.useWeaponDistance) then
                if settings.cfg.autosave[0] then
                    ini.silent.useWeaponDistance = settings.silent.useWeaponDistance[0]
                    save()
                end
            end
            if not settings.silent.useWeaponDistance[0] then
                if imgui.SliderInt(fa.PEOPLE_ARROWS..u8' Дистанция поиска цели', settings.silent.distance, 1, 1000) then
                    if settings.cfg.autosave[0] then
                        ini.silent.distance = settings.silent.distance[0]
                        save()
                    end
                end
            end
            if imgui.SliderInt(fa.CIRCLE..u8' Радиус поиска цели', settings.silent.radius, 1, 100) then
                if settings.cfg.autosave[0] then
                    ini.silent.radius = settings.silent.radius[0]
                    save()
                end
            end
            if imgui.SliderFloat(fa.ARROWS_LEFT_RIGHT..u8' Положение FOV по X', settings.silent.offsetx, -200.0, 200.0) then
                if settings.cfg.autosave[0] then
                    ini.silent.offsetx = settings.silent.offsetx[0]
                    save()
                end
            end
            if imgui.SliderFloat(fa.ARROWS_UP_DOWN..u8' Положение FOV по Y', settings.silent.offsety, -200.0, 200.0) then
                if settings.cfg.autosave[0] then
                    ini.silent.offsety = settings.silent.offsety[0]
                    save()
                end
            end
            imgui.Separator()
            if imgui.ToggleButton(fa.DIAGRAM_PROJECT..u8' Отображать линию к цели', settings.silent.line) then
                if settings.cfg.autosave[0] then
                    ini.silent.line = settings.silent.line[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.CROSSHAIRS..u8' Отображать прицел', settings.silent.circle) then
                if settings.cfg.autosave[0] then
                    ini.silent.circle = settings.silent.circle[0]
                    save()
                end
            end
            if settings.silent.circle[0] then
                if imgui.ToggleButton(fa.LOCATION_CROSSHAIRS..u8' Отображать более производительный прицел (более удобный)', settings.silent.fpscircle) then
                    if settings.cfg.autosave[0] then
                        ini.silent.fpscircle = settings.silent.fpscircle[0]
                        save()
                    end
                end
            end
            if imgui.ToggleButton(fa.COMMENT..u8' Писать снизу о нанесение урона', settings.silent.printString) then
                if settings.cfg.autosave[0] then
                    ini.silent.printString = settings.silent.printString[0]
                    save()
                end
            end
            imgui.Separator()
            if imgui.ToggleButton(fa.PERSON_CIRCLE_QUESTION..u8' Промахи', settings.silent.misses) then
                if settings.cfg.autosave[0] then
                    ini.silent.misses = settings.silent.misses[0]
                    save()
                end
            end
            if settings.silent.misses[0] then
                imgui.PushItemWidth(200)
                if imgui.SliderInt(fa.PERSON_CIRCLE_QUESTION..u8' Шансы на промах', settings.silent.miss_ratio, 1, 100) then
                    if settings.cfg.autosave[0] then
                        ini.silent.miss_ratio = settings.silent.miss_ratio[0]
                        save()
                    end
                end
                imgui.PopItemWidth()
            end
            imgui.ToggleButton(fa.CAMERA_ROTATE..u8' Изменение камеры', fakemode)
            if imgui.ToggleButton(fa.HEART_CIRCLE_MINUS..u8' Двойной урон', settings.silent.doubledamage) then
                if settings.cfg.autosave[0] then
                    ini.silent.doubledamage = settings.silent.doubledamage[0]
                    save()
                end
            end
            if settings.silent.doubledamage[0] then
                if imgui.ToggleButton(fa.HEART_CRACK..u8' Тройной урон', settings.silent.tripledamage) then
                    if settings.cfg.autosave[0] then
                        ini.silent.tripledamage = settings.silent.tripledamage[0]
                        save()
                    end
                end
            end
            imgui.Separator()
            imgui.CenterText(fa.GUN..u8' Оружие')
            imgui.Separator()
            if imgui.Button(fa.GUN..u8' Выдать ган') then
                givePlayerGun()
            end
            imgui.PushItemWidth(350)
            if imgui.Combo(fa.PERSON_RIFLE..u8' Ганы',settings.dgun.gunsList,ImItems, #item_list) then
                ini.dgun.gunsList = settings.dgun.gunsList[0]
                save()
            end
            imgui.PopItemWidth()
            imgui.PushItemWidth(350)
            if imgui.SliderInt(fa.WAND_MAGIC_SPARKLES..u8' Патроны', settings.dgun.ammo, 1, 2000) then
                if settings.cfg.autosave[0] then
                    ini.dgun.ammo = settings.dgun.ammo[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8" | Кикает без Resync'a, потому подойдет только для нуборп")
            end
        elseif tab == 3 then
            imgui.CenterText(fa.CAR..u8' Машина')
            imgui.Separator()
            if imgui.ToggleButton(fa.BOOK_BIBLE..u8' Бессмертие', settings.car.godmode2_enabled) then
                if settings.car.godmode2_enabled[0] then
                    gmcar_activate()
                else
                    gmcar_reset()
                end
                if settings.cfg.autosave[0] then
                    ini.car.godmode2_enabled = settings.car.godmode2_enabled[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.PLANE_DEPARTURE..u8' Полёт', settings.car.flycar) then
                if settings.cfg.autosave[0] then
                    ini.car.flycar = settings.car.flycar[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.MOTORCYCLE..u8' Анти-падение с Мото', settings.car.nobike) then
                if settings.car.nobike[0] then
                    nobike_activate()
                else
                    nobike_reset()
                end
                if settings.cfg.autosave[0] then
                    ini.car.nobike = settings.car.nobike[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.CAR..u8' Анти отправка синхры (fake afk)', settings.car.antisync) then
                if settings.cfg.autosave[0] then
                    ini.car.antisync = settings.car.antisync[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.CAR..u8' Гидравлика (неконтролируемая)', settings.car.drift) then
                if settings.cfg.autosave[0] then
                    ini.car.drift = settings.car.drift[0]
                    save()
                end
            end
	        if imgui.Button(fa.PLANE..u8' ТП игроков к себе (включите антисинхру') then
	            sampProcessChatInput('/tpall')
	        end
	        if imgui.Button(fa.RIGHT_FROM_BRACKET..u8' Быстрый выход') then
                if isCharInAnyCar(PLAYER_PED) then
                     local posX, posY, posZ = getCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED))
                    warpCharFromCarToCoord(PLAYER_PED, posX, posY, posZ)
                end
            end
            if imgui.Button(fa.ARROW_TREND_UP..u8' Флипнуть') then
                if isCharInAnyCar(PLAYER_PED) then    
                    local veh = storeCarCharIsInNoSave(PLAYER_PED)
                    local x, y, z = getCarCoordinates(veh)
                    setCarCoordinates(veh, x, y, z)
                end
            end
            if imgui.Button(fa.ARROW_UP..u8' Слап') then
                if isCharInAnyCar(PLAYER_PED) then    
                    local veh = storeCarCharIsInNoSave(PLAYER_PED)
                    local x, y, z = getCarCoordinates(veh)
                    setCarCoordinates(veh, x, y, z+settings.car.slappower2[0])
                end
            end
            imgui.PushItemWidth(250)
            if imgui.SliderInt(fa.PLUG..u8' Сила слапa', settings.car.slappower2, 3, 37) then
                if settings.cfg.autosave[0] then
                    ini.car.slappower2 = settings.car.slappower2[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            imgui.Separator()
            if imgui.ToggleButton(fa.CAR..u8' Attach Trailer', settings.car.atractive) then
                if settings.cfg.autosave[0] then
                    ini.car.atractive = settings.car.atractive[0]
                    save()
                end
            end
            imgui.PushItemWidth(250)
            if imgui.SliderInt(fa.EXPAND..u8' Радиус', settings.car.atrradius, 1, 500) then
                if settings.cfg.autosave[0] then
                    ini.car.atrradius = settings.car.atrradius[0]
                    save()
                end
            end
            imgui.PopItemWidth()
        elseif tab == 4 then
            imgui.CenterText(fa.EYE..u8' Подсветка (ESP)')
            imgui.Separator()
            imgui.PushItemWidth(250)
            if imgui.ToggleButton(fa.BOX..u8' Коробки', settings.ESP.enabled_boxes) then
                if settings.cfg.autosave[0] then
                    ini.ESP.enabled_boxes = settings.ESP.enabled_boxes[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.SIGNATURE..u8' Ники', settings.ESP.enabled_nicks) then
                if settings.cfg.autosave[0] then
                    ini.ESP.enabled_nicks = settings.ESP.enabled_nicks[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.BONE..u8' Скелеты', settings.ESP.enabled_bones) then
                if settings.cfg.autosave[0] then
                    ini.ESP.enabled_bones = settings.ESP.enabled_bones[0]
                    save()
                end
            end
            if imgui.ToggleButton(fa.LINES_LEANING..u8' Линии', settings.ESP.enabled_lines) then
                if settings.cfg.autosave[0] then
                    ini.ESP.enabled_lines = settings.ESP.enabled_lines[0]
                    save()
                end
            end
            if imgui.SliderInt(fa.PENCIL..u8' Откуда рисовать линию?', settings.ESP.lineposition, 0, 1) then
                if settings.cfg.autosave[0] then
                    ini.ESP.lineposition = settings.ESP.lineposition[0]
                    save()
                end
            end
            if imgui.SliderInt(fa.LINES_LEANING..u8' Толщина линии', settings.ESP.linethinkness, 1, 4) then
                if settings.cfg.autosave[0] then
                    ini.ESP.linethinkness = settings.ESP.linethinkness[0]
                    save()
                end
            end
            if imgui.SliderInt(fa.BONE..u8' Толщина скелетов', settings.ESP.skeletonthinkness, 1, 4) then
                if settings.cfg.autosave[0] then
                    ini.ESP.skeletonthinkness = settings.ESP.skeletonthinkness[0]
                    save()
                end
            end
            if imgui.SliderFloat(fa.BOX..u8' Толщина коробок', settings.ESP.boxthinkness, 0.001, 0.007) then
                if settings.cfg.autosave[0] then
                    ini.ESP.boxthinkness = settings.ESP.boxthinkness[0]
                    save()
                end
            end
            if imgui.SliderFloat(fa.SIGNATURE..u8' Размер никнеймов', settings.ESP.nicknamesize, 0.01, 0.03) then
                if settings.cfg.autosave[0] then
                    ini.ESP.nicknamesize = settings.ESP.nicknamesize[0]
                    save()
                end
            end
            imgui.PopItemWidth()
            if settings.menu.showinfo[0] then
                imgui.Text(fa.INFO..u8' | Для применения размера ников, нужно сохранить конфиг')
                imgui.Text(fa.INFO..u8' | и перезагрузить скрипт')
            end
        elseif tab == 5 then
            imgui.CenterText(fa.XMARKS_LINES..u8' ТСР Хелпер')
            imgui.Separator()
            imgui.Text(fa.OBJECT_GROUP..u8' Объекты')
            imgui.Separator()
            if imgui.Button(fa.TRASH..u8' Удалить клетки') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19303 then
                        deleteObject(obj)
                    end
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(175)
            if imgui.Button(fa.TRASH..u8' Удалить дверь') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19857 then
                        deleteObject(obj)
                    end
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(326)
            if imgui.Button(fa.TRASH..u8' Удалить заборы') then
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19912 then
                        deleteObject(obj)
                    end
                    if modeid == 19913 then
                        deleteObject(obj)
                    end
                end
            end
            if imgui.ToggleButton(fa.TRASH..u8' Aвтoматич.', settings.tsr.autormcell) then
                if settings.cfg.autosave[0] then
                    ini.tsr.autormcell = settings.tsr.autormcell[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(175)
            if imgui.ToggleButton(fa.TRASH..u8' Aвтоматич.', settings.tsr.autormdoors) then
                if settings.cfg.autosave[0] then
                    ini.tsr.autormdoors = settings.tsr.autormdoors[0]
                    save()
                end
            end
            imgui.SameLine()
            imgui.SetCursorPosX(326)
            if imgui.ToggleButton(fa.TRASH..u8' Автoматич.', settings.tsr.autormfence) then
                if settings.cfg.autosave[0] then
                    ini.tsr.autormfence = settings.tsr.autormfence[0]
                    save()
                end
            end
            imgui.Separator()
            imgui.Text(fa.PLANE..u8' ТП к стиралкам (Цифра - номер стиралки)')
            imgui.Separator()
            if imgui.Button(u8' 1 ') then
                setCharCoordinates(PLAYER_PED, 1393.4752,1353.7609,10)
            end
            imgui.SameLine()
            if imgui.Button(u8' 2 ') then
                setCharCoordinates(PLAYER_PED, 1393.4773,1355.6962,10)
            end
            imgui.SameLine()
            if imgui.Button(u8' 3 ') then
                setCharCoordinates(PLAYER_PED, 1393.4667,1357.8531,10)
            end
            imgui.SameLine()
            imgui.Text(u8'|')
            imgui.SameLine()
            if imgui.Button(u8' 4 ') then
                setCharCoordinates(PLAYER_PED, 1400.3271, 1353.6957, 10)
            end
            imgui.SameLine()
            if imgui.Button(u8' 5 ') then
                setCharCoordinates(PLAYER_PED, 1400.3285, 1355.6793, 10)
            end
            imgui.SameLine()
            if imgui.Button(u8' 6 ') then
                setCharCoordinates(PLAYER_PED, 1400.3372, 1357.8384, 10)
            end
            if imgui.Button(fa.VEST..u8' Грязная одежда') then
                setCharCoordinates(PLAYER_PED, 1396.1380, 1354.9414, 10)
            end
            imgui.SameLine()
            if imgui.Button(fa.SHIRT..u8' Чистая одежда') then
                setCharCoordinates(PLAYER_PED, 1397.8023, 1357.9216, 10.9390)
            end
            imgui.Separator()
            imgui.Text(fa.RECYCLE..u8' Мусор')
            imgui.Separator()
            if imgui.ToggleButton(fa.DUMPSTER..u8' Вх на мусор', settings.render.musortsr) then
                if settings.cfg.autosave[0] then
                    ini.render.musortsr = settings.render.musortsr[0]
                    save()
                end
            end
            imgui.Separator()
            imgui.Text(fa.ROBOT..u8' Боты')
            if imgui.ToggleButton(fa.BOX..u8' Коробки RAGE', tsrragebot) then
                botstep = 0
                ragetsrbot()
            end
            if imgui.SliderInt(fa.HOURGLASS_HALF..u8' Задержка', settings.tsr.tsrbotwait, 100, 5000) then
                if settings.cfg.autosave[0] then
                    ini.tsr.tsrbotwait = settings.tsr.tsrbotwait[0]
                    save()
                end
            end
            imgui.Separator()
            imgui.Text(fa.BOX..u8' Грузчик')
            imgui.Separator()
            if imgui.Button(fa.PLANE..u8' ТП к началу') then
                setCharCoordinates(PLAYER_PED, 257.86, 2012.86, 16.64)
            end
            imgui.SameLine()
            if imgui.Button(fa.PLANE..u8' ТП в центр') then
                setCharCoordinates(PLAYER_PED, 244.37739562988, 2015.8483886719, 17.667018890381)
            end
            imgui.SameLine()
            if imgui.Button(fa.PLANE..u8' ТП в конец') then
                setCharCoordinates(PLAYER_PED, 239.16299438477, 2026.7818603516, 16.687019348145)
            end
        elseif tab == 6 then
            imgui.CenterText(fa.SQUARE_CHECK..u8' Кнопочки')
            imgui.Separator()
            if imgui.Button(fa.COMMENT_SLASH..u8' Очистить чат', imgui.ImVec2(150, 80)) then
                for i = 1, 90 do
                    sampAddChatMessage("", -1)
                end
            end
            imgui.SameLine()
            if imgui.Button(fa.SKULL..u8' Умереть', imgui.ImVec2(150, 80)) then
                setCharHealth(PLAYER_PED, 0)
            end
            imgui.SameLine()
            if imgui.Button(fa.PERSON_RAYS..u8' Спавн', imgui.ImVec2(150, 80)) then
                sendSpawn()
            end
            imgui.SameLine()
            if imgui.Button(fa.ARROW_UP..u8' Slap up', imgui.ImVec2(150, 40)) then
                local x, y, z = getCharCoordinates(PLAYER_PED)
                setCharCoordinates(PLAYER_PED, x, y, z+5)
            end
            imgui.SetCursorPosX(487)
            imgui.SetCursorPosY(93)
            if imgui.Button(fa.ARROW_DOWN..u8' Slap down', imgui.ImVec2(150, 40)) then
                local x, y, z = getCharCoordinates(PLAYER_PED)
                setCharCoordinates(PLAYER_PED, x, y, z-5)
            end
        elseif tab == 7 then
            imgui.CenterText(fa.GEARS..u8' Настройки')
		    imgui.Separator()
            if imgui.ColorEdit3('## COLOR', mmcolor, imgui.ColorEditFlags.NoInputs) then
                r,g,b = mmcolor[0] * 255, mmcolor[1] * 255, mmcolor[2] * 255
	            argb = join_argb(0, r, g, b)
                ini.theme.moonmonet = argb
                save()
			    apply_n_t()
            end
            imgui.SameLine()
            imgui.Text(fa.NOTE_STICKY..u8' Цвет MoonMonet')
            imgui.Separator()
		    imgui.Text(fa.SQUARE..u8' Кнопка "Menu"')
		    if imgui.ToggleButton(fa.CHECK..u8' Состояние', settings.menu.openbutton) then
                if settings.cfg.autosave[0] then
                    ini.menu.openbutton = settings.menu.openbutton[0]
                    save()
                end
            end
		    if imgui.SliderInt(fa.TEXT_WIDTH..u8' Ширина', settings.menu.slideropenbuttonwidth, 30, 150) then
                if settings.cfg.autosave[0] then
                    ini.menu.slideropenbuttonwidth = settings.menu.slideropenbuttonwidth[0]
                    save()
                end
            end
		    if imgui.SliderInt(fa.TEXT_HEIGHT..u8' Высота', settings.menu.slideropenbuttonheight, 30, 150) then
                if settings.cfg.autosave[0] then
                    ini.menu.slideropenbuttonheight = settings.menu.slideropenbuttonheight[0]
                    save()
                end
            end
		    imgui.Separator()
		    imgui.Text(u8'Меню')
		    if imgui.Button(fa.GEARS..u8' Настройки меню') then
		        menusettings[0] = not menusettings[0]
		    end
		    imgui.Separator()
		    imgui.Text(u8'Помощь')
		    if imgui.ToggleButton(fa.INFO..u8' | Отображать подсказки', settings.menu.showinfo) then
                if settings.cfg.autosave[0] then
                    ini.menu.showinfo = settings.menu.showinfo[0]
                    save()
                end
            end
		    if imgui.Button(fa.HANDSHAKE_ANGLE..u8' Показать кнопку взаимодействия') then
		        settings.menu.sendalt[0] = not settings.menu.sendalt[0]
                if settings.cfg.autosave[0] then
                    ini.menu.sendalt = settings.menu.sendalt[0]
                    save()
                end
		    end
		    imgui.SameLine()
		    if imgui.Button(fa.INFO..u8' Команды скрипта') then
		        imgui.OpenPopup(fa.STAR_OF_LIFE..u8' Команды скрипта '..fa.STAR_OF_LIFE)
		    end
            if imgui.BeginPopupModal(fa.STAR_OF_LIFE..u8' Команды скрипта '..fa.STAR_OF_LIFE, _, imgui.WindowFlags.AlwaysAutoResize) then
                imgui.Text(u8'/miku - основное меню скрипта')
                imgui.Text(u8'/armbot - бот на завод')
                imgui.Text(u8'/tpall - телепорт ближайших игроков к себе')
                imgui.Text(u8'/tpa {id} - телепорт игроков по айди к себе')
                imgui.Text(u8'/tpz - телепорт метка (zTeleport)')
                imgui.Text(u8'/tpc - телепорт метка (для нубо рп, моментальный)')
                imgui.Text(u8'/piss {ms} - начать ссать, если мс не указан, то бесконечно')
                imgui.Text(u8'/unpiss - перестать ссать')
                imgui.Text(u8'/ytir - бот тир')
                imgui.Text(u8'/rc - реконнект')
                imgui.Text(u8'/mine - Mine Time Render')
                if imgui.Button(fa.XMARK..u8' Закрыть') then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end
		    imgui.Separator()
		    imgui.Text(fa.SCREWDRIVER_WRENCH..u8' Отладка')
		    if imgui.Button(fa.WINDOW_RESTORE..u8' Показать mimgui demo') then
		        custommimguiStyle[0] = not custommimguiStyle[0]
		    end
		    imgui.Separator()
            if imgui.Button(fa.POWER_OFF, imgui.ImVec2(40 * MONET_DPI_SCALE, 40 * MONET_DPI_SCALE)) then
                thisScript():unload()
            end
            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                imgui.PushTextWrapPos(450)
                imgui.TextUnformatted(u8'Выключить скрипт')
                imgui.PopTextWrapPos()
                imgui.EndTooltip()
            end
            imgui.SameLine()
            if imgui.Button(fa.ROTATE_RIGHT, imgui.ImVec2(40 * MONET_DPI_SCALE, 40 * MONET_DPI_SCALE)) then
                notf('Скрипт перезагружен!', -1)
                thisScript():reload()
            end
            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                imgui.PushTextWrapPos(450)
                imgui.TextUnformatted(u8'Перезагрузить скрипт')
                imgui.PopTextWrapPos()
                imgui.EndTooltip()
            end
            imgui.SameLine()
            if imgui.Button(fa.FLOPPY_DISK, imgui.ImVec2(40 * MONET_DPI_SCALE, 40 * MONET_DPI_SCALE)) then
                imgui.OpenPopup(fa.FLOPPY_DISK..u8' Сохранение')
            end
            if imgui.BeginPopupModal(fa.FLOPPY_DISK..u8' Сохранение', _, imgui.WindowFlags.NoResize) then
                local pSize = imgui.ImVec2(300, 500)
                imgui.SetWindowSizeVec2(imgui.ImVec2(230 * MONET_DPI_SCALE, 150 * MONET_DPI_SCALE))
                if imgui.Button(fa.FLOPPY_DISK..u8' Сохранить настройки', imgui.ImVec2(205 * MONET_DPI_SCALE, 40)) then
                    ini.silent.salo = settings.silent.salo[0]
                    ini.silent.canSee = settings.silent.canSee[0]
                    ini.silent.radius = settings.silent.radius[0]
                    ini.silent.ignoreCars = settings.silent.ignoreCars[0]
                    ini.silent.distance = settings.silent.distance[0]
                    ini.silent.useWeaponRadius = settings.silent.useWeaponRadius[0]
                    ini.silent.useWeaponDistance = settings.silent.useWeaponDistance[0]
                    ini.silent.ignoreObj = settings.silent.ignoreObj[0]
                    ini.silent.line = settings.silent.line[0]
                    ini.silent.circle = settings.silent.circle[0]
                    ini.silent.fpscircle = settings.silent.fpscircle[0]
                    ini.silent.printString = settings.silent.printString[0]
                    ini.silent.misses = settings.silent.misses[0]
                    ini.silent.miss_ratio = settings.silent.miss_ratio[0]
                    ini.silent.removeAmmo = settings.silent.removeAmmo[0]
                    ini.silent.doubledamage = settings.silent.doubledamage[0]
                    ini.silent.tripledamage = settings.silent.tripledamage[0]
                    ini.silent.offsetx = settings.silent.offsetx[0]
                    ini.silent.offsety = settings.silent.offsety[0]
                    ini.ESP.enabled_boxes = settings.ESP.enabled_boxes[0]
                    ini.ESP.enabled_bones = settings.ESP.enabled_bones[0]
                    ini.ESP.enabled_nicks = settings.ESP.enabled_nicks[0]
                    ini.ESP.enabled_lines = settings.ESP.enabled_lines[0]
                    ini.ESP.boxthinkness = settings.ESP.boxthinkness[0]
                    ini.ESP.skeletonthinkness = settings.ESP.skeletonthinkness[0]
                    ini.ESP.nicknamesize = settings.ESP.nicknamesize[0]
                    ini.ESP.lineposition = settings.ESP.lineposition[0]
                    ini.ESP.linethinkness = settings.ESP.linethinkness[0]
                    ini.main.airbrakewidget = settings.main.airbrakewidget[0]
                    ini.main.clickwarpcoord = settings.main.clickwarpcoord[0]
                    ini.main.quitinformer = settings.main.quitinformer[0]
                    ini.main.informerinstream = settings.main.informerinstream[0]
                    ini.main.gzsize = settings.main.gzsize[0]
                    ini.main.gzinfo = settings.main.gzinfo[0]
                    ini.main.offdontflood = settings.main.offdontflood[0]
                    ini.main.gzname = settings.main.gzname[0]
                    ini.main.radiuslavki = settings.main.radiuslavki[0]
                    ini.ped.godmode_enabled = settings.ped.godmode_enabled[0]
                    ini.ped.noreload = settings.ped.noreload[0]
                    ini.ped.setskills = settings.ped.setskills[0]
                    ini.ped.animspeed = settings.ped.animspeed[0]
                    ini.ped.hpbar = settings.ped.hpbar[0]
                    ini.ped.speedint = settings.ped.speedint[0]
                    ini.ped.rapidfire = settings.ped.rapidfire[0]
                    ini.ped.rapidint = settings.ped.rapidint[0]
                    ini.ped.skinid = settings.ped.skinid[0]
                    ini.ped.cjrun = settings.ped.cjrun[0]
                    ini.ped.autoplusc = settings.ped.autoplusc[0]
                    ini.ped.infiniterun = settings.ped.infiniterun[0]
                    ini.car.godmode2_enabled = settings.car.godmode2_enabled[0]
                    ini.car.flycar = settings.car.flycar[0]
                    ini.car.nobike = settings.car.nobike[0]
                    ini.car.drift = settings.car.drift[0]
                    ini.car.slappower2 = settings.car.slappower2[0]
                    ini.car.atractive = settings.car.atractive[0]
                    ini.car.atrradius = settings.car.atrradius[0]
                    ini.render.ruda = settings.render.ruda[0]
                    ini.render.narkotiki = settings.render.narkotiki[0]
                    ini.render.podarok = settings.render.podarok[0]
                    ini.render.musortsr = settings.render.musortsr[0]
                    ini.render.kladrender = settings.render.kladrender[0]
                    ini.render.yabloki = settings.render.yabloki[0]
                    ini.render.slivu = settings.render.slivu[0]
                    ini.render.kokosi = settings.render.kokosi[0]
                    ini.render.derevovishkac = settings.render.derevovishkac[0]
                    ini.render.semena = settings.render.semena[0]
                    ini.render.graffiti = settings.render.graffiti[0]
                    ini.render.rtime = settings.render.rtime[0]
                    ini.render.mtrsize = settings.render.mtrsize[0]
                    ini.menu.slideropenbuttonwidth = settings.menu.slideropenbuttonwidth[0]
                    ini.menu.slideropenbuttonheight = settings.menu.slideropenbuttonheight[0]
                    ini.menu.openbutton = settings.menu.openbutton[0]
                    ini.menu.onechildwidth = settings.menu.onechildwidth[0]
                    ini.menu.onechildheight = settings.menu.onechildheight[0]
                    ini.menu.onechildposx = settings.menu.onechildposx[0]
                    ini.menu.onechildposy = settings.menu.onechildposy[0]
                    ini.menu.twochildwidth = settings.menu.twochildwidth[0]
                    ini.menu.twochildheight = settings.menu.twochildheight[0]
                    ini.menu.twochildposx = settings.menu.twochildposx[0]
                    ini.menu.twochildposy = settings.menu.twochildposy[0]
                    ini.menu.menuwidth = settings.menu.menuwidth[0]
                    ini.menu.menuheight = settings.menu.menuheight[0]
                    ini.menu.sendalt = settings.menu.sendalt[0]
                    ini.menu.sendaltwidth = settings.menu.sendaltwidth[0]
                    ini.menu.sendaltheight = settings.menu.sendaltheight[0]
                    ini.menu.showinfo = settings.menu.showinfo[0]
                    ini.menu.samelinetabs = settings.menu.samelinetabs[0]
                    ini.menu.tabswidth = settings.menu.tabswidth[0]
                    ini.menu.tabsheight = settings.menu.tabsheight[0]
                    ini.teleport.tpwait = settings.teleport.tpwait[0]
                    ini.teleport.infosize = settings.teleport.infosize[0]
                    ini.teleport.tpbar = tpbar
                    ini.teleport.tpwaiting = waiting
                    ini.objects.autormlsa = settings.objects.autormlsa[0]
                    ini.objects.autormsfa = settings.objects.autormsfa[0]
                    ini.objects.autormblockpost = settings.objects.autormblockpost[0]
                    ini.tsr.tsrbotwait = settings.tsr.tsrbotwait[0]
                    ini.tsr.autormcell = settings.tsr.autormcell[0]
                    ini.tsr.autormdoors = settings.tsr.autormdoors[0]
                    ini.tsr.autormfence = settings.tsr.autormcell[0]
                    ini.tglogger.state = settings.tglogger.state[0]
                    save()
                    notf('Настройки сохранены!', -1)
                    imgui.CloseCurrentPopup()
                end
                if imgui.ToggleButton(fa.CHECK..u8' Автосохранение', settings.cfg.autosave) then
                    ini.cfg.autosave = settings.cfg.autosave[0]
                    save()
                end
                if imgui.Button(fa.XMARK..u8' Закрыть', imgui.ImVec2(205 * MONET_DPI_SCALE, 40)) then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end
            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                imgui.PushTextWrapPos(450)
                imgui.TextUnformatted(u8'Сохранить настройки')
                imgui.PopTextWrapPos()
                imgui.EndTooltip()
            end
            imgui.SameLine()
            if imgui.Button(fa.TRASH_CAN, imgui.ImVec2(40 * MONET_DPI_SCALE, 40 * MONET_DPI_SCALE)) then
                deletescript = not deletescript
            end
            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                imgui.PushTextWrapPos(450)
                imgui.TextUnformatted(u8'Удалить скрипт')
                imgui.PopTextWrapPos()
                imgui.EndTooltip()
            end
            if settings.menu.showinfo[0] then  
                imgui.SameLine()
                imgui.TextDisabled(u8'(?)', imgui.ImVec2(30 * MONET_DPI_SCALE, 30 * MONET_DPI_SCALE))
                if imgui.IsItemHovered() then
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(u8'Зажмите кнопку пальцем, чтоб посмотреть подсказку')
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                end
            end
            if deletescript then
                imgui.Text(u8'Вы уверены?')
                if imgui.Button(fa.CHECK..u8' Да') then
                    os.remove(thisScript().path)
                    os.remove(getWorkingDirectory().."/config/MikuProject.ini")
                    thisScript():unload()
                end
                imgui.SameLine()
                if imgui.Button(fa.XMARK..u8' Нет') then
                    deletescript = not deletescript
                end
            end
        end
        imgui.EndChild()
    end
    imgui.End()
end)

--      Реконенкт и погода      --
function events.onSendClientJoin(v, m, n, cr, ak, cv, cr2)
    Reconnect.reconnecting = false
end

function events.onSetPlayerTime(h, m)
    WeatherAndTime.new_time = true
end

function events.onSetWorldTime(h)
    WeatherAndTime.new_time = true
end

--      imgui addons      --
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local height = imgui.GetWindowHeight()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function imgui.ToggleButton(str_id, value)
	local duration = 0.3
	local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
	local size = imgui.ImVec2(40, 20)
    local title = str_id:gsub('##.*$', '')
    local ts = imgui.CalcTextSize(title)
    local cols = {
    	enable = imgui.GetStyle().Colors[imgui.Col.ButtonActive],
    	disable = imgui.GetStyle().Colors[imgui.Col.TextDisabled]	
    }
    local radius = 6
    local o = {
    	x = 4,
    	y = p.y + (size.y / 2)
    }
    local A = imgui.ImVec2(p.x + radius + o.x, o.y)
    local B = imgui.ImVec2(p.x + size.x - radius - o.x, o.y)

    if AI_TOGGLE[str_id] == nil then
        AI_TOGGLE[str_id] = {
        	clock = nil,
        	color = value[0] and cols.enable or cols.disable,
        	pos = value[0] and B or A
        }
    end
    local pool = AI_TOGGLE[str_id]
    
    imgui.BeginGroup()
	    local pos = imgui.GetCursorPos()
	    local result = imgui.InvisibleButton(str_id, imgui.ImVec2(size.x, size.y))
	    if result then
	        value[0] = not value[0]
	        pool.clock = os.clock()
	    end
	    if #title > 0 then
		    local spc = imgui.GetStyle().ItemSpacing
		    imgui.SetCursorPos(imgui.ImVec2(pos.x + size.x + spc.x, pos.y + ((size.y - ts.y) / 2)))
	    	imgui.Text(title)
    	end
    imgui.EndGroup()

 	if pool.clock and os.clock() - pool.clock <= duration then
        pool.color = bringVec4To(
            imgui.ImVec4(pool.color),
            value[0] and cols.enable or cols.disable,
            pool.clock,
            duration
        )

        pool.pos = bringVec2To(
        	imgui.ImVec2(pool.pos),
        	value[0] and B or A,
        	pool.clock,
            duration
        )
    else
        pool.color = value[0] and cols.enable or cols.disable
        pool.pos = value[0] and B or A
    end

	DL:AddRect(p, imgui.ImVec2(p.x + size.x, p.y + size.y), ToU32(pool.color), 10, 15, 1)
	DL:AddCircleFilled(pool.pos, radius, ToU32(pool.color))

    return result
end

function bringVec4To(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return imgui.ImVec4(
            from.x + (count * (to.x - from.x) / 100),
            from.y + (count * (to.y - from.y) / 100),
            from.z + (count * (to.z - from.z) / 100),
            from.w + (count * (to.w - from.w) / 100)
        ), true
    end
    return (timer > duration) and to or from, false
end

function bringVec2To(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return imgui.ImVec2(
            from.x + (count * (to.x - from.x) / 100),
            from.y + (count * (to.y - from.y) / 100)
        ), true
    end
    return (timer > duration) and to or from, false
end

------main()------
function main()
    check_update()
    while not isSampAvailable() do wait(0) end
    initializeRender()
    if settings.car.godmode2_enabled[0] then
        gmcar_activate()
    else
        gmcar_reset()
    end
    nobike_activate()
    sampRegisterChatCommand('miku', function() window_state[0] = not window_state[0] end)
    sampRegisterChatCommand("tpall", function()
        tpidstate = not tpidstate
        sampAddChatMessage(tpidstate and "on" or "off", -1)
    end)
    sampRegisterChatCommand("tpa", function(arg)
        lua_thread.create(function()
            if arg then
                local arg = tonumber(arg)
                local data = samp_create_sync_data("vehicle")
                local _, handl = sampGetCharHandleBySampPlayerId(arg)
                if _ then
                    local mx, my, mz = getCharCoordinates(PLAYER_PED)
                    local x, y, z = getCharCoordinates(handl)
                    if getDistanceBetweenCoords3d(mx, my, mz, x, y, z) >= 38 then
                        return sampAddChatMessage('далеко', -1)
                    else
                        sampAddChatMessage('13', -1)
                        nop = true
                        for i = 1, 5 do
                            data.position = {x, y, z-0.4}
                            data.moveSpeed = {0, 0, 0.05}
                            data.send()
                            wait(15)
                        end
                        wait(50)
                        nop = false
                    end
                else
                    sampAddChatMessage('игрок за зоной стрима', -1)
                end 
            end
        end)
    end)
    sampRegisterChatCommand('piss', function(pisssec)
        if tonumber(pisssec) then
            local pisssec = tonumber(pisssec)
            notf('Вы будете ссать '..pisssec..' ms')
            lua_thread.create(function()
                sampSetSpecialAction(68)
                wait(pisssec)
                sampSetSpecialAction(0)
                return
            end)
        end
        sampSetSpecialAction(68)
    end)
    sampRegisterChatCommand('unpiss', function() sampSetSpecialAction(0) end)
    sampRegisterChatCommand('ytir', function()
        tirst = not tirst
        printStringNow(tirst and 'tir bot ~g~enabled' or 'tir bot ~r~disabled', 2000)
	    lua_thread.create(function()
	        while tirst do
		        local gun = getCurrentCharWeapon(PLAYER_PED)
			    if gun > 0 then
			        local myY = select(2, getCharCoordinates(PLAYER_PED))
				    local yMin, yMax = myY-0.65, myY + 0.85
				    local brk = false
				    for id = 0, 1000 do
				        local handle = sampGetObjectHandleBySampId(id)
					    if doesObjectExist(handle) then
					        local result, x, y, z = getObjectCoordinates(handle)
					        if result then
						        local model = getObjectModel(handle)
							    for i = 1588, 1592 do
							        if model == i and y < yMax and y > yMin then
									    printString("Shot!", 500)
								  	    brk = true
									    local sync = samp_create_sync_data("player")
									    sync.keys.secondaryFire_shoot = 1
									    sync.keys.aim = 1
									    sync.send()
										
									    local px, py, pz = getCharCoordinates(1)
										
									    sync = samp_create_sync_data("bullet")
									    sync.targetType = 3
									    sync.targetId = id
									    sync.center = {x = math.random(-0.3, 0.3), y = math.random(-0.3, 0.3), z = math.random(-0.3, 0.3)}
									    sync.origin = {x = px + math.random(-0.3, 0.3), y = py + math.random(-0.3, 0.3), z = pz + math.random(-0.3, 0.3)}
									    sync.target = {x = x + math.random(-0.3, 0.3), y = y + math.random(-0.3, 0.3), z = z + math.random(-0.3, 0.3)}
									    sync.weaponId = gun
									    sync.send()
									    addAmmoToChar(1, gun, -1)
									    break
								    end
							    end
						    end
					    end
					    if brk then break end
				    end
			    end
			    wait(gunsWait[gun])
		    end
	    end)
    end)
    sampRegisterChatCommand('rc', Reconnect.activate)
    sampRegisterChatCommand('mine', function() 
        mtract = not mtract
		for i = 1, 3000 do
            resources[i] = {}
            for a = 1, 4 do
                resources[i][a] = 0
            end
        end
		start = mtract and os.time() or nil
		notf(mtract and "{FFC300}Mine Time Render {FFFFFF}включен!" or '{FFC300}Mine Time Render{FFFFFF} выключен!',-1)
    end)
    sampRegisterChatCommand('tpc', function()
        result, x, y, z = getTargetBlipCoordinatesFixed()
        if result then setCharCoordinates(PLAYER_PED, x, y, z) end
    end)
    sampRegisterChatCommand("tpz", function(args)
        lua_thread.create(function()
            local bool, bx,by,bz = getTargetBlipCoordinatesFixed()
            if zettp then
                sampAddChatMessage('Ошибка. {6495ed}Уже телепортируемся.', -1)
                return
            end
            if args ~= nil and args:match('%w+ %d+') then
                local biber, dolik = args:match('(%w+) (%d+)')
                if biber == 'waiting' then
                    waiting = tonumber(dolik)
                    return sampAddChatMessage('Успешно. {6495ed}Задержка: '..waiting, -1)
                end
            elseif args == "view" then
                tpbar = not tpbar
                return
            elseif args == "" then
            else
                sampAddChatMessage('Неизвестная команда! {6495ed}Используйте /tpz', -1)
                return
            end
            if bool then
                percent = 0
                zettp = true
                if zettpincar then
                    freezeCarPosition(storeCarCharIsInNoSave(PLAYER_PED), true)
                else
                    freezeCharPosition(PLAYER_PED, true)
                end
                local x, y, z = getCharCoordinates(PLAYER_PED)
                local nx, ny, nz = x,y,z
                local dist = getDistanceBetweenCoords2d(x,y,bx,by)
                local angle = -math.rad(getHeadingFromVector2d(bx - x, by - y))
                local data = samp_create_sync_data(zettpincar and "vehicle" or "player")
                setCharCoordinates(PLAYER_PED, bx, by, bz)
                if dist > tp_dist then
                    for ds = dist-tp_dist, 0, -tp_dist do
                        data.moveSpeed = {0, 0, zettpincar and -0.1 or -0.7}
                        for i = nz, -135, -25 do
                            data.position = {nx, ny, i}
                            data.send()
                            wait(50) -- 200 ms / 150ms
                        end
                        data.moveSpeed = {0, 0, 0}
                        nx, ny, nz = nx + math.sin(angle) * tp_dist, ny + math.cos(angle) * tp_dist, -60
                        data.position = {nx, ny, nz}
                        data.send()
                        percent = math.calculate(0,100,dist,0,ds)
                        wait(waiting)
                    end
                end
                data.moveSpeed = {0, 0, zettpincar and -0.1 or -0.7}
                for i = nz, -135, -25 do
                    data.position = {nx, ny, i}
                    data.send()
                    wait(50)
                end
                data.position = {bx,by,bz}
                data.send()
                setCharCoordinates(PLAYER_PED, bx, by, bz)
                if zettpincar then
                    freezeCarPosition(storeCarCharIsInNoSave(PLAYER_PED), false)
                else
                    freezeCharPosition(PLAYER_PED, false)
                end
                sampAddChatMessage('Успех. {6495ed}Телепортировались', -1)
                zettp = false
            end
        end)
    end)
    sampRegisterChatCommand('armbot', function(round) 
		if not round:match('%d+') or round:match('[-/*+!#$%%^&()]') then
			notf('Неправильно указано количество кругов. ', -1)
			if armorbotstate then
				armorbotstate = false
				statusbot: terminate()
			end
		else
			armorbotstate = not armorbotstate
			if armorbotstate then
				if round:match('0') then
					setrounds = -1
				else
					setrounds = tonumber(round)
				end
				local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
				if _ then
					idb = id
				end
				currentrounds = 0
				statusbot: run()
				notf('Активирован.', -1)
			else
				armorbotalt = false
				point = 0
				statusbot: terminate()
				notf('Деактивирован.', -1)
			end
		end
	end)
	statusbot = lua_thread.create_suspended(botwork)
    while true do wait(0)
        if wwwflycar then
            FlyCar.processFlyCar()
        end
        if not wwwflycar then
            FlyCar.cars = 0
        end
        if settings.car.flycar[0] then
            if isCharInAnyCar(PLAYER_PED) then
                if isWidgetPressed(WIDGET_VIDEO_POKER_DEAL) then 
                     wwwflycar = not wwwflycar
                     printStringNow(wwwflycar and 'FlyCar ~g~activated' or 'FlyCar ~r~deactivated', 300)
                end
            end
        end
        if mtract then
			if not isCharInArea3d(PLAYER_PED, 393.10, 716.46, 15, 769.71, 1017.04, -55, false) then
				notf("Вы вышли с шахты, поэтому {FFC300}Mine Time Render {FFFFFF}выключен!",-1)
				mtract = false
				for i = 1, 3000 do
					resources[i] = {}
					for a = 1, 4 do
						resources[i][a] = 0
					end
				end
			end
			if os.time() - start >= 1 then
				start = os.time()
				for i = 1, 3000 do
					if resources[i][4] > 0 then
						resources[i][4] = resources[i][4] - 1
						if resources[i][4] == 15 then
							metka(resources[i][1],resources[i][2],resources[i][3])
							local pX,pY,pZ = getCharCoordinates(1)
							local dist = math.floor(getDistanceBetweenCoords3d(pX,pY,pZ, resources[i][1],resources[i][2],resources[i][3]))
							notf("{FFC300}MTR: {FFFFFF}Через ~15 секунд, в "..dist.." метрах от вас, появится руда!",-1)
						elseif resources[i][4] == 0 then
							for a = 1, 4 do
								resources[i][a] = 0
							end
						end
					end
				end
            end
			for i = 1, 3000 do
				if resources[i][4] > 0 then
					local obX, obY, obZ = resources[i][1],resources[i][2],resources[i][3]
					if isPointOnScreen(obX, obY, obZ, 0.0) then
						local wX, wY = convert3DCoordsToScreen(obX, obY, obZ)
						local timer = changetime(resources[i][4])
						renderFontDrawText(mtrfont, "Появится через "..timer.."!", wX, wY, -1)
					end
				end
			end
		end
        zettpincar = isCharInAnyCar(PLAYER_PED)
        if tpbar then
            if zettp then
                renderFontDrawText(tpfont, '{6495ed}| {ffffff}Teleporting:{6495ed} [' .. ("%0.1f"):format(percent) .. '%]\n| {ffffff}Wait:{6495ed} '..waiting, ini.teleport.x, ini.teleport.y, -1)
            else
                renderFontDrawText(tpfont, '{6495ed}| {ffffff}Mode: {6495ed}'..(zettpincar and 'Vehicle' or 'Onfoot')..'\n| {ffffff}Wait:{6495ed} '..waiting, ini.teleport.x, ini.teleport.y, -1)
            end
        end
        if settings.main.radiuslavki[0] then
            lua_thread.create(function()
                for IDTEXT = 0, 2048 do
                    if sampIs3dTextDefined(IDTEXT) then
                        local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
                        if text ==  "Управления товарами." and not isCentralMarket(posX, posY) then
                            local myPos = {getCharCoordinates(1)}
                            drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,	getDistanceBetweenCoords3d(posX,posY,0,myPos[1],myPos[2],0) > 5 and 0xFFFFFFFF or 0xFFFF0000)
                        end
                    end
                end
            end)
        end
        if tpidstate then
            local data = samp_create_sync_data("vehicle")
            local streamresult, handl, arg = getPlayerStream(25)
            if streamresult then
                local mx, my, mz = getCharCoordinates(PLAYER_PED)
                local x, y, z = getCharCoordinates(handl)
                local nickname = sampGetPlayerNickname(arg)
                nop = true
                for i = 1, 5 do
                    data.position = {x, y, z-0.4}
                    data.moveSpeed.z = 0.05
                    data.send()
                    wait(15)
                end
                wait(20)
                for i = 1, 3 do
                    data.position = {mx, my, mz}
                    data.moveSpeed.z = 0.05
                    data.send()
                    wait(15)
                end
                printStringNow("Teleport a player: "..nickname.."["..arg.."]", 100)
            else
                nop = false
                printStringNow("Try found a player", 100)
            end
        end
        if settings.main.gzinfo[0] then
            lua_thread.create(function()
                renderFontDrawText(gzfont, string.format("{00FF00}Зелёная зона: {FF0000}%s", gz == '65535' and 'Нет' or (settings.main.gzname[0] and gz or 'Да')), ini.main.gzposx, ini.main.gzposy, 0xFFFFFFFF)
            end)
        end
        if settings.objects.autormlsa[0] then
            lua_thread.create(function()  
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 975 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
        if settings.tsr.autormcell[0] then
            lua_thread.create(function()    
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19303 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
        if settings.tsr.autormdoors[0] then
            lua_thread.create(function()    
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19857 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
        if settings.tsr.autormfence[0] then
            lua_thread.create(function()    
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 19912 then
                        deleteObject(obj)
                    end
                    if modeid == 19913 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
        if settings.objects.autormsfa[0] then
            lua_thread.create(function()    
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 988 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
        if settings.objects.autormblockpost[0] then
            lua_thread.create(function() 
                for _, obj in pairs(getAllObjects()) do
                    local modeid = getObjectModel(obj)
                    if modeid == 968 then
                        deleteObject(obj)
                    end
                end
                return
            end)
        end
		if settings.car.atractive[0] and isCharInAnyCar(1) and getDriverOfCar(getCarCharIsUsing(1)) == 1 then
			local x, y = getScreenResolution()
			x = x / 2 - settings.car.atrradius[0] / 2
			y = y / 3.3 - settings.car.atrradius[0] / 2
			renderDrawLine(x, y, x + settings.car.atrradius[0], y, 3, -1)
			renderDrawLine(x, y, x, y + settings.car.atrradius[0] + 3, 3, -1)
			renderDrawLine(x, y + settings.car.atrradius[0], x + settings.car.atrradius[0], y + settings.car.atrradius[0], 3, -1)
			renderDrawLine(x + settings.car.atrradius[0], y, x + settings.car.atrradius[0], y + settings.car.atrradius[0], 3, -1)
			local atrvehs = getAllVehicles()
			local atrclear = true
			if #atrvehs > 0 then
				for i = 1, #atrvehs do
					if atrvehs[i] ~= getCarCharIsUsing(1) then
						local xx, yy, zz = getCarCoordinates(atrvehs[i])
						local xxx, yyy = convert3DCoordsToScreen(xx, yy, zz)
						local px, py, pz = getCharCoordinates(1)
						if xxx >= x and xxx <= x + settings.car.atrradius[0] and yyy >= y and yyy <= y + settings.car.atrradius[0] and isCarOnScreen(atrvehs[i]) and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= 20 then
							renderDrawLine(xxx, yyy, x + settings.car.atrradius[0] / 2, y + settings.car.atrradius[0] / 2, 3, -1)
							atrtrailer = atrvehs[i]
							atrclear = false
							break
						end
					end
				end
			end
			if atrclear then
				atrtrailer = nil
			end
		end
		if settings.car.atractive[0] then
		    local widgetatr = isWidgetPressed(WIDGET_ARCADE_RESET)
		    if isCharInAnyCar(PLAYER_PED) and widgetatr and atrtrailer ~= nil then
		    	if isCharInAnyCar(1) and doesVehicleExist(atrtrailer) then
				    if isTrailerAttachedToCab(atrtrailer, getCarCharIsUsing(1)) then
					    detachTrailerFromCab(atrtrailer, getCarCharIsUsing(1))
					    atrtrailer = nil
				    else
				    	attachTrailerToCab(atrtrailer, getCarCharIsUsing(1))
				    end
			    end
			    atrtrailer = nil
		    end
		    widgetatr = was_pressed_menu
	    end
		if armorbotstate then
			local x, y, z = getCharCoordinates(PLAYER_PED)
			if currentrounds == setrounds or z > 1044.125 then
				notf('Бот завершил работу.', -1)
				armorbotstate = false
				armorbotalt = false
				point = 0
				currentrounds = 0
				statusbot: terminate()
			end
			if detal1 ~= -1 then
				wait(math.random(450, 550))
				sampSendClickTextdraw(detal1)
				wait(math.random(450, 550))
				sampSendClickTextdraw(detal2)
				detal1, detal2 = -1, -1
			end
		end
        weapon = getCurrentCharWeapon(PLAYER_PED)
		local result = isCharShooting(PLAYER_PED)
		if autopc == true and result and weapon == 24 then
			wait(5)
			clearCharTasksImmediately(PLAYER_PED)
		end
		if autopc == true and result and weapon == 25 then
			wait(5)
			clearCharTasksImmediately(PLAYER_PED)
		end
        if settings.ped.autoplusc[0] then
		    autopc = true
			taskSetIgnoreWeaponRangeFlag(PLAYER_PED, false)
		else
			autopc = false
			taskSetIgnoreWeaponRangeFlag(PLAYER_PED, true)
		end
        if settings.ped.hpbar[0] then
            if not isPauseMenuActive() then
                if activebar == 1 then
                    local HP = getCharHealth(playerPed)
                    local arm = getCharArmour(playerPed)
                    local playerposX, playerposY, playerposZ = getCharCoordinates(playerPed)
                    local screenX, screenY = convert3DCoordsToScreen(playerposX, playerposY, playerposZ)
                    local screenYY = screenY + 30
                    drawBar(screenX - 50, screenY, 100, 20, 0xBFDF0101, 0xBF610B0B, 2, font, HP)
                    drawBar(screenX - 50, screenYY, 100, 20, -1, 0xBF610B0B, 2, font, arm)
                end
            end
        end
        if settings.main.clickwarpcoord[0] then
            local pressed_menu = isWidgetPressed(WIDGET_KISS)
            if pressed_menu and not was_pressed_menu then
                if not chooseActive then wait(200) 
                else removePointMarker() end
                chooseActive = not chooseActive
                printStringNow(chooseActive and "Choose position" or "You canceled choice", 3000)
            end
            was_pressed_menu = pressed_menu
            if tpclick then
                local dist = getDistanceBetweenCoords3d(blipX, blipY, blipZ, charPosX, charPosY, charPosZ)
		        if dist > 20 then
                    height = blipZ > charPosZ
			        sync = true
                    if not isCharInAnyCar(PLAYER_PED) then
                        speed = 20
                    else
                        vehId = select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED)))
                        speed = 20
                    end
                    vectorX = blipX - charPosX
                    vectorY = blipY - charPosY
                    vectorZ = blipZ - charPosZ
                    local vec = Vector3D(vectorX, vectorY, vectorZ)
                    vec:normalize()
                    charPosX = charPosX + vec.x * speed
                    charPosY = charPosY + vec.y * speed
                    charPosZ = charPosZ + vec.z * speed
                    packets = packets + speed
                    if not isCharInAnyCar(PLAYER_PED) then
                        footcoord(charPosX, charPosY, charPosZ, false)
                        wait(5)
                    else
                        incarcoord(vehId, charPosX, charPosY, charPosZ, false)
                        wait(5)
                    end
                    if not isCharInAnyCar(PLAYER_PED) then
                        if packets >= 80 then
                            for i = charPosZ, -125, -20 do
                                footcoord(charPosX, charPosY, i, false)
                            end
                            if dist > 100 then
                                charPosX = charPosX + vec.x * 175
                                charPosY = charPosY + vec.y * 175
                            end
                            footcoord(charPosX, charPosY, charPosZ, false)
                            wait(850)
                            packets = 0
                        end
                    else
                        if packets >= 270 then
                            footcoord(charPosX, charPosY, -125, true)
                            footcoord(charPosX, charPosY, charPosZ, true)
                            sampSendEnterVehicle(vehId, false)
                            wait(450)
                            incarcoord(vehId, charPosX, charPosY, charPosZ, false)
                            packets = 0
                        end
                    end
                    local dist = getDistanceBetweenCoords3d(blipX, blipY, blipZ, charPosX, charPosY, charPosZ)
                    if dist > 20 then
                        printStringNow(string.format("%0.2fm", dist), 750)
                    end
                else
                    if not isCharInAnyCar(PLAYER_PED) then
                        footcoord(blipX, blipY, blipZ, false)
                        setCharCoordinatesDontResetAnim(PLAYER_PED, blipX, blipY, blipZ)
                    else
                        vehId = select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED)))
                        for i = 1, 3 do
                            incarcoord(vehId, blipX, blipY, blipZ, false)
                        end
                        setCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED), blipX, blipY, blipZ)
                    end
                    tpclick = false
                    sync = false
                    packets = 0
                end
            end
        end
        if settings.ped.infiniterun[0] then
            setPlayerNeverGetsTired(playerHandle, true)
        else
            setPlayerNeverGetsTired(playerHandle, false)
        end
        if settings.ped.cjrun[0] then
			setAnimGroupForChar(PLAYER_PED, "PLAYER")
		else
			setAnimGroupForChar(PLAYER_PED, usePlayerAnimGroup and "PLAYER" or isCharMale(PLAYER_PED) and "MAN" or "WOMAN")
		end
        if floodalt[0] then
            local bs = raknetNewBitStream()
            raknetBitStreamWriteInt8(bs, 220)
            raknetBitStreamWriteInt8(bs, 63)
            raknetBitStreamWriteInt8(bs, 8)
            raknetBitStreamWriteInt32(bs, 7)
            raknetBitStreamWriteInt32(bs, -1)
            raknetBitStreamWriteInt32(bs, 0)
            raknetBitStreamWriteString(bs, "")
            raknetSendBitStreamEx(bs, 1, 7, 1)
            raknetDeleteBitStream(bs)
            return
        end
        if enabledair then
            processAirBrake()
        end
        if settings.main.airbrakewidget[0] then
			if isWidgetDoubletapped(WIDGET_PLAYER_INFO) then
				if not was_doubletapped then
					enabledair = not enabledair
					if not enabledair then
						if last_car ~= nil and doesVehicleExist(last_car) and was_in_car then
							freezeCarPosition(last_car, false)
							setCarCollision(last_car, true)
						end
						if not was_in_car then
							freezeCharPosition(PLAYER_PED, false)
							setCharCollision(PLAYER_PED, true)
						end
						was_in_car = false
					end
					was_doubletapped = true
				end
			else
				was_doubletapped = false
			end
		end
        if settings.ped.setskills[0] then
            for i = 0, 10 do
                local bs = raknetNewBitStream()
                raknetBitStreamWriteInt16(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) -- Player ID
                raknetBitStreamWriteInt32(bs, i) -- Skill ID
                raknetBitStreamWriteInt16(bs, 999) -- Level
                raknetEmulRpcReceiveBitStream(34, bs)
                raknetDeleteBitStream(bs)
            end
        end
        if settings.ped.noreload[0] then
            local weap = getCurrentCharWeapon(PLAYER_PED)
            local nbs = raknetNewBitStream()
            raknetBitStreamWriteInt32(nbs, weap)
            raknetBitStreamWriteInt32(nbs, 0)
            raknetEmulRpcReceiveBitStream(22, nbs)
            raknetDeleteBitStream(nbs)
        end
        if settings.ped.animspeed[0] then
            setCharAnimSpeed(PLAYER_PED, 'RUN_CIVI', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_1ARMED', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_ARMED', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_CSAW', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_FAT', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_FATOLD', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_GANG1', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_LEFT', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_OLD', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_PLAYER', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_RIGHT', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_ROCKET', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_WUZI', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_STOP', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'RUN_STOPR', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLE_STANCE', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'XPRESSSCRATCH', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'ROADCROSS', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'ROADCROSS_FEMALE', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'ROADCROSS_GANG', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'ROADCROSS_OLD', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLE_STANCE', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLE_HBHB', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLE_GANG1', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLE_ARMED', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLESTANCE_OLD', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLESTANCE_FAT', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'FIGHTIDLE', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'FIGHTA_M', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'FIGHTA_1', settings.ped.speedint[0])
            setCharAnimSpeed(PLAYER_PED, 'IDLESTANCE_FAT', settings.ped.speedint[0])
        end
        if settings.ped.rapidfire[0] then
            setCharAnimSpeed(PLAYER_PED, "PYTHON_CROUCHFIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "PYTHON_FIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "PYTHON_FIRE_POOR", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "PYTHON_CROCUCHRELOAD", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "RIFLE_CROUCHFIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "RIFLE_CROUCHLOAD", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "RIFLE_FIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "RIFLE_FIRE_POOR", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "RIFLE_LOAD", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SHOTGUN_CROUCHFIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SHOTGUN_FIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SHOTGUN_FIRE_POOR", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SILENCED_CROUCH_RELOAD", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SILENCED_CROUCH_FIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SILENCED_FIRE", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "SILENCED_RELOAD", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "TEC_crouchfire", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "TEC_crouchreload" , settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "TEC_fire", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "TEC_reload", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "UZI_crouchfire", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "UZI_crouchreload", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "UZI_fire", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "UZI_fire_poor", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "UZI_reload", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "idle_rocket", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "Rocket_Fire", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "run_rocket", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "walk_rocket", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "WALK_start_rocket", settings.ped.rapidint[0])
            setCharAnimSpeed(PLAYER_PED, "WEAPON_sniper", settings.ped.rapidint[0])
        end
        if settings.silent.salo[0] then
            lua_thread.create(function() 
                wait(0)
                if ped ~= nil then
                    local _, id = sampGetPlayerIdByCharHandle(ped)
                    if _ then
                        targetId = id
                    end
                else
                    targetId = -1
                end
            end)
        end
        if settings.car.drift[0] then
            if isCharInAnyCar(playerPed) then 
                local car = storeCarCharIsInNoSave(playerPed)
                local speed = getCarSpeed(car)
                isCarInAirProper(car)
                setCarCollision(car, true)
                if isVehicleOnAllWheels(car) and doesVehicleExist(car) and speed > 5.0 then
                    setCarCollision(car, false)
                end
            end
        end
        if settings.render.ruda[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = ruda1[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.semena[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = semenanarko[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.narkotiki[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = narko[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.derevovishkac[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = derevovish[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.podarok[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = gift[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.yabloki[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = apple[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.musortsr[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = musor[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.slivu[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = sliva[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.kladrender[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = klad[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.kokosi[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = kokos[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
        if settings.render.graffiti[0] then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = graffity[modelid]
                if _obj then
                    if isObjectOnScreen(obj_hand) then
                        local x,y,z = getCharCoordinates(PLAYER_PED)
                        local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                        if res then
                            local dist = math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1))
                            local c1,c2 = convert3DCoordsToScreen(x,y,z)
                            local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                            local text = '{87CEEB}'.._obj..'\n{87CEEB}DIST: '..dist..'m.'
                            renderDrawLine(c1,c2,o1,o2,1, 0xB8B8FCFF)
                            renderFontDrawText(font,text,o1,o2,-1)
                        end
                    end
                end
            end
        end
    end
end
lua_thread.create(function()
    while not isSampAvailable() do wait(0) end
    while true do
        wait(200)
        if settings.main.gzinfo[0] then
            local spawnchecked = sampIsLocalPlayerSpawned()
            if spawnchecked then 
                sampSendChat('/gzinfo')
            end
        end
    end
end)

--      Общие эвенты        --
function events.onSendVehicleSync(data)
    if enabledair then
        local mx, my = getMoveSpeed(getCharHeading(PLAYER_PED), speed > 2 and 2 or speed)
        data.moveSpeed.x = mx
        data.moveSpeed.y = my
    end
    if tpclick then 
        return false
	end
    if nop and settings.car.antisync[0] then
        return false
    end
end

function events.onShowDialog(dlgid, stl, tlt, b1, b2, text)
	if armorbotstate and string.find(text, 'Администратор') or string.find(text, 'телепортированы') then
		sampAddChatMessage('{FF0000}[WARNING] {FFFFFF}Вам написал администратор, закругляемся...', -1)
		lua_thread.create(function()
			wait(math.random(1470, 1955))
			point = 0
			armorbotstate = false
			statusbot: terminate()
		end)	
	end
    if zettp and zettpincar and id == 26263 then
        return false
    end
end

function events.onServerMessage(color, text)
	if settings.tglogger.state[0] then
	    getLastUpdate()
        sendTelegramNotification('[' .. os.date("%x") .. ']  ' .. text)
 	    lua_thread.create(get_telegram_updates)
 	end
 	if text:find('E_CURRENT_AREA_TYPE_INDEX') and color == -16776961 then
		return false
	end
	if text:find('E_AREA_TYPE_ID') and color == -16776961 then
		return false
	end
    if text:find('current gz index: (.+)') and color == -16776961 then
        gz = text:match('current gz index: (.+)')
        return false
    end
    if settings.main.offdontflood[0] and text:find('Не флуди!') then
        return false
    end
    if armorbotstate then
		if string.find(txt, 'Вы сделали бракованную деталь') then
			lua_thread.create(function()
				wait(math.random(200, 300))
				point = 0
				statusbot: terminate()
				wait(100)
				statusbot: run()
			end)
		end
		if string.find(txt, 'ответил вам') or string.find(txt, 'телепортированы') then	
			sampAddChatMessage('{FF0000}[WARNING] {FFFFFF}Вам написал администратор, закругляемся...', -1)
			lua_thread.create(function()
				wait(math.random(1470, 1955))
				point = 0
				statusbot: terminate()
			end)	
		end
	end
end

function events.onSendPlayerSync(data)
    if enabledair then
        local mx, my = getMoveSpeed(getCharHeading(PLAYER_PED), speed > 1 and 1 or speed)
        data.moveSpeed.x = mx
        data.moveSpeed.y = my
    end
    if tpclick then
        return false
	end
end

function setPlayerCarCoordinatesFixed(x, y, z)
    local ox, oy, oz = getCharCoordinates(PLAYER_PED)
    setCharCoordinates(PLAYER_PED, ox, oy, oz)
    local nx, ny, nz = getCharCoordinates(PLAYER_PED)
    local xoff = nx - ox
    local yoff = ny - oy
    local zoff = nz - oz
    setCharCoordinates(PLAYER_PED, x - xoff, y - yoff, z - zoff)
end

function getTargetBlipCoordinatesFixed()
    local bool, x, y, z = getTargetBlipCoordinates(); if not bool then return false end
    requestCollision(x, y); loadScene(x, y, z)
    local bool, x, y, z = getTargetBlipCoordinates()
    return bool, x, y, z
end

--      unoccupied      --
function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    -- from SAMP.Lua
    local raknet = require 'samp.raknet'
    --require 'samp.synchronization'

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    -- copy player's sync data to the allocated memory
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    -- function to send packet
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    -- metatable to access sync data and 'send' function
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

--      spawnself     --
function sendSpawn()
	lua_thread.create(function()
	    nop = true
        sampSendDeathByPlayer(65535, 51)
        wait(20)
        sampRequestClass(1)
        sampSendSpawn()
        nop = false
	end)
end

--      silent aim      --
local weapons = {
    {
        id = 22,
        delay = 160,
        dmg = 8.25,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 23,
        delay = 120,
        dmg = 13.2,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 24,
        delay = 800,
        dmg = 46.2,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 25,
        delay = 800,
        dmg = 3.3,
        distance = 40,
        camMode = 53,
        weaponState = 1
    },
    {
        id = 26,
        delay = 120,
        dmg = 3.3,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 27,
        delay = 120,
        dmg = 4.95,
        distance = 40,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 28,
        delay = 50,
        dmg = 6.6,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 29,
        delay = 90,
        dmg = 8.25,
        distance = 45,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 30,
        delay = 90,
        dmg = 9.9,
        distance = 70,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 31,
        delay = 90,
        dmg = 9.9,
        distance = 90,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 32,
        delay = 70,
        dmg = 6.6,
        distance = 35,
        camMode = 53,
        weaponState = 2
    },
    {
        id = 33,
        delay = 800,
        dmg = 24.75,
        distance = 100,
        camMode = 53,
        weaponState = 1
    },
    {
        id = 34,
        delay = 900,
        dmg = 41.25,
        distance = 320,
        camMode = 7,
        weaponState = 1
    },
    {
        id = 38,
        delay = 20,
        dmg = 46.2,
        distance = 75,
        camMode = 53,
        weaponState = 2
    },  
}

imgui.OnFrame(
    function()
        return settings.silent.salo[0] and not isGamePaused()
    end,
    function(circle)
        circle.HideCursor = true
        local xw, yw = getScreenResolution()
        if isCharOnFoot(PLAYER_PED) then
        	local excolor = silentfovcolor.colornew
            if settings.silent.circle[0] then
                if not settings.silent.fpscircle[0] then
                    imgui.GetBackgroundDrawList():AddCircleFilled(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), 3, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 1.00)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircleFilled(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx(), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.40)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-2, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.70)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-4, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.60)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-6, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.50)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-8, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.40)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-10, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.30)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-12, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.20)), 128, 3)
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx()-14, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.10)), 128, 3)
                else
                    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]), getpx(), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 0.30)), 128, 3)
                end
            end
            local chars = getAllChars()
            local clear = true
            if #chars > 0 then
                for i, v in pairs(chars) do
                    if isCharOnFoot(PLAYER_PED) and chars[i] ~= PLAYER_PED then
                        local _, id = sampGetPlayerIdByCharHandle(chars[i])
                        if _ then
                            local xx, yy, zz = getCharCoordinates(chars[i])
                            local xxx, yyy = convert3DCoordsToScreen(xx, yy, zz)
                            local px, py, pz = getCharCoordinates(PLAYER_PED)
                            local oX, oY = xw / 2 + settings.silent.offsetx[0], yw / 2.5 + settings.silent.offsety[0]
                            local x, y = math.abs(xxx-oX), math.abs(yyy-oY)
                            local distFromCenter = math.sqrt(x^2+y^2)
                            local weapone = getWeaponInfoById(getCurrentCharWeapon(PLAYER_PED))
                            if weapone ~= nil and distFromCenter <= getpx() and isCharOnScreen(chars[i]) and targetId ~= nil then
                                if settings.silent.useWeaponDistance[0] and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= weapone.distance then
                                    if settings.silent.line[0] then
                                        imgui.GetBackgroundDrawList():AddLine(imgui.ImVec2(oX, oY), imgui.ImVec2(xxx, yyy), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 1.00)), 2)
                                        imgui.GetBackgroundDrawList():AddCircleFilled(imgui.ImVec2(xxx, yyy), 3, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 1.00)))
                                    end
                                    if targetId ~= nil then
                                        clear = false 
                                        ped = chars[i]
                                    end
                                    break
                                elseif not settings.silent.useWeaponDistance[0] and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= settings.silent.distance[0] then
                                    if settings.silent.line[0] then
                                        imgui.GetBackgroundDrawList():AddLine(imgui.ImVec2(oX, oY), imgui.ImVec2(xxx, yyy), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 1.00)), 2)
                                        imgui.GetBackgroundDrawList():AddCircleFilled(imgui.ImVec2(xxx, yyy), 3, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(excolor.x, excolor.y, excolor.z, 1.00)))
                                    end
                                    if targetId ~= nil then
                                        clear = false 
                                        ped = chars[i]
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if clear then
                ped = nil
            end
        end
    end
)

function getWeaponInfoById(id)
    for k, weapon in pairs(weapons) do
        if weapon.id == id then
            return weapon
        end
    end
    return nil
end

function rand()
    return math.random(-50, 50) / 100
end

function getMyId()
    return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
end

function events.onSendBulletSync(sync)
    if settings.silent.salo[0] then
        local res, _, ped = pcall(sampGetCharHandleBySampPlayerId, targetId)
        if _ and res then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local x, y, z = getCharCoordinates(ped)
            if isLineOfSightClear(x, y, z, mx, my, mz, not settings.silent.ignoreObj[0], not settings.silent.ignoreCars[0], false, not settings.silent.ignoreObj[0], false) then
                local weapon = getWeaponInfoById(getCurrentCharWeapon(PLAYER_PED))
                if weapon ~= nil then
                    lua_thread.create(function() 
                        if sync.targetType == 1 then
                            return
                        end
                        sync.targetType = 1
                        sync.targetId = targetId
                        sync.center = {x = rand(), y = rand(), z = rand()}
                        sync.target = {x = x + rand(), y = y + rand(), z = z + rand()}
                        if settings.silent.removeAmmo[0] then
                            addAmmoToChar(PLAYER_PED, getCurrentCharWeapon(PLAYER_PED), -1)
                        end
                        if not miss then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 3)
                            if settings.silent.doubledamage[0] then
                                sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 3)
                                if settings.silent.tripledamage[0] then
                                    sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 3)
                                end
                            end
                        end
                        if settings.silent.printString[0] then
                            printStringNow(miss and 'Shot missed' or string.format('Player ~r~%d ~w~damaged', targetId), 500)
                        end
                    end)
                end
            end
        end
    end
end

function events.onSendAimSync(data)
    if settings.silent.salo[0] and fakemode[0] then
        camX = data.camPos.x
		camY = data.camPos.y
		camZ = data.camPos.z
		
		frontX = data.camFront.x
		frontY = data.camFront.y
		frontZ = data.camFront.z

        local res, _, ped = pcall(sampGetCharHandleBySampPlayerId, targetId)
        if _ and res then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local x, y, z = getCharCoordinates(ped)
            if isLineOfSightClear(x, y, z, mx, my, mz, not settings.silent.ignoreObj[0], not settings.silent.ignoreCars[0], false, not settings.silent.ignoreObj[0], false) then
                local weapon = getWeaponInfoById(getCurrentCharWeapon(PLAYER_PED))
                if weapon ~= nil then
                    local b = 0 * math.pi / 360.0
                    local h = 0 * math.pi / 360.0 
                    local angle = getCharHeading(ped)
                    local a = angle * math.pi / 360.0

                    local c1, c2, c3 = math.cos(h), math.cos(a), math.cos(b)
                    local s1, s2, s3 = math.sin(h), math.sin(a), math.sin(b)

                    data.camMode = weapon.camMode
                    data.weaponState = weapon.weaponState

                    data.camPos.x = mx
                    data.camPos.y = my
                    data.camPos.z = mz

                    local dx = x - data.camPos.x
                    local dy = y - data.camPos.y
                    local dz = z - data.camPos.z

                    data.camFront.x = dx / vect3_length(dx, dy, dz)
                    data.camFront.y = dy / vect3_length(dx, dy, dz)
                    data.camFront.z = dz / vect3_length(dx, dy, dz)
                end
            end
        end
    end
end

function vect3_length(x, y, z)
    return math.sqrt(x * x + y * y + z * z)
end

-- Сохранение настроек скрипта
function save()
    inicfg.save(ini, directIni)
end

-- AirBrake
local was_doubletapped = false
local enabledair = false
local speed = 0.3
local was_in_car = false
local last_car

function getMoveSpeed(heading, speed)
    return math.sin(-math.rad(heading)) * speed, math.cos(-math.rad(heading)) * speed
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
        local ptr = getCharPointer(char)
        setEntityCoordinates(ptr, x, y, z)
    end
end

function setEntityCoordinates(entityPtr, x, y, z)
    if entityPtr ~= 0 then
        local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
        if matrixPtr ~= 0 then
            local posPtr = matrixPtr + 0x30
            writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
            writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
            writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
        end
    end
end

function processSpecialWidgets()
    local delta = 0
    if isWidgetPressed(WIDGET_ZOOM_IN) then
        delta = delta + speed / 2
    end
    if isWidgetPressed(WIDGET_ZOOM_OUT) then
        delta = delta - speed / 2
    end
    if isWidgetPressed(WIDGET_VIDEO_POKER_ADD_COIN) then
        speed = speed + 0.01
        if speed > 3.5 then speed = 3.5 end
        printStringNow('Speed: ' .. string.format("%.2f", speed), 500)
    end
    if isWidgetPressed(WIDGET_VIDEO_POKER_REMOVE_COIN) then
        speed = speed - 0.01
        if speed < 0.1 then speed = 0.1 end
        printStringNow('Speed: ' .. string.format("%.2f", speed), 500)
    end
    return delta
end

function processAirBrake()
    local x1, y1, z1 = getActiveCameraCoordinates()
    local x, y, z = getActiveCameraPointAt()
    local angle = -math.rad(getHeadingFromVector2d(x - x1, y - y1))
    if isCharInAnyCar(PLAYER_PED) then
        local car = storeCarCharIsInNoSave(PLAYER_PED)
        if car ~= last_car and last_car ~= nil and doesVehicleExist(last_car) and was_in_car then
            freezeCarPosition(last_car, false)
            setCarCollision(last_car, true)
        end
        was_in_car = true
        last_car = car
        freezeCarPosition(car, true)
        setCarCollision(car, false)
        local result, var_1, var_2 = isWidgetPressedEx(WIDGET_VEHICLE_STEER_ANALOG, 0)
        if not result then
            var_1 = 0
            var_2 = 0
        end
        local intensity_x = var_1 / 127
        local intensity_y = var_2 / 127
        local cx, cy, cz = getCharCoordinates(PLAYER_PED)
        cx = cx - (math.sin(angle) * speed * intensity_y)
        cy = cy - (math.cos(angle) * speed * intensity_y)
        cx = cx + (math.cos(angle) * speed * intensity_x)
        cy = cy - (math.sin(angle) * speed * intensity_x)
        cz = cz + processSpecialWidgets()
        setPlayerCarCoordinatesFixed(cx, cy, cz)
        setCarHeading(car, math.deg(-angle))
        if intensity_x ~= 0 then
            restoreCameraJumpcut()
        end
    else
        if was_in_car and last_car ~= nil and doesVehicleExist(last_car) then
            freezeCarPosition(last_car, false)
            setCarCollision(last_car, true)
        end
        was_in_car = false
        freezeCharPosition(PLAYER_PED, true)
        setCharCollision(PLAYER_PED, false)
        local result, var_1, var_2 = isWidgetPressedEx(WIDGET_PED_MOVE, 0)
        if not result then
            var_1 = 0
            var_2 = 0
        end
        local intensity_x = var_1 / 127
        local intensity_y = var_2 / 127
        local cx, cy, cz = getCharCoordinates(PLAYER_PED)
        cx = cx - (math.sin(angle) * speed * intensity_y)
        cy = cy - (math.cos(angle) * speed * intensity_y)
        cx = cx + (math.cos(angle) * speed * intensity_x)
        cy = cy - (math.sin(angle) * speed * intensity_x)
        cz = cz + processSpecialWidgets()
        setCharCoordinatesDontResetAnim(PLAYER_PED,  cx, cy, cz)
        local ped = getCharPointer(playerPed)
        memory.setuint8(ped + 0x46C, 3, true)
        setCharVelocity(PLAYER_PED, 0, 0, 0)
        setCharHeading(PLAYER_PED, math.deg(-angle))
    end
end

function givePlayerGun(id, ammo)
    local model = getWeapontypeModel(id)
    requestModel(model)
    loadAllModelsNow()
    giveWeaponToChar(PLAYER_PED, id, settings.dgun.ammo[0])
end

-- hpbar
function drawBar(posX, posY, sizeX, sizeY, color1, color2, borderThickness, font, value)
    renderDrawBoxWithBorder(posX, posY, sizeX, sizeY, color2, borderThickness, 0xFF000000)
    renderDrawBox(posX + borderThickness, posY + borderThickness, sizeX / 100 * value - (borderThickness * 2), sizeY - (2 * borderThickness), color1)
    local textLenght = renderGetFontDrawTextLength(font, tostring(value))
    local textHeight = renderGetFontDrawHeight(font)
    renderFontDrawText(font, tostring(value), posX + (sizeX / 2) - (textLenght / 2), posY + (sizeY / 2) - (textHeight / 2), 0xFFFFFFFF)
end

function activatecmd()
    if activebar == 0 then
        activebar = 1
    else
        activebar = 0
    end
end

-- clickcoordmobile
function initializeRender()
  	font = renderCreateFont("Arial", 17, 4)
  	lua_thread.create(function()
      	while true do
          	wait(0)
          	if chooseActive and pointMarker then
              	renderFontDrawText(font, "Left your finger from the screen to teleport", renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs * 3) - 150, renderInfo.rcolor) 
              	renderFontDrawText(font, string.format("%0.2fm", renderInfo.rdist), renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs*2) - 150, 0xEEEEEEEE)		  
  				if renderInfo.rcar ~= 0 then 
					renderFontDrawText(font, string.format("%s", findCarName(getCarModel(renderInfo.rcar))), renderInfo.rsx, renderInfo.rsy - renderInfo.rhoffs - 150, 0xEEEEEEEE) 
				end 
          	end
      	end
  	end)
end

function onTouch(type, id, x, y)
    if chooseActive then
      	local sx, sy = x, y
      	local sw, sh = getScreenResolution()
      	if sx >= 0 and sy >= 0 and sx < sw and sy < sh and id == 0 then
        	local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
        	local camX, camY, camZ = getActiveCameraCoordinates()
        	local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
       	 	if result and colpoint.entity ~= 0 then
          		local normal = colpoint.normal
          		local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
          		local zOffset = 300
          		if normal[3] >= 0.5 then 
					zOffset = 1 
				end
          		local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3, true, true, false, true, false, false, false)
          		if result then
            		pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

            		local curX, curY, curZ  = getCharCoordinates(PLAYER_PED)
            		local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
            		local hoffs             = renderGetFontDrawHeight(font)
            		local color              = 0xAAFFFFFF  
           
            		sy = sy - 2
            		sx = sx - 2
            		renderInfo = {rsx = sx, rsy = sy, rhoffs = hoffs, rdist = dist, rcar = 0, rcolor = 0xAAFFFFFF}
            		tpIntoCar = nil
            		if colpoint.entityType == 2 then
              			local car = getVehiclePointerHandle(colpoint.entity)
             		 	if doesVehicleExist(car) and (not isCharInAnyCar(PLAYER_PED) or storeCarCharIsInNoSave(PLAYER_PED) ~= car) then
                			tpIntoCar = car
                			color = 0xFFFFFFFF
                			renderInfo = {rsx = renderInfo.rsx, rsy = renderInfo.rsy, rhoffs = renderInfo.rhoffs, rdist = renderInfo.rdist, rcar = car, rcolor = color}
                		end
              		end
            	end
            	createPointMarker(pos.x, pos.y, pos.z)
            
            	if type == 1 then
              		if tpIntoCar then
                		if not jumpIntoCar(tpIntoCar) then
                	  		teleportPlayer(pos.x, pos.y, pos.z)
							tpclick = true
                		end
              		else
                	  	teleportPlayer(pos.x, pos.y, pos.z)
						tpclick = true
              		end
              		removePointMarker()
              		renderInfo.rcar = 0
              		chooseActive = false
            	end
        	end
    	end
    end
end

function getCarFreeSeat(car)
  	if doesCharExist(getDriverOfCar(car)) then
    	local maxPassengers = getMaximumNumberOfPassengers(car)
    	for i = 0, maxPassengers do
      		if isCarPassengerSeatFree(car, i) then
       	 		return i + 1
      		end
    	end
    	return nil 
 	else
    	return 0
  	end
end

function events.onSetPlayerPos(p)
	if sync then
		timer = os.clock()
		return false
	end
end

function events.onSetPlayerPosition(p)
	if sync then
		return false
	end
end

function events.onSetVehiclePosition(p)
	if sync then
		timer = os.clock()
		return false
	end
end

function events.onSetVehiclePos(p)
	if sync then
		timer = os.clock()
		return false
	end
end

function footcoord(x, y, z, pos)
    local data = samp_create_sync_data("player")
    local heading = getCharHeading(PLAYER_PED)
    data.quaternion = { 0, 0, 0, 0 }
    data.animationId = 993
    data.animationFlags = 410000
	if pos then
		data.moveSpeed = {99, 99, -99}
	else
		data.moveSpeed.x = math.sin(-math.rad(heading)) * 0.6
		data.moveSpeed.y = math.cos(-math.rad(heading)) * 0.6
	end
	data.position = {x, y, z}
    data.send()
end

function incarcoord(vehId, x, y, z, pos)
    local data = samp_create_sync_data("vehicle")
    local heading = getCharHeading(PLAYER_PED)
    data.moveSpeed.x = math.sin(-math.rad(heading)) * 0.2
    data.moveSpeed.y = math.cos(-math.rad(heading)) * 0.2
    data.moveSpeed.z = 0.2
    data.quaternion = {0, 0, 0, 0}
	if pos then
		data.position = {x, y, z-15}
	else
		data.position = {x, y, z}
	end
	data.vehicleId = tonumber(vehId)
    data.send()
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
	if doesCharExist(char) then
		local ptr = getCharPointer(char)
		setEntityCoordinates(ptr, x, y, z)
	end
end

function setEntityCoordinates(entityPtr, x, y, z)
	if entityPtr ~= 0 then
		local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
		if matrixPtr ~= 0 then
			local posPtr = matrixPtr + 0x30
			writeMemory(posPtr + 0, 4, representFloatAsInt(x), false)
			writeMemory(posPtr + 4, 4, representFloatAsInt(y), false)
			writeMemory(posPtr + 8, 4, representFloatAsInt(z), false)
		end
	end
end


function jumpIntoCar(car)
  	local seat = getCarFreeSeat(car)
  	if not seat then return false end
  	if seat == 0 then 
        warpCharIntoCar(PLAYER_PED, car)
  	else 
        warpCharIntoCarAsPassenger(PLAYER_PED, car, seat - 1)
  	end
  	restoreCameraJumpcut()
  	return true
end

function teleportPlayer(x, y, z)
	local px,py,pz = getCharCoordinates(PLAYER_PED)
	local dist = getDistanceBetweenCoords3d(px,py,pz,x,y,z)
	if isCharInAnyCar(PLAYER_PED) then
		blipXa, blipYa, blipZa = x,y,z
		charPosXa, charPosYa, charPosZa = px,py,pz
		tp = true
		sync = true
	end
	if dist > 0 then
		blipX, blipY, blipZ = x,y,z
		sync = true
		charPosX, charPosY, charPosZ = px,py,pz
		tp = true
	else
		setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
	end
end

function createPointMarker(x, y, z)
  	if pointMarker then removePointMarker() end
  	pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end

function removePointMarker()
  	if pointMarker then
    	removeUser3dMarker(pointMarker)
    	pointMarker = nil
  	end
end

function findCarName(id)
    local input_text = readFile(getGameDirectory() .."/data/vehicles.ide")
    local lines = {}
    for line in input_text:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    for _, line in ipairs(lines) do
        local parts = {}
        for part in line:gmatch("([^,]+)") do
            table.insert(parts, part)
        end

        local current_id = parts[1]:gsub("%s", "")
        if tonumber(current_id) == id then
            local second_value = parts[2]:gsub("%s", "")
            return second_value
        end
    end
    return nil
end

function readFile(path)
    local lines = {}
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    for line in f:lines() do
        if not line:match("^%s*#") then
            table.insert(lines, line)
        end
    end
    f:close()
    return table.concat(lines, "\n")
end

-- zteleport
local function nop(data)
    if zettp then return false end
end

events.onSendPlayerSync = nop
events.onSendVehicleSync = nop

function math.calculate(MinInt, MaxInt, MinFloat, MaxFloat, CurrentFloat)
    local res = CurrentFloat - MinFloat
    local res2 = MaxFloat - MinFloat
    local res3 = res / res2
    local res4 = res3 * (MaxInt - MinInt)
    return res4 + MinInt
end

-- Бот для завода
function botwork() 
	while armorbotstate do
		wait(0)
		for k, v in pairs(coordinates) do
			runToPoint(v[1], v[2])
		end
	end
end

function runToPoint(tox, toy)
	local x, y, z = getCharCoordinates(PLAYER_PED)
    local angle = getHeadingFromVector2d(tonumber(tox) - x, tonumber(toy) - y)
    local xAngle = math.random(-50, 50)/250
    setCameraPositionUnfixed(xAngle, math.rad(angle - 90))
    while armorbotstate and getDistanceBetweenCoords2d(x, y, tox, toy) > 1 or (getDistanceBetweenCoords2d(x, y, 2558.9885253906, -1287.6723632813) > 1 and point == 0) or (getDistanceBetweenCoords2d(x, y, 2558.4392089844, -1291.0050048828) > 1 and point == 1) or (getDistanceBetweenCoords2d(x, y, 2564.4611816406, -1292.9296875) > 1 and point == 2) do
        setGameKeyState(1, -255)
        wait(1)
		local x, y, z = getCharCoordinates(PLAYER_PED)
        angle = getHeadingFromVector2d(tox - x, toy - y)
        setCameraPositionUnfixed(xAngle, math.rad(angle - 90))
		if point == 0 and getDistanceBetweenCoords2d(x, y, 2558.9885253906, -1287.6723632813) < 1 then
			notf('Берём детали...', -1)
			wait(1500)
			point = point + 1
			break
		end
		if point == 1 and getDistanceBetweenCoords2d(x, y, 2558.4392089844, -1291.0050048828) < 1 then
			armorbotalt = true
			notf('Изготавливаем...', -1)
			repeat sendKey(1024) wait(math.random(75, 150)) until not armorbotalt or not armorbotstate
			point = point + 1
			break
		end
		if point == 2 and getDistanceBetweenCoords2d(x, y, 2564.4611816406, -1292.9296875) < 1 then
			armorbotalt = true
			notf('Сдаём...', -1)
			repeat sendKey(1024) wait(math.random(75, 150)) until not armorbotalt or not armorbotstate
			notf(''..currentrounds..' круг..', -1)
			point = 0
			break
		end
        if getDistanceBetweenCoords2d(x, y, tox, toy) < 1 then
            break
        end
    end
end

function events.onApplyPlayerAnimation(playerId, animLib, animName)
	if armorbotstate then
		if playerId == idb and animName == 'PUTDWN' then
			currentrounds = currentrounds + 1
			lua_thread.create(function()
				wait(math.random(1050, 1175))
				armorbotalt = false
			end)
		end
	end
end

function events.onShowTextDraw(id, data)
	if armorbotstate then
		if data.modelId == 7891 then
			detal1 = id
		end
		if data.modelId == 18644 then
			detal2 = id
		end
	end
end

function events.onSetPlayerAttachedObject(playerId, index, create, data)
	if armorbotstate then
		if playerId == idb and data.modelId == 1279 then
			lua_thread.create(function()
				wait(math.random(350, 550))
				armorbotalt = false
			end)
		end
	end
end

function sendKey(key)
    local data = allocateMemory(68)
    sampStorePlayerOnfootData(idb, data)
    setStructElement(data, 4, 2, key, false)
    sampSendOnfootData(data)
    freeMemory(data)
end

-- auto captcha
function sendFrontendClick(interfaceid, id, subid, json)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 220)
    raknetBitStreamWriteInt8(bs, 63)
    raknetBitStreamWriteInt8(bs, interfaceid)
    raknetBitStreamWriteInt32(bs, id)
    raknetBitStreamWriteInt32(bs, subid)
    raknetBitStreamWriteInt32(bs, #json)
    raknetBitStreamWriteString(bs, json)
    raknetSendBitStreamEx(bs, 1, 10, 1)
    raknetDeleteBitStream(bs)
end

function sendInterfaceLoaded(interfaceid, bool)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 220)
    raknetBitStreamWriteInt8(bs, 66)
    raknetBitStreamWriteInt8(bs, interfaceid)
    raknetBitStreamWriteBool(bs, bool)
    raknetSendBitStreamEx(bs, 1, 10, 1)
    raknetDeleteBitStream(bs)
end

addEventHandler('onReceivePacket', function(id, bs)
    if id == 220 then
        raknetBitStreamIgnoreBits(bs, 8)
        local type = raknetBitStreamReadInt8(bs)
        if type == 84 then
            local interfaceid = raknetBitStreamReadInt8(bs)
            local subid = raknetBitStreamReadInt8(bs)
            --local len = raknetBitStreamReadInt32(bs)
            --local json = raknetBitStreamReadString(bs, len)
            if interfaceid == 81 then
                lua_thread.create(function()
                    wait(100)
                    sendFrontendClick(81, 0, 0, "")
                end)
                return false
            end
        elseif type == 62 then
            local interfaceid = raknetBitStreamReadInt8(bs)
            local toggle = raknetBitStreamReadBool(bs)
            if interfaceid == 81 then
                sendInterfaceLoaded(81, toggle)
                return false
            end
        end
    end
end)

-- nofreeze
function events.onTogglePlayerControllable(controllable)
	return false
end

-- mine time render
function onReceiveRpc(id, bs)
	if id == 58 and mtract then
		local tid = raknetBitStreamReadInt16(bs)
		if sampIs3dTextDefined(tid) then
			local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById(tid)
			local pX,pY,pZ = getCharCoordinates(1)
			if text:find("Месторождение ресурсов") then
				if getDistanceBetweenCoords3d(pX,pY,pZ,posX, posY, posZ) < 90 then
					local oid2 = check(posX, posY, posZ)
					if oid2 == -1 then
						local tid = tid - 1000
						resources[tid][1] = posX
						resources[tid][2] = posY
						resources[tid][3] = posZ
						resources[tid][4] = rtime
					elseif oid2 > -1 then
						resources[oid2][1] = posX
						resources[oid2][2] = posY
						resources[oid2][3] = posZ
						resources[oid2][4] = rtime
					end
				end
			end
		end
		return true
	elseif id == 47 and mtract then
		local oid = raknetBitStreamReadInt16(bs)
		local object = sampGetObjectHandleBySampId(oid)
		if doesObjectExist(object) then
			if getObjectModel(object) == 3930 then
				local res, oX,oY,oZ = getObjectCoordinates(object)
				local pX,pY,pZ = getCharCoordinates(1)
				if getDistanceBetweenCoords3d(pX,pY,pZ,oX,oY,oZ) < 45 then
					local oid2 = check(oX,oY,oZ)
					if oid2 == -1 then
						resources[oid][1] = oX
						resources[oid][2] = oY
						resources[oid][3] = oZ+1
						resources[oid][4] = rtime
					elseif oid2 > -1 then
						resources[oid2][1] = oX
						resources[oid2][2] = oY
						resources[oid2][3] = oZ+1
						resources[oid2][4] = rtime
					end
				end
			end
		end
		return true
	end
end

function check(x,y,z)
	for i = 1, 3000 do
		if getDistanceBetweenCoords3d(resources[i][1], resources[i][2], resources[i][3], x,y,z) < 2 and resources[i][4] > 0 then
			return i
		end
	end
	return -1
end

function changetime(time)
	local min = math.floor(time/60)
	local sec = time % 60
	if min ~= 0 then
		return "\n  {FF0000}"..min.."{FFFFFF} мин , {FF0000}"..sec.."{FFFFFF} сек"
	else
		return "{FF0000}"..sec.."{FFFFFF} сек"
	end
end

function metka(x,y,z)
	local n = #pool_mrkr + 1
	local g = #pool_chkpnt + 1
	local h = #pool_marker + 1
	pool_mrkr[n] = createUser3dMarker(x, y, z + 2, 4)
	pool_chkpnt[g] = addBlipForCoord(x, y, z)
	changeBlipColour(pool_chkpnt[g], 0xFF00003FF)
	pool_marker[h] = createCheckpoint(1, x, y, z, 1, 1, 1, 1.5)
	lua_thread.create(function()
	wait(15000)
	deleteCheckpoint(pool_marker[h])
    removeBlip(pool_chkpnt[g])
	removeUser3dMarker(pool_mrkr[n])
	pool_chkpnt[g] = nil
	pool_mrkr[n] = nil
	pool_marker[h] = nil
	end)
end

-- quit informer
function events.onPlayerQuit(playerid,reason) -- 0 краш, 1 вышел /q, 2 кикнуло
    if settings.main.quitinformer[0] then
        local textadd = 'Игрок {FF9C00}'..sampGetPlayerNickname(playerid)..'['..playerid..'] {ffffff}вышел с сервера. {FF9C00}Причина: {ffffff}'..reasons[reason]
        if settings.main.informerinstream[0] then
            if select(1, sampGetCharHandleBySampPlayerId(playerid)) then
                notf(textadd)
            end
        else
            notf(textadd)
        end
    end
end

-- ontouch change position
addEventHandler("onTouch", function (type, id, x, y)
    if gzpos then
        ini.main.gzposx = x
        ini.main.gzposy = y
        save()
        gzpos = false
        window_state[0] = not window_state[0]
    end
    if editposs then
        ini.teleport.x = x
        ini.teleport.y = y
        inicfg.save(ini, directIni)
        notf('Сохранено')
        editposs = false
        window_state[0] = not window_state[0]
    end
end)

-- tir bot
gunsWait = {
	[24] = 150, -- deagle
	[31] = 50, -- m4
	[30] = 50, -- ak47
	[22] = 300, -- pistols
	[23] = 300, -- tazer
	[25] = 1050, -- shotgun
	[28] = 100, -- uzi
	[29] = 100 -- mp5
}

-- tg chat logger
function threadHandle(runner, url, args, resolve, reject)
    if not resolve or type(resolve) ~= "function" then
        error("The 'resolve' parameter must be a valid function.")
    end

    if not reject or type(reject) ~= "function" then
        error("The 'reject' parameter must be a valid function.")
    end

    local t = runner(url, args)
    if not t then
        reject("Failed to create runner thread")
        return
    end

    local get_result = function()
        local r = t:get(0)
        while not r do
            r = t:get(0)
            wait(0)
        end
        return r
    end

    local status = t:status()
    local r = get_result()
    
    if status == 'completed' then
        local ok, result = r[1], r[2]
        if ok then 
            resolve(result)
        else 
            reject(result)
        end
    elseif status == 'canceled' then
        reject("Operation was canceled.")
    else
        reject("Unexpected error: " .. tostring(status))
    end
    
    t:cancel(0)
end

function requestRunner()
    return effil.thread(function(u, a)
        local https = require 'ssl.https'
        local ok, result = pcall(https.request, u, a)
        if ok then
            return {true, result}
        else
            return {false, result}
        end
    end)
end

function async_http_request(url, args, resolve, reject)
    local runner = requestRunner()
    if not reject then reject = function() end end
    lua_thread.create(function()
        threadHandle(runner, url, args, resolve, reject)
    end)
end

function encodeUrl(str)
    str = str:gsub(' ', '%+')
    str = str:gsub('\n', '%%0A')
    return u8:encode(str, 'CP1251')
end

function sendTelegramNotification(msg) -- функция для отправки сообщения юзеру
    msg = msg:gsub('{......}', '') --тут типо убираем цвет
    msg = encodeUrl(msg) -- ну тут мы закодируем строку
    async_http_request('https://api.telegram.org/bot' .. ini.tglogger.token .. '/sendMessage?chat_id=' .. ini.tglogger.chat_id .. '&text='..msg,'', function(result) end) -- а тут уже отправка
end

function get_telegram_updates() -- функция получения сообщений от юзера
    while not updateid do wait(1) end -- ждем пока не узнаем последний ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..ini.tglogger.token..'/getUpdates?chat_id='..ini.tglogger.chat_id..'&offset=-1' -- создаем ссылку
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function getLastUpdate() -- тут мы получаем последний ID сообщения, если же у вас в коде будет настройка токена и chat_id, вызовите эту функцию для того чтоб получить последнее сообщение
    async_http_request('https://api.telegram.org/bot'..ini.tglogger.token..'/getUpdates?chat_id='..ini.tglogger.chat_id..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1 -- тут зададим значение 1, если таблица будет пустая
                end
            end
        end
    end)
end

-- tpall
function getPlayerStream(distance) 
    math.randomseed(os.time())
    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local streamresult, playerHandle = sampGetCharHandleBySampPlayerId(i)
            if streamresult and getCharHealth(playerHandle) > 0 and not sampIsPlayerPaused(i) and i ~= sampGetPlayerIdByCharHandle(PLAYER_PED) then 
                local PLAYER_POS = {getCharCoordinates(PLAYER_PED)}
                local TARGET_POS = {getCharCoordinates(playerHandle)}
                local BETWEEN = getDistanceBetweenCoords3d(PLAYER_POS[1], PLAYER_POS[2], PLAYER_POS[3], TARGET_POS[1], TARGET_POS[2], TARGET_POS[3])
                if BETWEEN < distance then 
                    return true, playerHandle, i
                end
            end
        end
    end
    return false, nil, nil
end

-- radius lavki
drawCircleIn3d = function(x, y, z, radius, polygons,width,color)
    local step = math.floor(360 / (polygons or 36))
    local sX_old, sY_old
    for angle = 0, 360, step do
        local lX = radius * math.cos(math.rad(angle)) + x
        local lY = radius * math.sin(math.rad(angle)) + y
        local lZ = z
        local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
        if sZ > 1 then
            if sX_old and sY_old then
                renderDrawLine(sX, sY, sX_old, sY_old, width, color)
            end
            sX_old, sY_old = sX, sY
        end
    end
end

isCentralMarket = function(x, y)
	return (x > 1090 and x < 1180 and y > -1550 and y < -1429)
end

-- message form
function notf(text)
    sampAddChatMessage('{008080}[Miku Mobile Project] {FFFFFF}'..text,0xFF9C00)
end

-- auto updates
function check_update()
    notf('Проверка наличия обновлений...')
    local currentVersionFile = io.open(lmPath, "r")
    local currentVersion = currentVersionFile:read("*a")
    currentVersionFile:close()
    local response = http.request(lmUrl)
    if response and response ~= currentVersion then
        notf("Найдено новое обновление! Вывожу окно для загрузки...")
        found_update[0] = not found_update[0]
    else
        notf("У вас актуальная версия скрипта.")
    end
end

function updateScript(scriptUrl, scriptPath)
    notf("Проверка наличия обновлений...")
    local response = http.request(scriptUrl)
    if response and response ~= currentVersion then
        notf("Обновление...")
        local success = downloadFile(scriptUrl, scriptPath)
        if success then
            notf("Скрипт успешно обновлен. Перезагрузка..")
            thisScript():reload()
        else
            notf("Неизвестная ошибка, не удалось обновить скрипт.")
        end
    else
        notf("Скрипт уже является последней версией.")
    end
end

-- theme based on MoonMonet
function apply_monet()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(15, 15)
    style.WindowRounding = 10.0
    style.ChildRounding = 6.0
    style.FramePadding = imgui.ImVec2(8, 7)
    style.FrameRounding = 8.0
    style.ItemSpacing = imgui.ImVec2(8, 8)
    style.ItemInnerSpacing = imgui.ImVec2(10, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 25.0
    style.ScrollbarRounding = 12.0
    style.GrabMinSize = 10.0
    style.GrabRounding = 6.0
    style.PopupRounding = 8
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
	local generated_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
	colors[clr.Text] = ColorAccentsAdapter(generated_color.accent2.color_50):as_vec4()
	colors[clr.TextDisabled] = ColorAccentsAdapter(generated_color.neutral1.color_600):as_vec4()
	colors[clr.WindowBg] = ColorAccentsAdapter(generated_color.accent2.color_900):as_vec4()
	colors[clr.ChildBg] = ColorAccentsAdapter(generated_color.accent2.color_800):as_vec4()
	colors[clr.PopupBg] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.Border] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	colors[clr.Separator] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	colors[clr.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x60):as_vec4()
	colors[clr.FrameBgHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x70):as_vec4()
	colors[clr.FrameBgActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x50):as_vec4()
	colors[clr.TitleBg] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	colors[clr.TitleBgCollapsed] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0x7f):as_vec4()
	colors[clr.TitleBgActive] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.MenuBarBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x91):as_vec4()
	colors[clr.ScrollbarBg] = imgui.ImVec4(0,0,0,0)
	colors[clr.ScrollbarGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x85):as_vec4()
	colors[clr.ScrollbarGrabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ScrollbarGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.CheckMark] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.SliderGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.SliderGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x80):as_vec4()
	colors[clr.Button] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.ButtonHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ButtonActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.Tab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.TabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.TabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.Header] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	colors[clr.HeaderHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.HeaderActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	colors[clr.ResizeGrip] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	colors[clr.ResizeGripHovered] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	colors[clr.ResizeGripActive] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xb3):as_vec4()
	colors[clr.PlotLines] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	colors[clr.PlotLinesHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.PlotHistogram] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	colors[clr.PlotHistogramHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.TextSelectedBg] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	colors[clr.ModalWindowDimBg] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0x26):as_vec4()
end

function apply_n_t()
    gen_color = monet.buildColors(ini.theme.moonmonet, 1.0, true)
    local a, r, g, b = explode_argb(gen_color.accent1.color_300)
	curcolor = '{'..rgb2hex(r, g, b)..'}'
    curcolor1 = '0x'..('%X'):format(gen_color.accent1.color_300)
    apply_monet()
end

function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

function rgb2hex(r, g, b)
    local hex = string.format("#%02X%02X%02X", r, g, b)
    return hex
end

function ColorAccentsAdapter(color)
    local a, r, g, b = explode_argb(color)
    local ret = {a = a, r = r, g = g, b = b}
    function ret:apply_alpha(alpha)
        self.a = alpha
        return self
    end
    function ret:as_u32()
        return join_argb(self.a, self.b, self.g, self.r)
    end
    function ret:as_vec4()
        return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, self.a / 255)
    end
    function ret:as_argb()
        return join_argb(self.a, self.r, self.g, self.b)
    end
    function ret:as_rgba()
        return join_argb(self.r, self.g, self.b, self.a)
    end
    function ret:as_chat()
        return string.format("%06X", ARGBtoRGB(join_argb(self.a, self.r, self.g, self.b)))
    end
    return ret
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

local function ARGBtoRGB(color)
    return bit.band(color, 0xFFFFFF)
end

-- ban