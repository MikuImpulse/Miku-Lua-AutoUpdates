local script_ver = '1.2.9'

script_name('Miku Project Reborn')
script_version(script_ver)
script_author('@mikusilent')
script_description('MultiCheat named *Miku* for Arizona Mobile. Type /miku to open menu. Our channeI: t.me/mikusilent')

local getName = thisScript().path
local targetName = getWorkingDirectory()..'/MikuProjectReborn.lua'
if getName ~= targetName then
    os.rename(getName, targetName)
    thisScript():reload()
end

local success, jniUtil = pcall(require, "android.jnienv-util")
local success2, env = pcall(require, "android.jnienv")
local imgui = require 'mimgui'
local fa = require 'fAwesome6_solid'
local faicons = require 'fAwesome6'
local mem = require 'memory'
local events = require 'samp.events'
local ffi = require 'ffi'
local sf = require 'sampfuncs'
local inicfg = require 'inicfg'
local Vector3D = require 'vector3d'
local widgets = require 'widgets'
local memory = require 'memory'
local samem = require 'SAMemory'
local raknet = require 'samp.raknet'
local ltn12 = require 'ltn12'
local http = require 'socket.http'
samem.require 'CPed'
local FontFlags = require 'lib.moonloader'.font_flag

local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

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
        autosave = (true)
    },
    ESP = {
        drawing = (false),
        enabled_boxes = (false),
        enabled_bones = (false),
        enabled_nicks = (false),
        enabled_lines = (false),
        enabled_health = (false),
        enabled_armor = (false),
        enabled_fillgradient = (false),
        boxthinkness = (3),
        skeletonthinkness = (3),
        nicknamesize = (0.0180),
        lineposition = (0),
        linethinkness = (2),
        fillboxvalue = (0.3)
    },
    main = {
        airbrakewidget = (false),
        clickwarpcoord = (false),
        antimask = (false),
        timeblockserv = (false),
        weatherblockserv = (false),
        autocaptcha = (false),
        antiFreeze = (false)
    },
    ped = {
        godmode_enabled = (false),
        noreload = (false),
        setskills = (false),
        animspeed = (false),
        speedint = (1),
        rapidfire = (false),
        rapidint = (1),
        skinid = (0),
        autoplusc = (false),
        infiniterun = (false),
        killbots1hit = (false),
        sbiv = (false),
        autoscroll = (false),
        pt = (1),
        wait = (200),
        nofall = (false),
        changefov = (false),
        fovvalue = (101)
    },
    car = {
        godmode2_enabled = (false),
        flycar = (false),
        nobike = (false),
        atrradius = (150),
        atractive = (false),
        speedhack = (false),
        limit = (1.25),
	    mult = (1.02),
		timestep = (0.03),
		safe_train_speed = (true),
		fastenter = (false),
		infinitefuel = (false),
		fastexit = (false),
		fastbrake = (false),
        jumpcar = (false),
        anticarskill = (false)
    },
    render = {
        ruda = (false),
        deer = (false),
        narkotiki = (false),
        podarok = (false),
        musortsr = (false),
        kladrender = (false),
        yabloki = (false),
        slivu = (false),
        kokosi = (false),
        derevovishkac = (false),
        semena = (false),
        graffiti = (false)
    },
    menu = {
        slideropenbuttonwidth = (100),
        slideropenbuttonheight = (95),
        openbutton = (true),
        openbutton2 = (false),
        sendalt = (false),
        sendaltwidth = (180),
        sendaltheight = (50),
        showinfo = (true),
        window_scale = (1.0),
        draweffects = (true),
        watermark = (true)
    },
    dgun = {
        gunsList = (0),
        ammo = (500)
    },
    objects = {
        autormlsa = (false),
        autormsfa = (false),
        autormblockpost = (false),
        autormlampposts = (false),
        autormroadrem = (false)
    },
    tsr = {
        tsrbotwait = (1200),
        autormcell = (false),
        autormdoors = (false),
        autormfence = (false)
    },
    battery = {
        notifyLowCharge = (false),
        lowBatteryLevel = (15)
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
        drawing = imgui.new.bool(ini.ESP.drawing),
        enabled_bones = imgui.new.bool(ini.ESP.enabled_bones),
        enabled_boxes = imgui.new.bool(ini.ESP.enabled_boxes),
        enabled_nicks = imgui.new.bool(ini.ESP.enabled_nicks),
        enabled_lines = imgui.new.bool(ini.ESP.enabled_lines),
        enabled_health = imgui.new.bool(ini.ESP.enabled_health),
        enabled_armor = imgui.new.bool(ini.ESP.enabled_armor),
        enabled_fillgradient = imgui.new.bool(ini.ESP.enabled_fillgradient),
        boxthinkness = imgui.new.int(ini.ESP.boxthinkness),
        skeletonthinkness = imgui.new.int(ini.ESP.skeletonthinkness),
        nicknamesize = imgui.new.float(ini.ESP.nicknamesize),
        lineposition = imgui.new.int(ini.ESP.lineposition),
        linethinkness = imgui.new.int(ini.ESP.linethinkness),
        fillboxvalue = imgui.new.float(ini.ESP.fillboxvalue)
    },
    main = {
        airbrakewidget = imgui.new.bool(ini.main.airbrakewidget),
        clickwarpcoord = imgui.new.bool(ini.main.clickwarpcoord),
        antimask = imgui.new.bool(ini.main.antimask),
        timeblockserv = imgui.new.bool(ini.main.timeblockserv),
        weatherblockserv = imgui.new.bool(ini.main.weatherblockserv),
        autocaptcha = imgui.new.bool(ini.main.autocaptcha),
        antiFreeze = imgui.new.bool(ini.main.antiFreeze)
    },
    ped = {
        godmode_enabled = imgui.new.bool(ini.ped.godmode_enabled),
        noreload = imgui.new.bool(ini.ped.noreload),
        setskills = imgui.new.bool(ini.ped.setskills),
        animspeed = imgui.new.bool(ini.ped.animspeed),
        speedint = imgui.new.int(ini.ped.speedint),
        rapidfire = imgui.new.bool(ini.ped.rapidfire),
        rapidint = imgui.new.int(ini.ped.rapidint),
        skinid = imgui.new.int(ini.ped.skinid),
        autoplusc = imgui.new.bool(ini.ped.autoplusc),
        infiniterun = imgui.new.bool(ini.ped.infiniterun),
        killbots1hit = imgui.new.bool(ini.ped.killbots1hit),
        sbiv = imgui.new.bool(ini.ped.sbiv),
        autoscroll = imgui.new.bool(ini.ped.autoscroll),
        pt = imgui.new.int(ini.ped.pt),
        wait = imgui.new.int(ini.ped.wait),
        nofall = imgui.new.bool(ini.ped.nofall),
        changefov = imgui.new.bool(ini.ped.changefov),
        fovvalue = imgui.new.int(ini.ped.fovvalue)
    },
    car = {
        godmode2_enabled = imgui.new.bool(ini.car.godmode2_enabled),
        flycar = imgui.new.bool(ini.car.flycar),
        nobike = imgui.new.bool(ini.car.nobike),
        atrradius = imgui.new.int(ini.car.atrradius),
        atractive = imgui.new.bool(ini.car.atractive),
        speedhack = imgui.new.bool(ini.car.speedhack),
        slider_mult = imgui.new.float(ini.car.mult),
        slider_limit = imgui.new.float(ini.car.limit),
        slider_timestep = imgui.new.float(ini.car.timestep),
        safe_train_speed = imgui.new.bool(ini.car.safe_train_speed),
        fastenter = imgui.new.bool(ini.car.fastenter),
        infinitefuel = imgui.new.bool(ini.car.infinitefuel),
        fastexit = imgui.new.bool(ini.car.fastexit),
        fastbrake = imgui.new.bool(ini.car.fastbrake),
        jumpcar = imgui.new.bool(ini.car.jumpcar),
        anticarskill = imgui.new.bool(ini.car.anticarskill)
    },
    render = {
        ruda = imgui.new.bool(ini.render.ruda),
        deer = imgui.new.bool(ini.render.deer),
        narkotiki = imgui.new.bool(ini.render.narkotiki),
        podarok = imgui.new.bool(ini.render.podarok),
        musortsr = imgui.new.bool(ini.render.musortsr),
        kladrender = imgui.new.bool(ini.render.kladrender),
        yabloki = imgui.new.bool(ini.render.yabloki),
        slivu = imgui.new.bool(ini.render.slivu),
        kokosi = imgui.new.bool(ini.render.kokosi),
        derevovishkac = imgui.new.bool(ini.render.derevovishkac),
        semena = imgui.new.bool(ini.render.semena),
        graffiti = imgui.new.bool(ini.render.graffiti)
    },
    menu = {
        slideropenbuttonwidth = imgui.new.int(ini.menu.slideropenbuttonwidth),
        slideropenbuttonheight = imgui.new.int(ini.menu.slideropenbuttonheight),
        openbutton = imgui.new.bool(ini.menu.openbutton),
        openbutton2 = imgui.new.bool(ini.menu.openbutton2),
        sendalt = imgui.new.bool(ini.menu.sendalt),
        sendaltwidth = imgui.new.int(ini.menu.sendaltwidth),
        sendaltheight = imgui.new.int(ini.menu.sendaltheight),
        showinfo = imgui.new.bool(ini.menu.showinfo),
        window_scale = imgui.new.float(ini.menu.window_scale),
        draweffects = imgui.new.bool(ini.menu.draweffects),
        watermark = imgui.new.bool(ini.menu.watermark)
    },
    dgun = {
        gunsList = imgui.new.int(ini.dgun.gunsList),
        ammo = imgui.new.int(ini.dgun.ammo)
    },
    objects = {
        autormlsa = imgui.new.bool(ini.objects.autormlsa),
        autormsfa = imgui.new.bool(ini.objects.autormsfa),
        autormblockpost = imgui.new.bool(ini.objects.autormblockpost),
        autormlampposts = imgui.new.bool(ini.objects.autormlampposts),
        autormroadrem = imgui.new.bool(ini.objects.autormroadrem)
    },
    tsr = {
        tsrbotwait = imgui.new.int(ini.tsr.tsrbotwait),
        autormcell = imgui.new.bool(ini.tsr.autormcell),
        autormdoors = imgui.new.bool(ini.tsr.autormdoors),
        autormfence = imgui.new.bool(ini.tsr.autormfence)
    },
    battery = {
        notifyLowCharge = imgui.new.bool(ini.battery.notifyLowCharge),
        lowBatteryLevel = imgui.new.int(ini.battery.lowBatteryLevel),
        stopMessage = false
    },
    cfg = {
        autosave = imgui.new.bool(ini.cfg.autosave)
    }
}
-- /* xyu official variables */ --
-- Меню
local tab = 1
local activetab = 1
local subtab_1 = 1
local subtab_2 = 1
local subtab_3 = 1
local subtab_4 = 1
local subtab_5 = 1
local subtab_6 = 1
local subtab_7 = 1
local SCREEN_W, SCREEN_H = getScreenResolution()
local new = imgui.new
local window_scale = imgui.new.float(1.0)
local window_state = new.bool()
local custommimguiStyle = new.bool()
local menusettings = new.bool()
local found_update = new.bool()
-- battery manager
local BATTERY_PROPERTY_CAPACITY = 4
local BATTERY_PROPERTY_CHARGE_COUNTER = 1
local BATTERY_PROPERTY_ENERGY_COUNTER = 5
local BATTERY_PROPERTY_CURRENT_NOW = 5
-- AirBrake
local was_doubletapped = false
local enabledair = false
local speed = 0.3
local was_in_car = false
local last_car
-- notify
Notifications = {
  _version = '0.2',
  _list = {},
  _COLORS = {
    [0] = {back = {0.26, 0.71, 0.81, 1},    text = {1, 1, 1, 1}, icon = {1, 1, 1, 1}, border = {1, 0, 0, 0}},
    [1] = {back = {0.26, 0.81, 0.31, 1},    text = {1, 1, 1, 1}, icon = {1, 1, 1, 1}, border = {1, 0, 0, 0}},
    [2] = {back = {1, 0.39, 0.39, 1},       text = {1, 1, 1, 1}, icon = {1, 1, 1, 1}, border = {1, 0, 0, 0}},
    [3] = {back = {0.97, 0.57, 0.28, 1},    text = {1, 1, 1, 1}, icon = {1, 1, 1, 1}, border = {1, 0, 0, 0}},
    [4] = {back = {0, 0, 0, 1},             text = {1, 1, 1, 1}, icon = {1, 1, 1, 1}, border = {1, 0, 0, 0}},
  },

  TYPE = {
      INFO = 0,
      OK = 1,
      ERROR = 2,
      WARN = 3,
      DEBUG = 4
  },
  ICON = {
      [0] = faicons('CIRCLE_INFO'),
      [1] = faicons('CHECK'),
      [2] = faicons('XMARK'),
      [3] = faicons('EXCLAMATION'),
      [4] = faicons('WRENCH')
  }
}
-- speedhack
local player_vehicle = samem.cast('CVehicle **', samem.player_vehicle)
-- auto updates
local lmPath = "MikuProjectReborn.lua"
local lmUrl = "https://raw.githubusercontent.com/MikuImpulse/Miku-Lua-AutoUpdates/main/MikuProjectReborn.lua"
local betaUrl = "https://github.com/MikuImpulse/Miku-Lua-Beta/raw/refs/heads/main/MikuProjectReborn.lua"
local betaPath = "MikuProjectReborn.lua"
local updfont = {}
-- togglebutton
local AI_TOGGLE = {}
local ToU32 = imgui.ColorConvertFloat4ToU32
-- tsr rage bot
local tsrragebot = imgui.new.bool(false)
local botstep = -1
local box = 0
-- attach trailer
atrtrailer = nil
-- dgun combo
local item_list = {u8'Кулак', u8'Кастет', u8'Клюшка для гольфа', u8'Полицейская дубинка', u8'Нож', u8'Бейсбольная бита', u8'Лопата', u8'Кий', u8'Катана', u8'Бензопила', u8'Двухсторонний дилдо', u8'Дилдо', u8'Вибратор', u8'Серебряный вибратор', u8'Букет цветов', u8'Трость', u8'Граната', u8'Слезоточивый газ', u8'Коктейль Молотова', u8' ', u8' ', u8' ', u8'Пистолет', u8'USP-S (Тазер)', u8'Desert Eagle', u8'Дробовик', u8'Обрез', u8'Скорострельный дробовик', u8'UZI', u8'MP5', u8'Калаш', u8'М4', u8'TEC-9', u8'Охотничье ружье', u8'Снайперка', u8'РПГ', u8'Самонаводящееся РПГ', u8'Огнемет', u8'Миниган', u8'Сумка с тротилом', u8'Детонатор', u8'Баллончик', u8'Огнетушитель', u8'Фотоаппарат', u8'Очки ночного видения', u8'Тепловизор', u8'Парашют'}
local ImItems = imgui.new['const char*'][#item_list](item_list)
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
local font = renderCreateFont('NAMU PRO', 25, FontFlags.BORDER)
-- esp fonts, bones
function updateFont()
    if font then
        renderReleaseFont(font)
    end
    FONTESP = renderCreateFont('Arial', SCREEN_H * settings.ESP.nicknamesize[0], 1 + 4)
end
updateFont()
local ESP2 = {
  BONES = { 3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2 },
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
    colornew = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
}

local animSpeed = {'RUN_CIVI', 'RUN_1ARMED', 'RUN_ARMED', 'RUN_CSAW', 'RUN_FAT', 'RUN_FATOLD', 'RUN_GANG1', 'RUN_LEFT', 'RUN_OLD', 'RUN_PLAYER', 'RUN_RIGHT', 'RUN_ROCKET', 'RUN_WUZI', 'RUN_STOP', 'RUN_STOPR', 'IDLE_STANCE', 'XPRESSSCRATCH', 'ROADCROSS', 'ROADCROSS_FEMALE', 'ROADCROSS_GANG', 'ROADCROSS_OLD', 'IDLE_HBHB', 'IDLE_GANG1', 'IDLE_ARMED', 'IDLESTANCE_OLD', 'IDLESTANCE_FAT', 'FIGHTIDLE', 'FIGHTA_M', 'FIGHTA_1'}
local rapidAnimations = {"PYTHON_CROUCHFIRE", "PYTHON_FIRE", "PYTHON_FIRE_POOR", "PYTHON_CROCUCHRELOAD", "RIFLE_CROUCHFIRE", "RIFLE_CROUCHLOAD", "RIFLE_FIRE", "RIFLE_FIRE_POOR", "RIFLE_LOAD", "SHOTGUN_CROUCHFIRE", "SHOTGUN_FIRE", "SHOTGUN_FIRE_POOR", "SILENCED_CROUCH_RELOAD", "SILENCED_CROUCH_FIRE", "SILENCED_FIRE", "SILENCED_RELOAD", "TEC_crouchfire", "TEC_crouchreload", "TEC_fire", "TEC_reload", "UZI_crouchfire", "UZI_crouchreload", "UZI_fire", "UZI_fire_poor", "UZI_reload", "idle_rocket", "Rocket_Fire", "run_rocket", "walk_rocket", "WALK_start_rocket", "WEAPON_sniper"}

local guns = {16, 17, 18, 25, 33, 34, 35, 36, 39, 40}
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

-- ffi get ped bones position
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

----ImGui OnInitialize----
imgui.OnInitialize(function()
    ThemeMenu()
    Icons_Init()
    Fonts_Init()
end)

function Fonts_Init()
    --imgui.GetIO().IniFilename = nil
    local path = getWorkingDirectory()..'/resource/Zekton-Font.ttf'
    local path2 = getWorkingDirectory()..'/resource/Gotham_Pro.ttf'
    updfont[20] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 20.0, nil, glyph_ranges)
    updfont[25] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 25.0, nil, glyph_ranges)
    updfont[33] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 33.0, nil, glyph_ranges)
    updfont[40] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 40.0, nil, glyph_ranges)
    updfont[30] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 30.0, nil, glyph_ranges)
    waterfont = imgui.GetIO().Fonts:AddFontFromFileTTF(path2, 27.0 * MONET_DPI_SCALE, nil, glyph_ranges)
    upd1 = imgui.GetIO().Fonts:AddFontFromFileTTF(path2, 33.0, nil, glyph_ranges)
    upd2 = imgui.GetIO().Fonts:AddFontFromFileTTF(path2, 25.0, nil, glyph_ranges)
end

function Icons_Init()
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), 20, config, iconRanges)
end

-- Reconnect
Reconnect.activate = function()
    lua_thread.create(function()
        local ms = 500 + Reconnect.delay[0] * 1000
        if ms <= 0 then
            ms = 100
        end
        notf4(u8'Реконнектимся...')
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
  
-- SetSkin by forget
setskin_activate = function()
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt32(bs, select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    raknetBitStreamWriteInt32(bs, settings.ped.skinid[0])
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
end

---------Кнопка Menu---------
local newFrame2 = imgui.OnFrame(
    function() return settings.menu.openbutton2[0] end,
    function(player)
        imgui.Begin('ZoV', settings.menu.openbutton, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
            if imgui.Button(fa.GEARS, imgui.ImVec2(settings.menu.slideropenbuttonwidth[0], settings.menu.slideropenbuttonheight[0])) then
                window_state[0] = not window_state[0]
            end
        imgui.End()
    end
)
-- flycar window
imgui.OnFrame(function() return settings.car.flycar[0] and not isGamePaused() and isCharInAnyCar(PLAYER_PED) end, function()
    imgui.SetNextWindowSize(imgui.ImVec2(90, 90), imgui.Cond.Always)
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.Begin('     ', settings.car.flycar, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize)
    imgui.SetCursorPos(imgui.ImVec2(45, 45))
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    if not wwwflycar then
        dl:AddCircleFilled(p, 33, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.00, 0.00, 0.00, 1.00)), 100)
        dl:AddCircle(p, 38, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.00, 0.00, 0.00, 1.00)), 100)
    else
        dl:AddCircleFilled(p, 33, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.00, 1.00, 0.00, 1.00)), 100)
        dl:AddCircle(p, 38, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.00, 1.00, 0.00, 1.00)), 100)
    end
    dl:AddText(imgui.ImVec2(p.x - 21, p.y - 9), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.00, 1.00, 1.00, 1.00)), 'FlyCar', NULL)
    imgui.SetCursorPos(imgui.ImVec2(10, 10))
    if imgui.InvisibleButton('##flycartoggle', imgui.GetWindowSize()) then
        wwwflycar = not wwwflycar
        printStringNow(wwwflycar and 'FlyCar ~g~activated' or 'FlyCar ~r~deactivated', 300)
    end    
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.End()
end)
-- found update window
imgui.OnFrame(function() return found_update[0] end, function()
    local scrx, scry = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(scrx / 2, scry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'', found_update, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
    imgui.PushFont(updfont[40])
    imgui.CenterText('Miku Project Reborn')
    imgui.PopFont()
    imgui.PushFont(updfont[20])
    imgui.CenterText('(credits: @mikusilent, @dobbygovno, @langerv, @TheopkaStudio)')
    imgui.PopFont()
    imgui.CenterText('')
    imgui.PushFont(upd1)
    imgui.CenterText(u8'New update found!')
    imgui.PopFont()
    imgui.CenterText('')
    imgui.CenterText('')
    imgui.PushFont(upd2)
    imgui.CenterText(u8'A new script update was found')
    imgui.CenterText(u8'To continue working you')
    imgui.CenterText(u8'must select one of the two buttons below')
    imgui.PopFont()
    imgui.CenterText('')
    imgui.CenterText('')
    if imgui.Button(fa.DOWNLOAD..u8' ОБНОВИТЬ', imgui.ImVec2(650, 40)) then
        updateScript(lmUrl, lmPath)
    end
    if imgui.Button(fa.FORWARD..u8' ПРОПУСТИТЬ', imgui.ImVec2(650, 40)) then
       found_update[0] = not found_update[0]
       notf4(u8'Обновление скрипта пропущено')
    end
    imgui.End()
end)
-- demo window
imgui.OnFrame(function() return custommimguiStyle[0] end, function()
    imgui.Begin("ImGui Demo")
    imgui.ShowDemoWindow()
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
	    end)
	end
    imgui.End()
end)
-- menu settings
imgui.OnFrame(function() return menusettings[0] end, function()
    imgui.Begin(u8'Настройки меню', menusettings, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
    imgui.CenterText(fa.FOLDER..u8' Общие настройки меню')
    imgui.Separator()
    if imgui.SliderFloat(fa.MAXIMIZE..u8' Размер шрифта', settings.menu.window_scale, 1 / MONET_DPI_SCALE, 3.0) then
        if settings.cfg.autosave[0] then
            ini.menu.window_scale = settings.menu.window_scale[0]
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
-- main menu
imgui.OnFrame(function() return window_state[0] end, function()
    imgui.SetNextWindowPos(imgui.ImVec2(1100 * MONET_DPI_SCALE, 500 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(845 * MONET_DPI_SCALE, 482 * MONET_DPI_SCALE), imgui.Cond.Always)
    imgui.Begin(u8"##miku", window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)
    imgui.SetCursorPos(imgui.ImVec2(10 * MONET_DPI_SCALE, 12 * MONET_DPI_SCALE))
    imgui.PushFont(waterfont)
    imgui.GetWindowDrawList():AddText(imgui.ImVec2(imgui.GetWindowPos().x + 20, imgui.GetWindowPos().y + 23), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), "Miku Reborn")
    imgui.PopFont()
    imgui.SetCursorPos(imgui.ImVec2(16 * MONET_DPI_SCALE, 60 * MONET_DPI_SCALE))
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.15, 0.15, 0.17, 1.00))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
    if imgui.BeginChild("Tabs##"..tab, imgui.ImVec2(153 * MONET_DPI_SCALE, 405 * MONET_DPI_SCALE), false) then
        if imgui.Button(fa.FIRE..u8"  Основное", imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 1
            activetab = 1
        end
        if activetab == 1 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.USER..u8'  Персонаж', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 2
            activetab = 2
        end
        if activetab == 2 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.CAR..u8'  Машина', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 3
            activetab = 3
        end
        if activetab == 3 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.EYE..u8'  Подсветка', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 4
            activetab = 4
        end
        if activetab == 4 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.GAVEL..u8'  ТСР Хелпер', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 5
            activetab = 5
        end
        if activetab == 5 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.SQUARE_CHECK..u8'  Кнопочки', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 6
            activetab = 6
        end
        if activetab == 6 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        if imgui.Button(fa.GEARS..u8'  Настройки', imgui.ImVec2(150 * MONET_DPI_SCALE, 53 * MONET_DPI_SCALE)) then
            tab = 7
            activetab = 7
        end
        if activetab == 7 then
            local drawlist = imgui.GetForegroundDrawList()
            local buttonPos = imgui.GetItemRectMax() 
            drawlist:AddLine(buttonPos, buttonPos - imgui.ImVec2(0, 68), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.90, 0.90, 0.93, 1.00)), 4.0) 
        end
        imgui.EndChild()
    end
    imgui.PopStyleColor(3)
    imgui.SetCursorPos(imgui.ImVec2(180 * MONET_DPI_SCALE, 15 * MONET_DPI_SCALE))
    if imgui.BeginChild("##MenuT", imgui.ImVec2(652 * MONET_DPI_SCALE, 458 * MONET_DPI_SCALE), false) then
        if tab == 1 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Основное") then
                subtab_1 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"Рендер") then
                subtab_1 = 2
            end
            imgui.SameLine()
            if imgui.Button(u8"Объекты") then
                subtab_1 = 3
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_1 == 1 then
                imgui.Text(u8'Аирбрейк активируется даблтапом на иконку оружия')
                if imgui.ToggleButton(u8'Виджет аирбрейка', settings.main.airbrakewidget) then
                    if settings.cfg.autosave[0] then
                        ini.main.airbrakewidget = settings.main.airbrakewidget[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'ClickCoordMobile', settings.main.clickwarpcoord) then
                    if settings.cfg.autosave[0] then
                        ini.main.clickwarpcoord = settings.main.clickwarpcoord[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Анти-маска', settings.main.antimask) then
                    if settings.cfg.autosave[0] then
                        ini.main.antimask = settings.main.antimask[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Анти-капча', settings.main.autocaptcha) then
                    if settings.cfg.autosave[0] then
                        ini.main.autocaptcha = settings.main.autocaptcha[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Напоминание о низком заряде', settings.battery.notifyLowCharge) then
                    if settings.cfg.autosave[0] then
                        ini.battery.notifyLowCharge = settings.battery.notifyLowCharge[0]
                        save()
                    end
                end
                if settings.battery.notifyLowCharge[0] then
                    imgui.PushItemWidth(200) 
                    if imgui.SliderInt(u8'Уровень заряда', settings.battery.lowBatteryLevel, 1, 100) then
                        if settings.battery.lowBatteryLevel[0] < 1 then
                            settings.battery.lowBatteryLevel[0] = 1
                        end
                        if settings.battery.lowBatteryLevel[0] > 100 then
                            settings.battery.lowBatteryLevel[0] = 100
                        end
                        if settings.cfg.autosave[0] then
                            ini.battery.lowBatteryLevel = settings.battery.lowBatteryLevel[0]
                            save()
                        end
                    end
                    imgui.PopItemWidth()
                end
                if imgui.ToggleButton(u8"Антифриз", settings.main.antiFreeze) then
                    if settings.cfg.autosave[0] then
                        ini.main.antiFreeze = settings.main.antiFreeze[0]
                        save()
                    end
                end
                if imgui.Button(u8'Реконнект', imgui.ImVec2(80 * MONET_DPI_SCALE, 30 * MONET_DPI_SCALE)) and not Reconnect.reconnecting and not Reconnect.waiting then
                    Reconnect.activate()
                end
                imgui.SameLine()
                if Reconnect.waiting then
                    imgui.SameLine()
                    imgui.Text(string.format(u8'Реконнект через %.2f секунд...', Reconnect.remaining / 1000))
                    imgui.SameLine()
                    if imgui.Button(fa.XMARK..u8' Отмена') then
                        Reconnect.abort = true
                    end
                end
                imgui.SetNextItemWidth(imgui.GetFontSize() * 15)
                imgui.SliderFloat(u8'Задержка реконнекта (в секундах)', Reconnect.delay, 0.0, 30.0)
                if imgui.Button(u8'Установить погоду') then
                    forceWeatherNow(WeatherAndTime.weather[0])
                end
                imgui.SameLine()
                imgui.SetNextItemWidth(imgui.GetFontSize() * 5)
                imgui.PushItemWidth(120)
                if imgui.InputInt(u8'Погода', WeatherAndTime.weather, 1, 10) then
                    if WeatherAndTime.weather[0] < 0 then
                        WeatherAndTime.weather[0] = 0
                    end
                    if WeatherAndTime.weather[0] > 45 then
                        WeatherAndTime.weather[0] = 45
                    end
                end
                imgui.PopItemWidth()
                imgui.SameLine()
                if imgui.ToggleButton(u8'Блокировать погоду сервера', settings.main.weatherblockserv) then
                    if settings.cfg.autosave[0] then
                        ini.main.weatherblockserv = settings.main.weatherblockserv[0]
                        save()
                    end
                end
                if imgui.Button(u8'Установить время') then
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
                if imgui.InputInt(u8'Время', WeatherAndTime.time, 1, 5) then
                    if WeatherAndTime.time[0] < 0 then
                        WeatherAndTime.time[0] = 0
                    end
                    if WeatherAndTime.time[0] > 23 then
                        WeatherAndTime.time[0] = 23
                    end
                end
                imgui.PopItemWidth()
                imgui.SameLine()
                if imgui.ToggleButton(u8'Блокировать время сервера', settings.main.timeblockserv) then
                    if settings.cfg.autosave[0] then
                        ini.main.timeblockserv = settings.main.timeblockserv[0]
                        save()
                    end
                end
            elseif subtab_1 == 2 then
                if imgui.ToggleButton(u8'Руда', settings.render.ruda) then
                    if settings.cfg.autosave[0] then
                        ini.render.ruda = settings.render.ruda[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Олени', settings.render.deer) then
                    if settings.cfg.autosave[0] then
                        ini.render.deer = settings.render.deer[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Семена нарко', settings.render.semena) then
                    if settings.cfg.autosave[0] then
                        ini.render.semena = settings.render.semena[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Закладки', settings.render.narkotiki) then
                    if settings.cfg.autosave[0] then
                        ini.render.narkotiki = settings.render.narkotiki[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Дерево высшего качества', settings.render.derevovishkac) then
                    if settings.cfg.autosave[0] then
                        ini.render.derevovishkac = settings.render.derevovishkac[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Подарок', settings.render.podarok) then
                    if settings.cfg.autosave[0] then
                        ini.render.podarok = settings.render.podarok[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Клад', settings.render.kladrender) then
                    if settings.cfg.autosave[0] then
                        ini.render.kladrender = settings.render.kladrender[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Яблочное дерево', settings.render.yabloki) then
                    if settings.cfg.autosave[0] then
                        ini.render.yabloki = settings.render.yabloki[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Cливовое дерево', settings.render.slivu) then
                    if settings.cfg.autosave[0] then
                        ini.render.slivu = settings.render.slivu[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Кокосное дерево', settings.render.kokosi) then
                    if settings.cfg.autosave[0] then
                        ini.render.kokosi = settings.render.kokosi[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Граффити', settings.render.graffiti) then
                    if settings.cfg.autosave[0] then
                        ini.render.graffiti = settings.render.graffiti[0]
                        save()
                    end
                end
            elseif subtab_1 == 3 then
                imgui.Text(u8'Удалить:')
                if imgui.Button(u8'Ворота армии ЛС', imgui.ImVec2(130 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 975 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Автоудаление', settings.objects.autormlsa) then
                    if settings.cfg.autosave[0] then
                        ini.objects.autormlsa = settings.objects.autormlsa[0]
                        save()
                    end
                end
                if imgui.Button(u8'Ворота армии СФ', imgui.ImVec2(130 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 988 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Автоудaление', settings.objects.autormsfa) then
                    if settings.cfg.autosave[0] then
                        ini.objects.autormsfa = settings.objects.autormsfa[0]
                        save()
                    end
                end
                if imgui.Button(u8'Шлагбаумы (КПП)', imgui.ImVec2(130 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 968 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Aвтоудаление', settings.objects.autormblockpost) then
                    if settings.cfg.autosave[0] then
                        ini.objects.autormblockpost = settings.objects.autormblockpost[0]
                        save()
                    end
                end
                if imgui.Button(u8'Фонарные столбы', imgui.ImVec2(130 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 1297 then
                            deleteObject(obj)
                        end
                        if modeid == 1283 then
                            deleteObject(obj)
                        end
                        if modeid == 1226 then
                            deleteObject(obj)
                        end
                        if modeid == 1294 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Автoудаление', settings.objects.autormlampposts) then
                    if settings.cfg.autosave[0] then
                        ini.objects.autormlampposts = settings.objects.autormlampposts[0]
                        save()
                    end
                end
                if imgui.Button(u8'Дорожные ремонты', imgui.ImVec2(130 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 1422 then
                            deleteObject(obj)
                        end
                        if modeid == 3865 then
                            deleteObject(obj)
                        end
                        if modeid == 19353 then
                            deleteObject(obj)
                        end
                        if modeid == 19445 then
                            deleteObject(obj)
                        end
                        if modeid == 1459 then
                            deleteObject(obj)
                        end
                        if modeid == 3864 then
                            deleteObject(obj)
                        end
                        if modeid == 16305 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Автoудаление##roadrem', settings.objects.autormroadrem) then
                    if settings.cfg.autosave[0] then
                        ini.objects.autormroadrem = settings.objects.autormroadrem[0]
                        save()
                    end
                end
                if settings.menu.showinfo[0] then
                    imgui.Text(u8'| (Будет пополняться в зависимости)')
                    imgui.Text(u8'| (от ваших пожеланий в чате Miku Project)')
                end
            end
        elseif tab == 2 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Персонаж") then
                subtab_2 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"Silent Aim##tab") then
                subtab_2 = 2
            end
            imgui.SameLine()
            if imgui.Button(u8"Оружие") then
                subtab_2 = 3
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_2 == 1 then
                if imgui.ToggleButton(u8'Бессмертие', settings.ped.godmode_enabled) then
                    if settings.cfg.autosave[0] then
                        ini.ped.godmode_enabled = settings.ped.godmode_enabled[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(200 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Ваншот ботов', settings.ped.killbots1hit) then
                    if settings.cfg.autosave[0] then
                        ini.ped.killbots1hit = settings.ped.killbots1hit[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(400 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'AutoScroll', settings.ped.autoscroll) then
                    if settings.cfg.autosave[0] then
                        ini.ped.autoscroll = settings.ped.autoscroll[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                if imgui.Button(fa.GEARS..'##scrollsettings', imgui.ImVec2(14.5 * MONET_DPI_SCALE, 14.5 * MONET_DPI_SCALE)) then
                    imgui.OpenPopup(u8'Настройки автоскролла')
                end
                imgui.PopStyleColor(3)
                if imgui.BeginPopupModal(u8'Настройки автоскролла', _, imgui.WindowFlags.AlwaysAutoResize) then
                    imgui.PushItemWidth(200)
                    if imgui.SliderInt(u8'Патроны##as', settings.ped.pt, 1, 100) then
                        if settings.cfg.autosave[0] then
                            ini.ped.pt = settings.ped.pt[0]
                            save()
                        end
                    end
                    if imgui.SliderInt(u8'Задержка скролла', settings.ped.wait, 1, 1000) then
                        if settings.cfg.autosave[0] then
                            ini.ped.wait = settings.ped.wait[0]
                            save()
                        end
                    end
                    imgui.PopItemWidth()
                    if imgui.Button(u8'Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                if imgui.ToggleButton(u8'No Reload', settings.ped.noreload) then
                    if settings.cfg.autosave[0] then
                        ini.ped.noreload = settings.ped.noreload[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(200 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Фейк скиллы', settings.ped.setskills) then
                    if settings.cfg.autosave[0] then
                        ini.ped.setskills = settings.ped.setskills[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(400 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Анти падение', settings.ped.nofall) then
                    if settings.cfg.autosave[0] then
                        ini.ped.nofall = settings.ped.nofall[0]
                        save()
                    end
                end
                imgui.ToggleButton(u8'Флуд взаимодействием', floodalt)
                imgui.SameLine()
                imgui.SetCursorPosX(200 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Авто +C', settings.ped.autoplusc) then
                    if settings.cfg.autosave[0] then
                        ini.ped.autoplusc = settings.ped.autoplusc[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(400 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Поле зрения', settings.ped.changefov) then
                    if settings.cfg.autosave[0] then
                        ini.ped.changefov = settings.ped.changefov[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                if imgui.Button(fa.GEARS..'##fovsettings', imgui.ImVec2(14.5 * MONET_DPI_SCALE, 14.5 * MONET_DPI_SCALE)) then
                    imgui.OpenPopup(u8'Настройки поля зрения')
                end
                imgui.PopStyleColor(3)
                if imgui.BeginPopupModal(u8'Настройки поля зрения', _, imgui.WindowFlags.AlwaysAutoResize) then
                    imgui.PushItemWidth(200)
                    if imgui.SliderInt(u8"Значение FOV'a", settings.ped.fovvalue, 50, 130) then
                        if settings.cfg.autosave[0] then
                            ini.ped.fovvalue = settings.ped.fovvalue[0]
                            save()
                        end
                    end
                    if imgui.Button(u8'Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                if imgui.ToggleButton(u8'Виджет сбива', settings.ped.sbiv) then
                    if settings.cfg.autosave[0] then
                        ini.ped.sbiv = settings.ped.sbiv[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.SetCursorPosX(200 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Бесконечный бег', settings.ped.infiniterun) then
                    if settings.cfg.autosave[0] then
                        ini.ped.infiniterun = settings.ped.infiniterun[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Скорость анимаций', settings.ped.animspeed) then
                    if settings.cfg.autosave[0] then
                        ini.ped.animspeed = settings.ped.animspeed[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                if imgui.Button(fa.GEARS..'##speedsettings', imgui.ImVec2(14.5 * MONET_DPI_SCALE, 14.5 * MONET_DPI_SCALE)) then
                    imgui.OpenPopup(u8'Настройки скорости анимаций')
                end
                imgui.PopStyleColor(3)
                if imgui.BeginPopupModal(u8'Настройки скорости анимаций', _, imgui.WindowFlags.AlwaysAutoResize) then
                    imgui.PushItemWidth(200)
                    if imgui.SliderInt(u8'Множитель скорости##animspeed', settings.ped.speedint, 1, 10) then
                        if settings.cfg.autosave[0] then
                            ini.ped.speedint = settings.ped.speedint[0]
                            save()
                        end
                    end
                    imgui.PopItemWidth()
                    if imgui.Button(u8'Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                imgui.SameLine()
                imgui.SetCursorPosX(200 * MONET_DPI_SCALE)
                if imgui.ToggleButton(u8'Рапид', settings.ped.rapidfire) then
                    if settings.cfg.autosave[0] then
                        ini.ped.rapidfire = settings.ped.rapidfire[0]
                        save()
                    end
                end
                imgui.SameLine()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
                if imgui.Button(fa.GEARS..'##rapidsettings', imgui.ImVec2(14.5 * MONET_DPI_SCALE, 14.5 * MONET_DPI_SCALE)) then
                    imgui.OpenPopup(u8'Настройки рапида')
                end
                imgui.PopStyleColor(3)
                if imgui.BeginPopupModal(u8'Настройки рапида', _, imgui.WindowFlags.AlwaysAutoResize) then
                    imgui.PushItemWidth(200)
                    if imgui.SliderInt(u8'Множитель рапида##rapidfire', settings.ped.rapidint, 1, 10) then
                        if settings.cfg.autosave[0] then
                            ini.ped.rapidint = settings.ped.rapidint[0]
                            save()
                        end
                    end
                    imgui.PopItemWidth()
                    if imgui.Button(u8'Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                if imgui.Button(u8'Установить скин', imgui.ImVec2(300 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    setskin_activate()
                end
                imgui.SameLine()
                imgui.SetNextItemWidth(imgui.GetFontSize() * 7)
                if imgui.InputInt(u8'ID Скина', settings.ped.skinid, 1, 50) then
                    if settings.cfg.autosave[0] then
                        ini.ped.skinid = settings.ped.skinid[0]
                        save()
                    end
                end
                if imgui.Button(u8'Включить бег CJ', imgui.ImVec2(146 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    setAnimGroupForChar(PLAYER_PED, "PLAYER")
                    notf4(u8'Бег CJ включен!')
                end
                imgui.SameLine()
                if imgui.Button(u8'Выключить бег CJ', imgui.ImVec2(146 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                    setAnimGroupForChar(PLAYER_PED, usePlayerAnimGroup and "PLAYER" or isCharMale(PLAYER_PED) and "MAN" or "WOMAN")
                    notf4(u8'Бег CJ выключен!')
                end
                imgui.PopItemWidth()
            elseif subtab_2 == 2 then
                if imgui.ToggleButton(u8'Silent Aim', settings.silent.salo) then
                    if settings.cfg.autosave[0] then
                        ini.silent.salo = settings.silent.salo[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Игнорировать автомобили', settings.silent.ignoreCars) then
                    if settings.cfg.autosave[0] then
                        ini.silent.ignoreCars = settings.silent.ignoreCars[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Игнорировать объекты', settings.silent.ignoreObj) then
                    if settings.cfg.autosave[0] then
                        ini.silent.ignoreObj = settings.silent.ignoreObj[0]
                        save()
                    end
                end
                imgui.Separator()
                if imgui.ToggleButton(u8'Автоматически выбирать дистанцию у оружие', settings.silent.useWeaponDistance) then
                    if settings.cfg.autosave[0] then
                        ini.silent.useWeaponDistance = settings.silent.useWeaponDistance[0]
                        save()
                    end
                end
                if not settings.silent.useWeaponDistance[0] then
                    if imgui.SliderInt(u8'Дистанция поиска цели', settings.silent.distance, 1, 1000) then
                        if settings.cfg.autosave[0] then
                            ini.silent.distance = settings.silent.distance[0]
                            save()
                        end
                    end
                end
                if imgui.SliderInt(u8'Радиус поиска цели', settings.silent.radius, 1, 100) then
                    if settings.cfg.autosave[0] then
                        ini.silent.radius = settings.silent.radius[0]
                        save()
                    end
                end
                if imgui.SliderFloat(u8'Положение FOV по X', settings.silent.offsetx, -200.0, 200.0) then
                    if settings.cfg.autosave[0] then
                        ini.silent.offsetx = settings.silent.offsetx[0]
                        save()
                    end
                end
                if imgui.SliderFloat(u8'Положение FOV по Y', settings.silent.offsety, -200.0, 200.0) then
                    if settings.cfg.autosave[0] then
                        ini.silent.offsety = settings.silent.offsety[0]
                        save()
                    end
                end
                imgui.Separator()
                if imgui.ToggleButton(u8'Отображать линию к цели', settings.silent.line) then
                    if settings.cfg.autosave[0] then
                        ini.silent.line = settings.silent.line[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Отображать прицел', settings.silent.circle) then
                    if settings.cfg.autosave[0] then
                        ini.silent.circle = settings.silent.circle[0]
                        save()
                    end
                end
                if settings.silent.circle[0] then
                    if imgui.ToggleButton(u8'Отображать более производительный прицел (более удобный)', settings.silent.fpscircle) then
                        if settings.cfg.autosave[0] then
                            ini.silent.fpscircle = settings.silent.fpscircle[0]
                            save()
                        end
                    end
                end
                if imgui.ToggleButton(u8'Писать снизу о нанесение урона', settings.silent.printString) then
                    if settings.cfg.autosave[0] then
                        ini.silent.printString = settings.silent.printString[0]
                        save()
                    end
                end
                imgui.Separator()
                if imgui.ToggleButton(u8'Промахи', settings.silent.misses) then
                    if settings.cfg.autosave[0] then
                        ini.silent.misses = settings.silent.misses[0]
                        save()
                    end
                end
                if settings.silent.misses[0] then
                    imgui.PushItemWidth(200)
                    if imgui.SliderInt(u8'Шансы на промах', settings.silent.miss_ratio, 1, 100) then
                        if settings.cfg.autosave[0] then
                            ini.silent.miss_ratio = settings.silent.miss_ratio[0]
                            save()
                        end
                    end
                    imgui.PopItemWidth()
                end
                imgui.ToggleButton(u8'Изменение камеры', fakemode)
            elseif subtab_2 == 3 then
                if imgui.Button(u8'Выдать ган') then
                    givePlayerGun(settings.dgun.gunsList[0], settings.dgun.ammo[0])
                end
                imgui.PushItemWidth(350)
                if imgui.Combo(u8'Ганы',settings.dgun.gunsList,ImItems, #item_list) then
                    ini.dgun.gunsList = settings.dgun.gunsList[0]
                    save()
                end
                imgui.PopItemWidth()
                imgui.PushItemWidth(350)
                if imgui.SliderInt(u8'Патроны##dgun', settings.dgun.ammo, 1, 2000) then
                    if settings.cfg.autosave[0] then
                        ini.dgun.ammo = settings.dgun.ammo[0]
                        save()
                    end
                end
                imgui.PopItemWidth()
                if settings.menu.showinfo[0] then
                    imgui.Text(u8"| Кикает без Resync'a, потому подойдет только для нуборп")
                end
            end
        elseif tab == 3 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Машина") then
                subtab_3 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"Attach Trailer##atr") then
                subtab_3 = 2
            end
            imgui.SameLine()
            if imgui.Button(u8"SpeedHack") then
                subtab_3 = 3
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_3 == 1 then
                if imgui.ToggleButton(u8'Бессмертие', settings.car.godmode2_enabled) then
                    if settings.cfg.autosave[0] then
                        ini.car.godmode2_enabled = settings.car.godmode2_enabled[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Полёт', settings.car.flycar) then
                    if settings.cfg.autosave[0] then
                        ini.car.flycar = settings.car.flycar[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Анти-падение с Мото', settings.car.nobike) then
                    if settings.cfg.autosave[0] then
                        ini.car.nobike = settings.car.nobike[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Бесконечное топливо', settings.car.infinitefuel) then
                    if settings.cfg.autosave[0] then
                        ini.car.infinitefuel = settings.car.infinitefuel[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Быстрая посадка в авто', settings.car.fastenter) then
                    if settings.cfg.autosave[0] then
                        ini.car.fastenter = settings.car.fastenter[0]
                        save()
                    end
                end
	            if imgui.ToggleButton(u8'Быстрый выход', settings.car.fastexit) then
                    if settings.cfg.autosave[0] then
                        ini.car.fastexit = settings.car.fastexit[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Быстрый тормоз + флип', settings.car.fastbrake) then
                    if settings.cfg.autosave[0] then
                        ini.car.fastbrake = settings.car.fastbrake[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Прыжок авто (start)', settings.car.jumpcar) then
                    if settings.cfg.autosave[0] then
                        ini.car.jumpcar = settings.car.jumpcar[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Анти карскилл', settings.car.anticarskill) then
                    if settings.cfg.autosave[0] then
                        ini.car.anticarskill = settings.car.anticarskill[0]
                        save()
                    end
                end
                if imgui.Button(u8'Флипнуть') then
                    if isCharInAnyCar(PLAYER_PED) then    
                        local veh = storeCarCharIsInNoSave(PLAYER_PED)
                        local x, y, z = getCarCoordinates(veh)
                        setCarCoordinates(veh, x, y, z)
                    end
                end
            elseif subtab_3 == 2 then
                if imgui.ToggleButton(u8'Attach Trailer', settings.car.atractive) then
                    if settings.cfg.autosave[0] then
                        ini.car.atractive = settings.car.atractive[0]
                        save()
                    end
                end
                imgui.PushItemWidth(250)
                if imgui.SliderInt(u8'Радиус', settings.car.atrradius, 1, 500) then
                    if settings.cfg.autosave[0] then
                        ini.car.atrradius = settings.car.atrradius[0]
                        save()
                    end
                end
                imgui.PopItemWidth()
            elseif subtab_3 == 3 then
                if imgui.ToggleButton(u8'SpeedHаck', settings.car.speedhack) then
                    if settings.cfg.autosave[0] then
                        ini.car.speedhack = settings.car.speedhack[0]
                        save()
                    end
                end
                if imgui.Button(u8'Настройки спидхака') then
                    imgui.OpenPopup(u8'Настройки спидхака')
                end
                if imgui.BeginPopupModal(u8'Настройки спидхака', _, imgui.WindowFlags.AlwaysAutoResize) then
                    if imgui.SliderFloat(u8'Сила ускорения', settings.car.slider_mult, 0.001, 100.0) then
			            if settings.cfg.autosave[0] then
			                ini.car.mult = settings.car.slider_mult[0]
			                save()
			            end
		            end
	        	    if imgui.SliderFloat(u8'Максимальная скорость', settings.car.slider_limit, 0.01, 1000.0) then
			            if settings.cfg.autosave[0] then
			                ini.car.limit = settings.car.slider_limit[0]
			                save()
			            end
		            end
		            if imgui.SliderFloat(u8'Шаг (мс)', settings.car.slider_timestep, 0.0, 1.0) then
			            if settings.cfg.autosave[0] then  
			                ini.car.timestep = settings.car.slider_timestep[0]
			                save()
			            end
		            end
		            if imgui.ToggleButton(u8'Безопасная скорость поезда', settings.car.safe_train_speed) then
			            if settings.cfg.autosave[0] then 
			                ini.car.safe_train_speed = settings.car.safe_train_speed[0]
			                save()
			            end
	        	    end
                    if imgui.Button(u8'Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
            end
        elseif tab == 4 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"ESP") then
                subtab_4 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"Настройки ESP") then
                subtab_4 = 2
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_4 == 1 then
                if imgui.ToggleButton(u8'Включить рисовку', settings.ESP.drawing) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.drawing = settings.ESP.drawing[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Коробки', settings.ESP.enabled_boxes) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_boxes = settings.ESP.enabled_boxes[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Ники', settings.ESP.enabled_nicks) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_nicks = settings.ESP.enabled_nicks[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Скелеты', settings.ESP.enabled_bones) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_bones = settings.ESP.enabled_bones[0]
                        ini.car.speedhack = settings.car.speedhack[0]
                    end
                end
                if imgui.ToggleButton(u8'Линии', settings.ESP.enabled_lines) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_lines = settings.ESP.enabled_lines[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Здоровье', settings.ESP.enabled_health) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_health = settings.ESP.enabled_health[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Броня', settings.ESP.enabled_armor) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.enabled_armor = settings.ESP.enabled_armor[0]
                        save()
                    end
                end
            elseif subtab_4 == 2 then
                if imgui.SliderInt(u8'Позиция линии', settings.ESP.lineposition, 0, 1) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.lineposition = settings.ESP.lineposition[0]
                        save()
                    end
                end
                if imgui.SliderInt(u8'Толщина линии', settings.ESP.linethinkness, 1, 4) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.linethinkness = settings.ESP.linethinkness[0]
                        save()
                    end
                end
                if imgui.SliderInt(u8'Толщина скелетов', settings.ESP.skeletonthinkness, 1, 4) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.skeletonthinkness = settings.ESP.skeletonthinkness[0]
                        save()
                    end
                end
                if imgui.SliderInt(u8'Толщина коробок', settings.ESP.boxthinkness, 1, 4) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.boxthinkness = settings.ESP.boxthinkness[0]
                        save()
                    end
                end
                if imgui.SliderFloat(u8'Размер никнеймов', settings.ESP.nicknamesize, 1, 10) then
                    if settings.cfg.autosave[0] then
                        ini.ESP.nicknamesize = settings.ESP.nicknamesize[0]
                        save()
                    end
                end
                if settings.ESP.enabled_boxes[0] then
                    if imgui.ToggleButton(u8'Градиентная заполненность', settings.ESP.enabled_fillgradient) then
                        if settings.cfg.autosave[0] then
                            ini.ESP.enabled_fillgradient = settings.ESP.enabled_fillgradient[0]
                            save()
                        end
                    end
                    if imgui.SliderFloat(u8'Заполненность коробок', settings.ESP.fillboxvalue, 0.0, 1.0) then
                        if settings.cfg.autosave[0] then
                            ini.ESP.fillboxvalue = settings.ESP.fillboxvalue[0]
                            save()
                        end
                    end
                end
            end
        elseif tab == 5 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Объекты") then
                subtab_5 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"ТП к стиралкам") then
                subtab_5 = 2
            end
            imgui.SameLine()
            if imgui.Button(u8"Утилиты") then
                subtab_5 = 3
            end
            imgui.SameLine()
            if imgui.Button(u8"Грузчик") then
                subtab_5 = 4
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_5 == 1 then
                if imgui.Button(u8'Удалить клетки') then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 19303 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.Button(u8'Удалить дверь') then
                    for _, obj in pairs(getAllObjects()) do
                        local modeid = getObjectModel(obj)
                        if modeid == 19857 then
                            deleteObject(obj)
                        end
                    end
                end
                imgui.SameLine()
                if imgui.Button(u8'Удалить заборы') then
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
                if imgui.ToggleButton(u8'Aвтoматич.', settings.tsr.autormcell) then
                    if settings.cfg.autosave[0] then
                        ini.tsr.autormcell = settings.tsr.autormcell[0]
                        save()
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Aвтоматич.', settings.tsr.autormdoors) then
                    if settings.cfg.autosave[0] then
                        ini.tsr.autormdoors = settings.tsr.autormdoors[0]
                        save()
                    end
                end
                imgui.SameLine()
                if imgui.ToggleButton(u8'Автoматич.', settings.tsr.autormfence) then
                    if settings.cfg.autosave[0] then
                        ini.tsr.autormfence = settings.tsr.autormfence[0]
                        save()
                    end
                end
            elseif subtab_5 == 2 then
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
                if imgui.Button(u8'Грязная одежда') then
                    setCharCoordinates(PLAYER_PED, 1396.1380, 1354.9414, 10)
                end
                imgui.SameLine()
                if imgui.Button(u8'Чистая одежда') then
                    setCharCoordinates(PLAYER_PED, 1397.8023, 1357.9216, 10.9390)
                end
            elseif subtab_5 == 3 then
                if imgui.ToggleButton(u8'Вх на мусор', settings.render.musortsr) then
                    if settings.cfg.autosave[0] then
                        ini.render.musortsr = settings.render.musortsr[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Бот коробки RAGE', tsrragebot) then
                    botstep = 0
                end
                if imgui.SliderInt(u8'Задержка', settings.tsr.tsrbotwait, 100, 5000) then
                    if settings.cfg.autosave[0] then
                        ini.tsr.tsrbotwait = settings.tsr.tsrbotwait[0]
                        save()
                    end
                end
            elseif subtab_5 == 4 then
                if imgui.Button(u8'ТП к началу') then
                    setCharCoordinates(PLAYER_PED, 257.86, 2012.86, 16.64)
                end
                imgui.SameLine()
                if imgui.Button(u8'ТП в центр') then
                    setCharCoordinates(PLAYER_PED, 244.37739562988, 2015.8483886719, 17.667018890381)
                end
                imgui.SameLine()
                if imgui.Button(u8'ТП в конец') then
                    setCharCoordinates(PLAYER_PED, 239.16299438477, 2026.7818603516, 16.687019348145)
                end
            end
        elseif tab == 6 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Кнопочки") then
                subtab_6 = 1
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_6 == 1 then
                if imgui.Button(fa.COMMENT..u8'  Очистить чат', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    for i = 1, 90 do
                        sampAddChatMessage("", -1)
                    end
                end
                imgui.SameLine()
                if imgui.Button(fa.SKULL_CROSSBONES..u8'  Умереть', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    setCharHealth(PLAYER_PED, 0)
                end
                imgui.SameLine()
                if imgui.Button(fa.HOUSE..u8'  Спавн', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    sendSpawn()
                end
                imgui.SameLine()
                if imgui.Button(fa.PERSON_WALKING..u8'  Вкл. прыжок', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    lua_thread.create(function()
                        sampSetSpecialAction(68)
                        wait(400)
                        sampSetSpecialAction(0)
                    end)
                end
                imgui.SameLine()
                if imgui.Button(fa.LOCATION_DOT..u8'  ТП метка', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    result, x, y, z = getTargetBlipCoordinatesFixed()
                    if result then setCharCoordinates(PLAYER_PED, x, y, z) end
                end
                if imgui.Button(fa.WIFI..u8'  Реконнект v2', imgui.ImVec2(125 * MONET_DPI_SCALE, 62 * MONET_DPI_SCALE)) then
                    notf4(u8'Реконнектимся...')
                    local bs = raknetNewBitStream()
                    raknetBitStreamWriteInt8(bs, sf.PACKET_DISCONNECTION_NOTIFICATION)
                    raknetSendBitStreamEx(bs, sf.SYSTEM_PRIORITY, sf.RELIABLE, 0)
                    raknetDeleteBitStream(bs)
                    bs = raknetNewBitStream()
                    raknetEmulPacketReceiveBitStream(sf.PACKET_CONNECTION_LOST, bs)
                    raknetDeleteBitStream(bs)
                end
                if imgui.Button(fa.CARET_UP..u8'  Slap up', imgui.ImVec2(125 * MONET_DPI_SCALE, 31 * MONET_DPI_SCALE)) then
                    local x, y, z = getCharCoordinates(PLAYER_PED)
                    setCharCoordinates(PLAYER_PED, x, y, z+5)
                end
                if imgui.Button(fa.CARET_DOWN..u8'  Slap down', imgui.ImVec2(125 * MONET_DPI_SCALE, 31 * MONET_DPI_SCALE)) then
                    local x, y, z = getCharCoordinates(PLAYER_PED)
                    setCharCoordinates(PLAYER_PED, x, y, z-5)
                end
            end
        elseif tab == 7 then
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.16, 0.16, 0.18, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.09, 0.09, 0.10, 1.00))
            if imgui.Button(u8"Открытие меню") then
                subtab_7 = 1
            end
            imgui.SameLine()
            if imgui.Button(u8"Меню") then
                subtab_7 = 2
            end
            imgui.SameLine()
            if imgui.Button(u8"Помощь") then
                subtab_7 = 3
            end
            imgui.SameLine()
            if imgui.Button(u8"Скрипт") then
                subtab_7 = 4
            end
            imgui.PopStyleColor(3)
            imgui.Separator()
            if subtab_7 == 1 then
                if imgui.ToggleButton(u8'Полоска снизу экрана', settings.menu.openbutton) then
                    if settings.cfg.autosave[0] then
                        ini.menu.openbutton = settings.menu.openbutton[0]
                        save()
                    end
                end
                if imgui.ToggleButton(u8'Кнопка "Menu"', settings.menu.openbutton2) then
                    if settings.cfg.autosave[0] then
                        ini.menu.openbutton2 = settings.menu.openbutton2[0]
                        save()
                    end
                end
		        if imgui.SliderInt(u8'Ширина кнопки меню', settings.menu.slideropenbuttonwidth, 30, 150) then
                    if settings.cfg.autosave[0] then
                        ini.menu.slideropenbuttonwidth = settings.menu.slideropenbuttonwidth[0]
                        save()
                    end
                end
		        if imgui.SliderInt(u8'Высота кнопки меню', settings.menu.slideropenbuttonheight, 30, 150) then
                    if settings.cfg.autosave[0] then
                        ini.menu.slideropenbuttonheight = settings.menu.slideropenbuttonheight[0]
                        save()
                    end
                end
            elseif subtab_7 == 2 then
                if imgui.Button(u8'Настройки меню') then
		            menusettings[0] = not menusettings[0]
		        end
		        if imgui.ToggleButton(u8'Включить спецэффекты меню', settings.menu.draweffects) then
		            if settings.cfg.autosave[0] then
		                ini.menu.draweffects = settings.menu.draweffects[0]
		                save()
		            end
		        end
                if imgui.ToggleButton(u8'Ватермарка', settings.menu.watermark) then
                    if settings.cfg.autosave[0] then
                        ini.menu.watermark = settings.menu.watermark[0]
                        save()
                    end
                end
            elseif subtab_7 == 3 then
                if imgui.ToggleButton(u8'Отображать подсказки', settings.menu.showinfo) then
                    if settings.cfg.autosave[0] then
                        ini.menu.showinfo = settings.menu.showinfo[0]
                        save()
                    end
                end
		        if imgui.Button(u8'Показать кнопку взаимодействия') then
		            settings.menu.sendalt[0] = not settings.menu.sendalt[0]
                    if settings.cfg.autosave[0] then
                        ini.menu.sendalt = settings.menu.sendalt[0]
                        save()
                    end
		        end
		        imgui.SameLine()
		        if imgui.Button(u8'Команды скрипта') then
		            imgui.OpenPopup(u8'Команды скрипта')
		        end
                if imgui.BeginPopupModal(u8'Команды скрипта', _, imgui.WindowFlags.AlwaysAutoResize) then
                    imgui.Text(u8'/miku - основное меню скрипта')
                    imgui.Text(u8'/tpc - телепорт метка (для нубо рп, моментальный)')
                    imgui.Text(u8'/jump - включить прыжок (баг, когда упал и перс не встает)')
                    imgui.Text(u8'/rc - реконнект')
                    imgui.Text(u8'/mikureload - перезагрузка скрипта')
                    if imgui.Button(u8' Закрыть') then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
            elseif subtab_7 == 4 then

                if imgui.Button(u8'Показать mimgui demo') then
		            custommimguiStyle[0] = not custommimguiStyle[0]
		        end
                if imgui.Button(u8'Обновиться на стабильную версию') then
                    updateScript(lmUrl, lmPath)
                end
                if imgui.Button(u8'Обновиться на Бета-версию') then
                    updateScript(betaUrl, betaPath)
                end
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
                    imgui.OpenPopup(u8'Сохранение')
                end
                if imgui.BeginPopupModal(u8'Сохранение', _, imgui.WindowFlags.NoResize) then
                    local pSize = imgui.ImVec2(300, 500)
                    imgui.SetWindowSizeVec2(imgui.ImVec2(230 * MONET_DPI_SCALE, 150 * MONET_DPI_SCALE))
                    if imgui.Button(u8'Сохранить настройки', imgui.ImVec2(205 * MONET_DPI_SCALE, 40)) then
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
                        ini.silent.offsetx = settings.silent.offsetx[0]
                        ini.silent.offsety = settings.silent.offsety[0]
                        ini.ESP.drawing = settings.ESP.drawing[0]
                        ini.ESP.enabled_boxes = settings.ESP.enabled_boxes[0]
                        ini.ESP.enabled_bones = settings.ESP.enabled_bones[0]
                        ini.ESP.enabled_nicks = settings.ESP.enabled_nicks[0]
                        ini.ESP.enabled_lines = settings.ESP.enabled_lines[0]
                        ini.ESP.enabled_health = settings.ESP.enabled_health[0]
                        ini.ESP.enabled_armor = settings.ESP.enabled_armor[0]
                        ini.ESP.enabled_fillgradient = settings.ESP.enabled_fillgradient[0]
                        ini.ESP.boxthinkness = settings.ESP.boxthinkness[0]
                        ini.ESP.skeletonthinkness = settings.ESP.skeletonthinkness[0]
                        ini.ESP.nicknamesize = settings.ESP.nicknamesize[0]
                        ini.ESP.lineposition = settings.ESP.lineposition[0]
                        ini.ESP.linethinkness = settings.ESP.linethinkness[0]
                        ini.ESP.fillboxvalue = settings.ESP.fillboxvalue[0]
                        ini.main.airbrakewidget = settings.main.airbrakewidget[0]
                        ini.main.clickwarpcoord = settings.main.clickwarpcoord[0]
                        ini.main.antimask = settings.main.antimask[0]
                        ini.main.timeblockserv = settings.main.timeblockserv[0]
                        ini.main.weatherblockserv = settings.main.weatherblockserv[0]
                        ini.main.autocaptcha = settings.main.autocaptcha[0]
                        ini.main.antiFreeze = settings.main.antiFreeze[0]
                        ini.ped.godmode_enabled = settings.ped.godmode_enabled[0]
                        ini.ped.noreload = settings.ped.noreload[0]
                        ini.ped.setskills = settings.ped.setskills[0]
                        ini.ped.animspeed = settings.ped.animspeed[0]
                        ini.ped.speedint = settings.ped.speedint[0]
                        ini.ped.rapidfire = settings.ped.rapidfire[0]
                        ini.ped.rapidint = settings.ped.rapidint[0]
                        ini.ped.skinid = settings.ped.skinid[0]
                        ini.ped.autoplusc = settings.ped.autoplusc[0]
                        ini.ped.infiniterun = settings.ped.infiniterun[0]
                        ini.ped.killbots1hit = settings.ped.killbots1hit[0]
                        ini.ped.sbiv = settings.ped.sbiv[0]
                        ini.ped.autoscroll = settings.ped.autoscroll[0]
                        ini.ped.pt = settings.ped.pt[0]
                        ini.ped.wait = settings.ped.wait[0]
                        ini.ped.nofall = settings.ped.nofall[0]
                        ini.ped.changefov = settings.ped.changefov[0]
                        ini.ped.fovvalue = settings.ped.fovvalue[0]
                        ini.car.godmode2_enabled = settings.car.godmode2_enabled[0]
                        ini.car.flycar = settings.car.flycar[0]
                        ini.car.nobike = settings.car.nobike[0]
                        ini.car.atractive = settings.car.atractive[0]
                        ini.car.atrradius = settings.car.atrradius[0]
                        ini.car.speedhack = settings.car.speedhack[0]
                        ini.car.mult = settings.car.slider_mult[0]
                        ini.car.timestep = settings.car.slider_timestep[0]
                        ini.car.limit = settings.car.slider_limit[0]
                        ini.car.safe_train_speed = settings.car.safe_train_speed[0]
                        ini.car.fastenter = settings.car.fastenter[0]
                        ini.car.infinitefuel = settings.car.infinitefuel[0]
                        ini.car.fastexit = settings.car.fastexit[0]
                        ini.car.fastbrake = settings.car.fastbrake[0]
                        ini.car.jumpcar = settings.car.jumpcar[0]
                        ini.car.anticarskill = settings.car.anticarskill[0]
                        ini.render.ruda = settings.render.ruda[0]
                        ini.render.deer = settings.render.deer[0]
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
                        ini.menu.slideropenbuttonwidth = settings.menu.slideropenbuttonwidth[0]
                        ini.menu.slideropenbuttonheight = settings.menu.slideropenbuttonheight[0]
                        ini.menu.openbutton = settings.menu.openbutton[0]
                        ini.menu.openbutton2 = settings.menu.openbutton2[0]
                        ini.menu.sendalt = settings.menu.sendalt[0]
                        ini.menu.sendaltwidth = settings.menu.sendaltwidth[0]
                        ini.menu.sendaltheight = settings.menu.sendaltheight[0]
                        ini.menu.showinfo = settings.menu.showinfo[0]
                        ini.menu.window_scale = settings.menu.window_scale[0]
                        ini.menu.draweffects = settings.menu.draweffects[0]
                        ini.menu.watermark = settings.menu.watermark[0]
                        ini.objects.autormlsa = settings.objects.autormlsa[0]
                        ini.objects.autormsfa = settings.objects.autormsfa[0]
                        ini.objects.autormblockpost = settings.objects.autormblockpost[0]
                        ini.objects.autormlampposts = settings.objects.autormlampposts[0]
                        ini.objects.autormroadrem = settings.objects.autormroadrem[0]
                        ini.tsr.tsrbotwait = settings.tsr.tsrbotwait[0]
                        ini.tsr.autormcell = settings.tsr.autormcell[0]
                        ini.tsr.autormdoors = settings.tsr.autormdoors[0]
                        ini.tsr.autormfence = settings.tsr.autormcell[0]
                        ini.battery.notifyLowCharge = settings.battery.notifyLowCharge[0]
                        ini.battery.lowBatteryLevel = settings.battery.lowBatteryLevel[0]
                        save()
                        notf1(u8'Настройки сохранены!')
                        imgui.CloseCurrentPopup()
                    end
                    if imgui.ToggleButton(u8'Автосохранение', settings.cfg.autosave) then
                        ini.cfg.autosave = settings.cfg.autosave[0]
                        save()
                    end
                    if imgui.Button(u8'Закрыть', imgui.ImVec2(205 * MONET_DPI_SCALE, 40)) then
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
                    if imgui.Button(u8'Да') then
                        os.remove(thisScript().path)
                        os.remove(getWorkingDirectory().."/config/MikuProject.ini")
                        thisScript():unload()
                    end
                    imgui.SameLine()
                    if imgui.Button(u8'Нет') then
                        deletescript = not deletescript
                    end
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

-- /* never update */ --
function main()
    while not isSampAvailable() do wait(0) end
    downloadLibraries()
    checkResFolder()
    clearTags()
    check_update()
    antifall()
    jniUtil.Toast(u8"Miku Reborn загружен!", jniUtil.ToastFlag.LENGTH_SHORT):show()
    
    sampRegisterChatCommand('miku', function() window_state[0] = not window_state[0] end)
    sampRegisterChatCommand('mikureload', function() thisScript():reload() end)
    sampRegisterChatCommand('jump', function()
        lua_thread.create(function()
            sampSetSpecialAction(68)
            wait(400)
            sampSetSpecialAction(0)
        end)
    end)
    sampRegisterChatCommand('rc', function()
        notf4(u8'Реконнектимся...')
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sf.PACKET_DISCONNECTION_NOTIFICATION)
        raknetSendBitStreamEx(bs, sf.SYSTEM_PRIORITY, sf.RELIABLE, 0)
        raknetDeleteBitStream(bs)

        bs = raknetNewBitStream()
        raknetEmulPacketReceiveBitStream(sf.PACKET_CONNECTION_LOST, bs)
        raknetDeleteBitStream(bs)
    end)
    sampRegisterChatCommand('tpc', function()
        result, x, y, z = getTargetBlipCoordinatesFixed()
        if result then setCharCoordinates(PLAYER_PED, x, y, z) end
    end)
    while true do wait(0)
        while not sampIsLocalPlayerSpawned() do wait(0) end
        if settings.battery.notifyLowCharge[0] and success or settings.battery.notifyLowCharge[0] and success2 then
            local getBatteryLevel = getBatteryPercentage()
            if getBatteryLevel <= settings.battery.lowBatteryLevel[0] then
                if not settings.battery.stopMessage then
                    settings.battery.stopMessage = true
                    jniUtil.Toast(u8"[Miku] Низкий заряд батареи!!", jniUtil.ToastFlag.LENGTH_SHORT):show()
                end
            else
                settings.battery.stopMessage = false
            end
        end
        if settings.render.ruda[0] then
            for id = 0, 2048 do
                if sampIs3dTextDefined(id) then
                    local text, color, x, y, z, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(id)
                    if text:find("Месторождение ресурсов") then
                        if isPointOnScreen(x, y, z, 3.0) then
                            xp, yp, zp = getCharCoordinates(PLAYER_PED)
                            x1, y2 = convert3DCoordsToScreen(x, y, z)
                            p3, p4 = convert3DCoordsToScreen(xp, yp, zp)
                            distance = string.format("%.0f", getDistanceBetweenCoords3d(x, y, z, xp, yp, zp))
                            text = ("{ffffff}Руда\n{B8FCFF}Distance: "..distance)
                            renderDrawLine(x1, y2, p3, p4, 2, 0xB8B8FCFF)
                            renderFontDrawText(font, text, x1, y2, -1)
                        end
                    end
                end
            end
        end
        if settings.render.deer[0] then
            local x, y, z = getCharCoordinates(PLAYER_PED)
            local c1, c2 = convert3DCoordsToScreen(x, y, z)

            for k, v in ipairs(getAllChars()) do
                if getCharModel(v) == 3150 and v ~= PLAYER_PED then
                    local x1, y1, z1 = getCharCoordinates(v)
                    local o1, o2 = convert3DCoordsToScreen(x1, y1, z1)
                    local dist = math.floor(getDistanceBetweenCoords3d(x, y, z, x1, y1, z1))
                    local text = '{87CEEB}Олень\n{87CEEB}DIST: '..dist..'m.'
                    
                    if isPointOnScreen(x1, y1, z1, 0) then
                        renderDrawLine(c1, c2, o1, o2, 1, 0xB8B8FCFF)
                        renderFontDrawText(font, text, o1, o2, -1)
                    end
                end
            end
        end
        if settings.ped.changefov[0] then
            cameraSetLerpFov(settings.ped.fovvalue[0], settings.ped.fovvalue[0], 1000, true)
        end
        if settings.car.jumpcar[0] and isCharInAnyCar(PLAYER_PED) then
            if isWidgetPressed(WIDGET_SCHOOL_START) then
                local x, y, z = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
                if z < 7 then
                    applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), 0, 0, 0.2, 0, 0, 0)
                end
            end
        end
        if settings.ped.autoscroll[0] then
            if getCurrentCharWeapon(PLAYER_PED) ~= 0 then
                for k, v in ipairs(guns) do
                    if getCurrentCharWeapon(PLAYER_PED) ~= v then
                        if getAmmoInClip() == settings.ped.pt[0] then
                            local ow = getCurrentCharWeapon(PLAYER_PED)
                            setCurrentCharWeapon(PLAYER_PED, 0)
                            samp_create_sync_data("player").send()
                            wait(settings.ped.wait[0])
                            setCurrentCharWeapon(PLAYER_PED, ow)
                        end
                    end
                end
            end
        end
        if settings.ped.godmode_enabled[0] then
            setCharProofs(PLAYER_PED, false, true, true, true, true)
        else
            setCharProofs(PLAYER_PED, false, false, false, false, false)
        end
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
        if settings.car.nobike[0] then
            if isCharInAnyCar(PLAYER_PED) then
                setCharCanBeKnockedOffBike(PLAYER_PED, true)
                if isCarInWater(storeCarCharIsInNoSave(PLAYER_PED)) then
                    setCharCanBeKnockedOffBike(PLAYER_PED, false)
                else
                    setCharCanBeKnockedOffBike(PLAYER_PED, true)
                end
            end
        else
            setCharCanBeKnockedOffBike(PLAYER_PED, false)
        end
        fontt = renderCreateFont("Arial", 17, 4)
        if chooseActive and pointMarker then
            renderFontDrawText(fontt, "Left your finger from the screen to teleport", renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs * 3) - 150, renderInfo.rcolor) 
            renderFontDrawText(fontt, string.format("%0.2fm", renderInfo.rdist), renderInfo.rsx, renderInfo.rsy - (renderInfo.rhoffs*2) - 150, 0xEEEEEEEE)		  
            if renderInfo.rcar ~= 0 then 
              renderFontDrawText(fontt, string.format("%s", findCarName(getCarModel(renderInfo.rcar))), renderInfo.rsx, renderInfo.rsy - renderInfo.rhoffs - 150, 0xEEEEEEEE) 
          end 
        end
        if settings.car.godmode2_enabled[0] then
            if isCharInAnyCar(PLAYER_PED) then
                setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), true, true, true, true, true)
            end
        else
            if isCharInAnyCar(PLAYER_PED) then
                setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), false, false, false, false, false)
            end
        end
        if settings.car.fastbrake[0] then
            if isCharInAnyCar(PLAYER_PED) then
                if isWidgetPressed(WIDGET_HORN) then
                    local posX, posY, posZ = getCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED))
                    setCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED), posX, posY, posZ)
                end
            end
        end
        if settings.ped.sbiv[0] then
            if not isCharInAnyCar(PLAYER_PED) then
                if isWidgetPressed(WIDGET_SWAP_WEAPONS) then
                    clearCharTasksImmediately(PLAYER_PED)
                end
            end
        end
        if settings.car.fastexit[0] then
            if isCharInAnyCar(PLAYER_PED) then
                if isWidgetPressed(WIDGET_ENTER_CAR) then
                    local posX, posY, posZ = getCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED))
                    warpCharFromCarToCoord(PLAYER_PED, posX, posY, posZ)
                end
            end
        end
        if settings.car.infinitefuel[0] then
            if isCharInAnyCar(PLAYER_PED) then
                switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)
            end
        end
        if settings.car.speedhack[0] then
            local veh = player_vehicle[0]
	        if isCharInAnyCar(PLAYER_PED) then
	            if isWidgetPressed(WIDGET_ACCELERATE) then
				    if timerprocess(settings.car.slider_timestep[0]) then
				    	if veh.nVehicleClass == 6 then
					    	local train = samem.cast('CTrain *', veh)
					    	while train ~= samem.nullptr do
						    	local new_speed = train.fTrainSpeed * settings.car.slider_mult[0]
						    	if settings.car.safe_train_speed[0] then
							    	if new_speed >= 0.99 then
								    	new_speed = 0.9
							    	end
						    	end
						    	if new_speed <= settings.car.slider_limit[0] then
							    	train.fTrainSpeed = new_speed
						    	end
						    	train = train.pNextCarriage
					    	end
				    	else
					    	while veh ~= samem.nullptr do
						    	local new_speed = veh.vMoveSpeed * settings.car.slider_mult[0]
						    	if new_speed:magnitude() <= settings.car.slider_limit[0] then
							    	veh.vMoveSpeed = new_speed
						    	end
						    	veh = veh.pTrailer
					    	end
				    	end
			    	end
		    	end
		    end
		end
        if armorbotstate then
			local x, y, z = getCharCoordinates(PLAYER_PED)
			if currentrounds == setrounds or z > 1044.125 then
				notf2(u8'Бот завершил работу.')
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
        if settings.main.timeblockserv[0] then
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
        if settings.main.weatherblockserv[0] then
            forceWeatherNow(WeatherAndTime.weather[0])
        end
        if wwwflycar then
            FlyCar.processFlyCar()
        end
        if not wwwflycar then
            FlyCar.cars = 0
        end
        if settings.objects.autormlsa[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 975 then
                    deleteObject(obj)
                end
            end
        end
        if settings.tsr.autormcell[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 19303 then
                    deleteObject(obj)
                end
            end
        end
        if settings.tsr.autormdoors[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 19857 then
                    deleteObject(obj)
                end
            end
        end
        if settings.tsr.autormfence[0] then
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
        if settings.objects.autormsfa[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 988 then
                    deleteObject(obj)
                end
            end
        end
        if settings.objects.autormblockpost[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 968 then
                    deleteObject(obj)
                end
            end
        end
        if settings.objects.autormlampposts[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 1297 then
                    deleteObject(obj)
                end
                if modeid == 1283 then
                    deleteObject(obj)
                end
                if modeid == 1226 then
                    deleteObject(obj)
                end
                if modeid == 1294 then
                    deleteObject(obj)
                end
            end
        end
        if settings.objects.autormroadrem[0] then
            for _, obj in pairs(getAllObjects()) do
                local modeid = getObjectModel(obj)
                if modeid == 1422 then
                    deleteObject(obj)
                end
                if modeid == 3865 then
                    deleteObject(obj)
                end
                if modeid == 19353 then
                    deleteObject(obj)
                end
                if modeid == 19445 then
                    deleteObject(obj)
                end
                if modeid == 1459 then
                    deleteObject(obj)
                end
                if modeid == 3864 then
                    deleteObject(obj)
                end
                if modeid == 16305 then
                    deleteObject(obj)
                end
            end
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
            for _, anim in ipairs(animSpeed) do
                setCharAnimSpeed(PLAYER_PED, anim, settings.ped.speedint[0])
            end
        end
        if settings.ped.rapidfire[0] then
            for _, anim in ipairs(rapidAnimations) do
                setCharAnimSpeed(PLAYER_PED, anim, settings.ped.rapidint[0])
            end
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
        if checkRenders(true, nil) then
            for _, obj_hand in pairs(getAllObjects()) do
                local modelid = getObjectModel(obj_hand)
                local _obj = checkRenders(false, modelid)
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

function checkRenders(state, modelid)
    if state then
        return settings.render.derevovishkac[0] or settings.render.graffiti[0] or settings.render.kladrender[0] or settings.render.kokosi[0] or settings.render.musortsr[0] or settings.render.narkotiki[0] or settings.render.podarok[0] or settings.render.semena[0] or settings.render.slivu[0] or settings.render.yabloki[0]
    else
        return (settings.render.derevovishkac[0] and derevovish[modelid]) or (settings.render.graffiti[0] and graffity[modelid]) or (settings.render.kladrender[0] and klad[modelid]) or (settings.render.kokosi[0] and kokos[modelid]) or (settings.render.musortsr[0] and musor[modelid]) or (settings.render.narkotiki[0] and narko[modelid]) or (settings.render.podarok[0] and gift[modelid]) or (settings.render.semena[0] and semenanarko[modelid]) or (settings.render.slivu[0] and sliva[modelid]) or (settings.render.yabloki[0] and apple[modelid])
    end
end

function checkObject()
    return settings.objects.autormblockpost[0] or settings.objects.autormlampposts[0] or settings.objects.autormlsa[0] or settings.objects.autormroadrem[0] or settings.objects.autormsfa[0]
end

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
    if nop then
        return false
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
    if nop then 
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

-- airbrake
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
    giveWeaponToChar(PLAYER_PED, id, ammo)
end

-- clickcoordmobile
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
			notf1(u8'Берём детали...')
			wait(1500)
			point = point + 1
			break
		end
		if point == 1 and getDistanceBetweenCoords2d(x, y, 2558.4392089844, -1291.0050048828) < 1 then
			armorbotalt = true
			notf1(u8'Изготавливаем...')
			repeat sendKey(1024) wait(math.random(75, 150)) until not armorbotalt or not armorbotstate
			point = point + 1
			break
		end
		if point == 2 and getDistanceBetweenCoords2d(x, y, 2564.4611816406, -1292.9296875) < 1 then
			armorbotalt = true
			notf1(u8'Сдаём...')
			repeat sendKey(1024) wait(math.random(75, 150)) until not armorbotalt or not armorbotstate
			notf1(currentrounds..u8' круг..')
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

function events.onServerMessage(clr, txt) 
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
		    notf2(u8'Вам написал администратор, закругляемся...')
			lua_thread.create(function()
				wait(math.random(1470, 1955))
				point = 0
				statusbot: terminate()
			end)	
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

function events.onShowDialog(dlgid, stl, tlt, b1, b2, text)
	if armorbotstate and string.find(text, 'Администратор') or string.find(text, 'телепортированы') then
		notf2(u8'Вам написал администратор, закругляемся...')
		lua_thread.create(function()
			wait(math.random(1470, 1955))
			point = 0
			armorbotstate = false
			statusbot: terminate()
		end)	
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
    if settings.main.autocaptcha[0] then
        if id == 220 then
            raknetBitStreamIgnoreBits(bs, 8)
            local type = raknetBitStreamReadInt8(bs)
            if type == 84 then
                local interfaceid = raknetBitStreamReadInt8(bs)
                local subid = raknetBitStreamReadInt8(bs)
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
    end
end)

-- nofreeze
function events.onTogglePlayerControllable(controllable)
    if settings.main.antiFreeze[0] then
    	return false
    end
end

-- message form
function notf1(text)
    Notifications.Show(u8'Miku Project Reborn:\n'..text, Notifications.TYPE.OK)
end

function notf2(text)
    Notifications.Show(u8'Miku Project Reborn:\n'..text, Notifications.TYPE.WARN)
end

function notf3(text)
    Notifications.Show(u8'Miku Project Reborn:\n'..text, Notifications.TYPE.ERROR)
end

function notf4(text)
    Notifications.Show(u8'Miku Project Reborn:\n'..text, Notifications.TYPE.INFO)
end

-- anti lomka
function events.onSetPlayerDrunk(drunkLevel)
    return {1}
end

-- antimask
function events.onPlayerStreamIn(id, team, model, position, rotation, color, fight)
    if settings.main.antimask[0] then
        local r, g, b, a = explode_rgba(color)
        if a >= 0 and a <= 4 then
            return {id, team, model, position, rotation, join_rgba(r, g, b, 0xAA), fight}
        end
    end
end

function setPlayerColor(id, color)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt16(bs, id)
    raknetBitStreamWriteInt32(bs, color)
    raknetEmulRpcReceiveBitStream(72, bs)
    raknetDeleteBitStream(bs)
end

function events.onSetPlayerColor(id, color)
    if settings.main.antimask[0] then
        local r, g, b, a = explode_rgba(color)
        if a >= 0 and a <= 4 then
            setPlayerColor(id, join_rgba(r, g, b, 0xAA))
            return false
        end
    end
end

function explode_rgba(rgba)
    local r = bit.band(bit.rshift(rgba, 24), 0xFF)
    local g = bit.band(bit.rshift(rgba, 16), 0xFF)
    local b = bit.band(bit.rshift(rgba, 8), 0xFF)
    local a = bit.band(rgba, 0xFF)
    return r, g, b, a
end

function join_rgba(r, g, b, a)
    local rgba = a  -- b
    rgba = bit.bor(rgba, bit.lshift(b, 8))
    rgba = bit.bor(rgba, bit.lshift(g, 16))
    rgba = bit.bor(rgba, bit.lshift(r, 24))
    return rgba
end

-- auto updates
function downloadFile(url, path)
    local response = {}
    local _, status_code, _ = http.request{
    url = url,
    method = "GET",
    sink = ltn12.sink.file(io.open(path, "w")),
        headers = {
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0;Win64) AppleWebkit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36",
        },
    }
    if status_code == 200 then
        return true
    else
        return false
    end
end

function downloadLibraries()
    if not doesDirectoryExist(getWorkingDirectory().."/lib/android") and not success or not doesDirectoryExist(getWorkingDirectory().."/lib/android") and not success2 then
        createDirectory(getWorkingDirectory().."/lib/android")
        createDirectory(getWorkingDirectory().."/lib/android/jar")
        downloadFile("https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/arizona.lua", getWorkingDirectory().."/lib/android/arizona.lua")
        downloadFile("https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/jni-raw.lua", getWorkingDirectory().."/lib/android/jni-raw.lua")
        downloadFile("https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/jnienv-util.lua", getWorkingDirectory().."/lib/android/jnienv-util.lua")
        downloadFile("https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/jnienv.lua", getWorkingDirectory().."/lib/android/jnienv.lua")
        downloadFile("https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/arzapi.jar", getWorkingDirectory().."/lib/android/jar/arzapi.jar")
        thisScript():reload()
    else
        jniUtil.LooperPrepare()
    end
end

function check_update()
    notf4(u8'Проверка наличия обновлений...')
    local currentVersionFile = io.open(lmPath, "r")
    local currentVersion = currentVersionFile:read("*a")
    currentVersionFile:close()
    local response = http.request(lmUrl)
    if response and response ~= currentVersion then
        notf4(u8"Найдено новое обновление! Вывожу окно для загрузки...")
        found_update[0] = not found_update[0]
    else
        notf1(u8"У вас актуальная версия скрипта.")
    end
end

function updateScript(scriptUrl, scriptPath)
    notf4(u8"Проверка наличия обновлений...")
    local response = http.request(scriptUrl)
    if response and response ~= currentVersion then
        notf4(u8"Обновление...")
        local success = downloadFile(scriptUrl, scriptPath)
        if success then
            notf1(u8"Скрипт успешно обновлен. Перезагрузка..")
            thisScript():reload()
        else
            notf3(u8"Неизвестная ошибка, не удалось обновить скрипт.")
        end
    else
        notf1(u8"Скрипт уже является последней версией.")
    end
end

-- auto ttf download
local ttf_links = {
    gotham = {
        url = "https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/Gotham_Pro.ttf",
        path = getWorkingDirectory() .. "/resource/Gotham_Pro.ttf",
    };
    zekton = {
        url = "https://github.com/MikuImpulse/Miku-Lua-AutoUpdates/raw/refs/heads/main/Zekton-Font.ttf",
        path = getWorkingDirectory() .. "/resource/Zekton-Font.ttf",
    }
}

function checkResFolder()
    local folderpath = getWorkingDirectory().."/resource"
    if not doesDirectoryExist(folderpath) then
        createDirectory(folderpath)
    end
    if not doesFileExist(getWorkingDirectory().."/resource/Zekton-Font.ttf") or not doesFileExist(getWorkingDirectory().."/resource/Gotham_Pro.ttf") then
        updateScript(ttf_links.gotham.url, ttf_links.gotham.path)
        updateScript(ttf_links.zekton.url, ttf_links.zekton.path)
    end
end

-- speedhack
local timer = {
	prev_time = 0;
}

function timerprocess(timestep)
	local curr_time = os.clock()
	if (curr_time - timer.prev_time) >= timestep then
		timer.prev_time = curr_time
		return true
	end
	return false
end

-- fast enter vehicle
function events.onSendEnterVehicle(vehicleId, passenger)
    lua_thread.create(function()
        if settings.car.fastenter[0] and not passenger then
            wait(300)
            warpCharIntoCar(PLAYER_PED, select(2, sampGetCarHandleBySampVehicleId(vehicleId)))
        elseif settings.car.fastenter[0] and passenger then
            wait(300)
            warpCharIntoCarAsPassenger(PLAYER_PED, select(2, sampGetCarHandleBySampVehicleId(vehicleId)), 2)
        end
    end)
end

--  spawnself  --
function sendSpawn()
    lua_thread.create(function()
        nop = true
        clearCharTasksImmediately(PLAYER_PED)
        setCharHealth(PLAYER_PED, 0)
        sampSendDeathByPlayer(65535, 51)
        sampRequestClass(getCharModel(PLAYER_PED))
        wait(200)
        nop = false
    end)
end

-- get ammo
function getAmmoInClip()
    local cped = ffi.cast("CPed *", getCharPointer(PLAYER_PED))
    local weapon = cped.aWeapons[cped.nActiveWeaponSlot]

    return tonumber(weapon.nAmmoInClip)
end

-- theme
function ThemeMenu()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    -- {{ (( WINDOW STYLE )) }} --
    style.WindowPadding = imgui.ImVec2(15, 12)
    style.WindowRounding = 12.0
    style.ChildRounding = 10.0
    style.FramePadding = imgui.ImVec2(12, 8)
    style.FrameRounding = 8.0
    style.ItemSpacing = imgui.ImVec2(12, 8)
    style.ItemInnerSpacing = imgui.ImVec2(10, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 14.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 10.0
    style.GrabRounding = 6.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    style.WindowBorderSize = 0.0
    -- {{ (( WINDOW COLORS )) }} --
    colors[imgui.Col.Text] = imgui.ImVec4(0.95, 0.95, 0.98, 1.00)
    colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.50, 0.50, 0.55, 1.00)
    colors[imgui.Col.WindowBg] = imgui.ImVec4(0.09, 0.09, 0.10, 1.00)
    colors[imgui.Col.ChildBg] = imgui.ImVec4(0.09, 0.09, 0.10, 1.00)
    colors[imgui.Col.PopupBg] = imgui.ImVec4(0.12, 0.12, 0.14, 1.00)
    colors[imgui.Col.Border] = imgui.ImVec4(0.18, 0.18, 0.20, 1.00)
    colors[imgui.Col.FrameBg] = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.25, 0.25, 0.28, 1.00)
    colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.30, 0.30, 0.34, 1.00)
    colors[imgui.Col.TitleBg] = imgui.ImVec4(0.12, 0.12, 0.14, 1.00)
    colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.12, 0.12, 0.14, 1.00)
    colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.12, 0.12, 0.14, 1.00)
    colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.30, 0.30, 0.34, 1.00)
    colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.35, 0.35, 0.39, 1.00)
    colors[imgui.Col.CheckMark] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.20, 0.41, 0.68, 1.00)
    colors[imgui.Col.Button] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.20, 0.41, 0.68, 1.00)
    colors[imgui.Col.Header] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.20, 0.41, 0.68, 1.00)
    colors[imgui.Col.Separator] = imgui.ImVec4(0.18, 0.18, 0.20, 1.00)
    colors[imgui.Col.Tab] = imgui.ImVec4(0.12, 0.12, 0.14, 1.00)
    colors[imgui.Col.TabHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[imgui.Col.TabActive] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.20, 0.41, 0.68, 1.00)
    colors[imgui.Col.PlotLines] = imgui.ImVec4(0.16, 0.29, 0.48, 1.00)
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

function ARGBtoRGB(color)
    return bit.band(color, 0xFFFFFF)
end

-- notifications from script mgr
Notifications.Show = function(text, type, time, colors)
    table.insert(Notifications._list, {
        text = text,
        type = type or 2,
        time = time or 4,
        start = os.clock(),
        alpha = 0,
        colors = colors or Notifications._COLORS[type]
    })
end

Notifications._TableToImVec = function(tbl)
    return imgui.ImVec4(tbl[1], tbl[2], tbl[3], tbl[4])
end

Notifications._BringFloatTo = function(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return from + (count * (to - from) / 100), true
    end
    return (timer > duration) and to or from, false
end

imgui.OnFrame(
    function() return #Notifications._list > 0 end,
    function(self)
        self.HideCursor = true
        for k, data in ipairs(Notifications._list) do
            if data.alpha == nil then Notifications._list[k].alpha = 0 end
            if os.clock() - data.start < 0.5 then
                Notifications._list[k].alpha = Notifications._BringFloatTo(0, 1, data.start, 0.5)
            elseif data.time - 0.5 < os.clock() - data.start then
                Notifications._list[k].alpha = Notifications._BringFloatTo(1, 0, data.start + data.time - 0.5, 0.5)
            end
            if os.clock() - data.start > data.time then
                table.remove(Notifications._list, k)
            end
        end

        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 300 * MONET_DPI_SCALE, 300 * MONET_DPI_SCALE
        imgui.SetNextWindowPos(imgui.ImVec2(resX * 0.5, resY * 0.5), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin('notf_window', _, 0
            + imgui.WindowFlags.AlwaysAutoResize
            + imgui.WindowFlags.NoTitleBar
            + imgui.WindowFlags.NoResize
            + imgui.WindowFlags.NoMove
            + imgui.WindowFlags.NoBackground
        )   
        local fiveSc = 5 * MONET_DPI_SCALE
        local winSize = imgui.GetWindowSize()
        imgui.SetWindowPosVec2(imgui.ImVec2(resX - 10 * MONET_DPI_SCALE - winSize.x, resY * 0.4))
    
        for k, data in ipairs(Notifications._list) do
      ------------------------------------------------
            local default_data = {
                text = 'text',
                type = 0,
                time = 1500
            }
            for k, v in pairs(default_data) do
                if data[k] == nil then
                    data[k] = v
                end
            end
            local c = imgui.GetCursorPos()
            local p = imgui.GetCursorScreenPos()
            local DL = imgui.GetWindowDrawList()
            local textSize = imgui.CalcTextSize(data.text)
            local iconSize = imgui.CalcTextSize(Notifications.ICON[data.type] or faicons('XMARK'))
            local size = imgui.ImVec2(fiveSc + iconSize.x + fiveSc + textSize.x + fiveSc, fiveSc + textSize.y + fiveSc)
            local winSize = imgui.GetWindowSize()
            if winSize.x > size.x + 20 * MONET_DPI_SCALE then
                imgui.SetCursorPosX(winSize.x - size.x - 8 * MONET_DPI_SCALE)
            end   
            imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, data.alpha)
            imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, fiveSc)
            imgui.PushStyleColor(imgui.Col.ChildBg,     Notifications._TableToImVec(data.colors.back or Notifications._COLORS[data.type].back))
            imgui.PushStyleColor(imgui.Col.Border,      Notifications._TableToImVec(data.colors.border or Notifications._COLORS[data.type].border))
            imgui.BeginChild('toastNotf:'..tostring(k)..tostring(data.text), size, true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
            imgui.PushStyleColor(imgui.Col.Text,    Notifications._TableToImVec(data.colors.icon or Notifications._COLORS[data.type].icon))
            imgui.SetCursorPos(imgui.ImVec2(fiveSc, size.y / 2 - iconSize.y / 2))
            imgui.Text(Notifications.ICON[data.type] or faicons('XMARK'))
            imgui.PopStyleColor()

            imgui.PushStyleColor(imgui.Col.Text,    Notifications._TableToImVec(data.colors.text or Notifications._COLORS[data.type].text))
            imgui.SetCursorPos(imgui.ImVec2(fiveSc + iconSize.x + fiveSc, size.y / 2 - textSize.y / 2))
            imgui.Text(data.text)
            imgui.PopStyleColor()
            imgui.EndChild()
            imgui.PopStyleColor(2)
            imgui.PopStyleVar(2)
      ------------------------------------------------
        end
    imgui.End()
end)

-- kill bots 1hit
function onSendPacket(id, bs)
    if settings.ped.killbots1hit[0] and id == 221 then
        raknetBitStreamSetReadOffset(bs, 8)
        if raknetBitStreamReadInt16(bs) == 73 then
            local data = {}
            for i = 1, (raknetBitStreamGetNumberOfUnreadBits(bs)/8) do table.insert(data, raknetBitStreamReadInt8(bs)) end
            local damage_bs = raknetNewBitStream()
            raknetBitStreamWriteInt8(damage_bs, 221)
            raknetBitStreamWriteInt16(damage_bs, 73)
            for i = 1, 2 do raknetBitStreamWriteInt8(damage_bs, data[i]) end
            raknetBitStreamWriteInt8(damage_bs, 0)
            raknetBitStreamWriteInt8(damage_bs, 6)
            raknetBitStreamWriteInt8(damage_bs, 62)
            raknetBitStreamWriteInt8(damage_bs, 62)
            for i = 7, #data do raknetBitStreamWriteInt8(damage_bs, data[i]) end
            raknetSendBitStreamEx(damage_bs, 1, 7, 1)
            raknetDeleteBitStream(damage_bs)
            return false
        end
    end
end

-- полоска
imgui.OnFrame(function() return settings.menu.openbutton[0] end, function(self)
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.SetNextWindowSize(imgui.ImVec2(300, 50), imgui.Cond.Always)
    local scrx, scry = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(scrx / 2, scry - 27), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin('##poloska', settings.menu.openbutton, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
    imgui.SetCursorPos(imgui.ImVec2(0, 30))
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    dl:AddRectFilled(p, imgui.ImVec2(p.x + 293, p.y + 10), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.00, 1.00, 1.00, 1.00)), 10, 10)
    imgui.SetCursorPos(imgui.ImVec2(0, 0))
    if imgui.InvisibleButton('##hidemenu', imgui.GetWindowSize()) then
        window_state[0] = not window_state[0]
    end
    imgui.PopStyleColor(2)
    imgui.End()
end)

local figure = {
    x = 0,
    y = 0,
    vx = 0,
    vy = 0,
    color = {1, 0, 0, 1},
    shape = "circle"
}

--[[local function create_figure()
  local new_figure = {
    x = math.random(0, getScreenResolution()),
    y = math.random(0, getScreenResolution()),
    vx = math.random(-5, 5),
    vy = math.random(-5, 5),
    color = {
      math.random(),
      math.random(),
      math.random(),
      1,
    },
  }
  return new_figure
end

local figures = {}
for i = 1, 100 do
    table.insert(figures, create_figure())
end

imgui.OnFrame(function() return window_state[0] and settings.menu.draweffects[0] end, function()
    local bgdl = imgui.GetBackgroundDrawList()
    bgdl:AddRectFilled(imgui.ImVec2(0, 0), imgui.ImVec2(3000, 3000), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.00, 0.00, 0.00, 0.60)), 20, 1 + 8)
    for i = 1, #figures do
        for j = i + 1, #figures do
            local distance = math.sqrt((figures[i].x - figures[j].x)^2 + (figures[i].y - figures[j].y)^2)
            if distance < 100 then
                bgdl:AddLine(imgui.ImVec2(figures[i].x, figures[i].y), imgui.ImVec2(figures[j].x, figures[j].y), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(figures[j].color)), 1.0)
            end
        end
    end
    for _, fig in ipairs(figures) do
        fig.x = fig.x + fig.vx
        fig.y = fig.y + fig.vy
        if fig.x < 0 or fig.x > getScreenResolution() then
            fig.vx = -fig.vx
        end
        if fig.y < 0 or fig.y > getScreenResolution() then
            fig.vy = -fig.vy
        end
        bgdl:AddCircleFilled(imgui.ImVec2(fig.x, fig.y), 10, imgui.ColorConvertFloat4ToU32(fig.color))
    end
end)]]

local screen_resX, screen_resY = getScreenResolution()

local function create_snowflake()
    local new_snowflake = {
        x = math.random(0, screen_resX),
        y = -math.random(10, 50), -- Start above the screen
        vx = math.random(-1, 1), -- Small horizontal drift
        vy = math.random(2, 5),   -- Vertical speed (falling)
        size = math.random(5, 15),
        color = {1, 1, 1, 1},
    }
    return new_snowflake
end

local snowflakes = {}
local max_snowflakes = 100

imgui.OnFrame(function() return window_state[0] and settings.menu.draweffects[0] end, function()
    local bgdl = imgui.GetBackgroundDrawList()
    bgdl:AddRectFilled(imgui.ImVec2(0, 0), imgui.ImVec2(screen_resX, screen_resY), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.00, 0.00, 0.00, 0.60)), 20, 1 + 8)

    -- Remove old snowflakes
    snowflakes = table_filter(snowflakes, function(snowflake) return snowflake.y < screen_resY + 50 end)

    -- Add new snowflakes if needed
    while #snowflakes < max_snowflakes do
        table.insert(snowflakes, create_snowflake())
    end

    for i, snowflake in ipairs(snowflakes) do
        snowflake.x = snowflake.x + snowflake.vx
        snowflake.y = snowflake.y + snowflake.vy

        -- Remove snowflakes that have fallen off the screen
        if snowflake.y > screen_resY + snowflake.size then
            table.remove(snowflakes, i)
        else
            -- Draw snowflake (no horizontal constraints)
            local size = snowflake.size
            local center = imgui.ImVec2(snowflake.x, snowflake.y)
            bgdl:AddLine(center, imgui.ImVec2(snowflake.x + size, snowflake.y), imgui.ColorConvertFloat4ToU32(snowflake.color), 1)
            bgdl:AddLine(center, imgui.ImVec2(snowflake.x - size, snowflake.y), imgui.ColorConvertFloat4ToU32(snowflake.color), 1)
            bgdl:AddLine(center, imgui.ImVec2(snowflake.x, snowflake.y + size), imgui.ColorConvertFloat4ToU32(snowflake.color), 1)
            bgdl:AddLine(center, imgui.ImVec2(snowflake.x, snowflake.y - size), imgui.ColorConvertFloat4ToU32(snowflake.color), 1)
        end
    end
end)


function table_filter(tbl, fn)
    local new_tbl = {}
    for _, v in ipairs(tbl) do
        if fn(v) then
            table.insert(new_tbl, v)
        end
    end
    return new_tbl
end

-- watermark
imgui.OnFrame(function() return settings.menu.watermark[0] end, function(player)
    local scrx, scry = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(20, 10), imgui.Cond.Always)
    imgui.SetNextWindowSize(imgui.ImVec2(390 * MONET_DPI_SCALE, 34 * MONET_DPI_SCALE), imgui.Cond.Always)
    local BatteryPercent = getBatteryPercentage()
    local colors = {
        blue = imgui.ImVec4(0, 0.5, 1, 1),
        white = imgui.ImVec4(1, 1, 1, 1),
        red = imgui.ImVec4(1, 0, 0, 1),
        orange = imgui.ImVec4(1, 0.5, 0, 1),
        yellow = imgui.ImVec4(1, 0.8, 0, 1),
        green = imgui.ImVec4(0, 1, 0, 1),
    }
    
    local batteryIcon, batteryColor = "", colors.white
    local fpsColor, pingColor = colors.white, colors.white
    local fps = imgui.GetIO().Framerate
    local ping = sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))

    if BatteryPercent <= 10 then
        batteryIcon, batteryColor = fa.BATTERY_EMPTY, colors.red
    elseif BatteryPercent <= 30 then
        batteryIcon, batteryColor = fa.BATTERY_QUARTER, colors.orange
    elseif BatteryPercent <= 60 then
        batteryIcon, batteryColor = fa.BATTERY_HALF, colors.yellow
    elseif BatteryPercent <= 80 then
        batteryIcon, batteryColor = fa.BATTERY_THREE_QUARTERS, colors.green
    else
        batteryIcon, batteryColor = fa.BATTERY_FULL, colors.green
    end

    fpsColor = fps <= 5 and colors.red or fps <= 10 and colors.orange or fps <= 30 and colors.yellow or colors.green
    pingColor = ping <= 60 and colors.green or ping <= 120 and colors.yellow or colors.red

    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.12, 0.12, 0.14, 0.70))
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.90, 0.90, 0.93, 0.85))

    if imgui.Begin("##minet", settings.menu.watermark, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoInputs + imgui.WindowFlags.NoScrollbar) then
        imgui.TextColored(colors.blue, "Miku")
        imgui.SameLine()
        imgui.SetCursorPosX(imgui.GetCursorPosX() - 8)
        imgui.TextColored(colors.white, "Reborn")
        imgui.SameLine()
        imgui.SetCursorPosX(imgui.GetCursorPosX() - 8)
        imgui.Text(u8("| "..script_ver.." | @mikusilent | "))
        imgui.SameLine()
        imgui.SetCursorPos(imgui.ImVec2(imgui.GetCursorPosX() - 10, imgui.GetCursorPosY() + 5))
        imgui.TextColored(batteryColor, batteryIcon)
        imgui.SameLine()
        imgui.SetCursorPos(imgui.ImVec2(imgui.GetCursorPosX() - 10, imgui.GetCursorPosY() - 3.5))
        imgui.TextColored(batteryColor, BatteryPercent .. "%%")
        imgui.SameLine()
        imgui.TextColored(fpsColor, string.format("FPS: %.0f", fps))
        imgui.SameLine()
        imgui.SetCursorPosY(imgui.GetCursorPosY() - 1)
        imgui.TextColored(pingColor, string.format("ping: %.0f", ping))
    end

    imgui.PopStyleColor(2)
    imgui.End()
end)

--({ DRAWLIST ESP })--
imgui.OnFrame(function() return settings.ESP.drawing[0] and not isGamePaused() end, function(self)
    local draw = imgui.GetBackgroundDrawList()
    for _, char in ipairs(getAllChars()) do
        local result, id = sampGetPlayerIdByCharHandle(char)
        if result and isCharOnScreen(char) and char ~= PLAYER_PED then
            local opaque_color = imgui.ColorConvertFloat4ToU32(get_player_color_imvec4(id))
            local fillbox_opaque = imgui.ColorConvertFloat4ToU32(get_player_color_imvec4_2(id))
            local x, y, z = getOffsetFromCharInWorldCoords(char, 0, 0, 0)
            local hr_head, headx, heady = convert3DCoordsToScreenEx(x, y, z + 1.0)
            local hr_foot, footx, footy = convert3DCoordsToScreenEx(x, y, z - 1.0)
            local box_width = math.abs((heady - footy) * 0.25)
            local box_x1 = headx - box_width
            local box_x2 = headx + box_width
            local box_y1 = heady
            local box_y2 = footy
            if settings.ESP.enabled_bones[0] then
                for _, bone in ipairs(ESP2.BONES) do
                    local x1, y1, z1 = getBonePosition(char, bone)
                    local x2, y2, z2 = getBonePosition(char, bone + 1)
                    local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                    if r1 and r2 then
                        draw:AddLine(imgui.ImVec2(sx1, sy1), imgui.ImVec2(sx2, sy2), opaque_color, settings.ESP.skeletonthinkness[0])
                    end
                end
                local x1, y1, z1 = getBonePosition(char, 2)
                local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                if r1 then
                    local x2, y2, z2 = getBonePosition(char, 41)
                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                    if r2 then
                        draw:AddLine(imgui.ImVec2(sx1, sy1), imgui.ImVec2(sx2, sy2), opaque_color, settings.ESP.skeletonthinkness[0])
                    end
                end
                if r1 then
                    local x2, y2, z2 = getBonePosition(char, 51)
                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                    if r2 then
                        draw:AddLine(imgui.ImVec2(sx1, sy1), imgui.ImVec2(sx2, sy2), opaque_color, settings.ESP.skeletonthinkness[0])
                    end
                end
            end
            if settings.ESP.enabled_boxes[0] then
                if hr_head and hr_foot then
                    if settings.ESP.enabled_fillgradient[0] then
                        draw:AddRectFilledMultiColor(imgui.ImVec2(box_x1, box_y1), imgui.ImVec2(box_x2, box_y2), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 0.0)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 0.0)), fillbox_opaque, fillbox_opaque)
                    else
                        draw:AddRectFilled(imgui.ImVec2(box_x1, box_y1), imgui.ImVec2(box_x2, box_y2), fillbox_opaque, 0)
                    end
                    drawOutlinedBox(drawlist, box_x1, box_y1, box_x2, box_y2, opaque_color, outline_color, settings.ESP.boxthinkness[0])
                end
            end
            if settings.ESP.enabled_nicks[0] then
                local hx, hy, hz = getBonePosition(char, 5)
                local x, y, z = getCharCoordinates(PLAYER_PED)
                local hr, headx, heady = convert3DCoordsToScreenEx(hx, hy, hz + 0.25)
                if hr then
                    local nickname = sampGetPlayerNickname(id)
                    if settings.ESP.enabled_health[0] and not settings.ESP.enabled_armor[0] then
                        nametag = nickname .. ' [' .. tostring(id) .. '] - ' .. string.format("%.0f", sampGetPlayerArmor(id)) .. 'ap'
                    end
                    if settings.ESP.enabled_armor[0] and not settings.ESP.enabled_health[0]  then
                        nametag = nickname .. ' [' .. tostring(id) .. '] - ' .. string.format("%.0f", sampGetPlayerHealth(id)) .. 'hp'
                    end
                    if settings.ESP.enabled_health[0] and settings.ESP.enabled_armor[0] then
                        nametag = nickname .. ' [' .. tostring(id) .. ']'
                    end
                    if not settings.ESP.enabled_health[0] and not settings.ESP.enabled_armor[0] then
                        nametag = nickname .. ' [' .. tostring(id) .. '] - ' .. string.format("%.0f", sampGetPlayerHealth(id)) .. 'hp ' .. string.format("%.0f", sampGetPlayerArmor(id)) .. 'ap'
                    end
                    local nametag_len = imgui.CalcTextSize(nametag)
                    local oox, ooy = getScreenResolution()
                    local nametag_x = oox - nametag_len.x / 2
                    local nametag_y = heady - imgui.GetFontSize()
                    local font = imgui.GetFont()
                    local font_size = 18 + settings.ESP.nicknamesize[0]
                    local font_size2 = 19 + settings.ESP.nicknamesize[0]
                    drawNameTag(draw, nametag, headx, nametag_y, opaque_color, font, font_size) 
                end
            end
            if settings.ESP.enabled_lines[0] then
                local sx, sy = getScreenResolution()
                local hx, hy, hz = getBonePosition(char, 5)
                local hr, headx, heady = convert3DCoordsToScreenEx(hx, hy, hz + 0.25)
                draw:AddCircleFilled(imgui.ImVec2(headx - 0.1 * MONET_DPI_SCALE, heady - 45 * MONET_DPI_SCALE), 5.0 * MONET_DPI_SCALE, opaque_color, 100, 5.0)
                draw:AddLine(imgui.ImVec2(sx / 2, sy * settings.ESP.lineposition[0]), imgui.ImVec2(headx, heady - 45 * MONET_DPI_SCALE), opaque_color, settings.ESP.linethinkness[0])
            end
            if settings.ESP.enabled_health[0] then
                local current_hp = sampGetPlayerHealth(id)
                local max_hp = 100

                local health_bar_x = box_x1 - 10
                drawHealthBar(drawlist, health_bar_x, box_y1, box_y2 - box_y1, current_hp, max_hp, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 1.0, 0.0, 1.0)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 0.5)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 1.0)), 3)
            end

            if settings.ESP.enabled_armor[0] then
                local armor_bar_x = box_x1
                local armor_bar_y = box_y2 + 5
                local current_armor = sampGetPlayerArmor(id)
                local max_armor = 100
                drawArmorBar(drawlist, armor_bar_x, armor_bar_y, box_x2 - box_x1, current_armor, max_armor, imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.7, 1.0, 1.0)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 0.5)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 1.0)), 1)
            end
        end
    end
end)

function drawNameTag(drawlist, text, x, y, color, font, font_size)
    local text_size = imgui.CalcTextSize(text)

    local text_x = x - text_size.x / 2
    local text_y = y - text_size.y / 2

    local outline_offset = 2
    local outline_color = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 1.0))

    imgui.GetBackgroundDrawList():AddTextFontPtr(font, font_size, imgui.ImVec2(text_x - outline_offset, text_y - 20 - outline_offset), outline_color, text)
    imgui.GetBackgroundDrawList():AddTextFontPtr(font, font_size, imgui.ImVec2(text_x + outline_offset, text_y - 20 - outline_offset), outline_color, text)
    imgui.GetBackgroundDrawList():AddTextFontPtr(font, font_size, imgui.ImVec2(text_x - outline_offset, text_y - 20 + outline_offset), outline_color, text)
    imgui.GetBackgroundDrawList():AddTextFontPtr(font, font_size, imgui.ImVec2(text_x + outline_offset, text_y - 20 + outline_offset), outline_color, text)

    imgui.GetBackgroundDrawList():AddTextFontPtr(font, font_size, imgui.ImVec2(text_x, text_y - 20), color, text)
end

function drawOutlinedBox(drawlist, x1, y1, x2, y2, color, outline_color, thickness)
    local outline_color = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.GetBackgroundDrawList():AddRect(imgui.ImVec2(x1 - thickness, y1 - thickness), imgui.ImVec2(x2 + thickness, y2 + thickness), outline_color, 0, 0, thickness)
    imgui.GetBackgroundDrawList():AddRect(imgui.ImVec2(x1 + thickness, y1 + thickness), imgui.ImVec2(x2 - thickness, y2 - thickness), outline_color, 0, 0, thickness)
    imgui.GetBackgroundDrawList():AddRect(imgui.ImVec2(x1, y1), imgui.ImVec2(x2, y2), color, 0, 0, thickness)
end

function drawHealthBar(drawlist, x, y, height, current_hp, max_hp, bar_color, background_color, outline_color, outline_thickness)
    local bar_width = 6
    local hp_percent = current_hp / max_hp
    if hp_percent > 1 then
        hp_percent = 1
    elseif hp_percent < 0 then
        hp_percent = 0
    end
    local filled_height = height * hp_percent

    local filled_y = y + height - filled_height

    imgui.GetBackgroundDrawList():AddRect(imgui.ImVec2(x - bar_width, y), imgui.ImVec2(x, y + height), outline_color, 0, 0, outline_thickness)

    imgui.GetBackgroundDrawList():AddRectFilled(imgui.ImVec2(x - bar_width, y), imgui.ImVec2(x, y + height), background_color)
    
    imgui.GetBackgroundDrawList():AddRectFilled(imgui.ImVec2(x - bar_width, filled_y), imgui.ImVec2(x, y + height), bar_color)

    local text_x = x - bar_width - 5 
    local text_y = filled_y - 12
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x - 1, text_y - 1), outline_color, tostring(current_hp))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x + 1, text_y - 1), outline_color, tostring(current_hp))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x - 1, text_y + 1), outline_color, tostring(current_hp))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x + 1, text_y + 1), outline_color, tostring(current_hp))

    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x, text_y), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), tostring(current_hp))
end

function drawArmorBar(drawlist, x, y, width, current_armor, max_armor, bar_color, background_color, outline_color, outline_thickness)
    local bar_height = 6
    local armor_percent = current_armor / max_armor
    if armor_percent > 1 then
        armor_percent = 1
    elseif armor_percent < 0 then
        armor_percent = 0
    end
    local filled_width = width * armor_percent

    imgui.GetBackgroundDrawList():AddRect(imgui.ImVec2(x, y), imgui.ImVec2(x + width, y + bar_height), outline_color, 0, 0, outline_thickness)
    
    imgui.GetBackgroundDrawList():AddRectFilled(imgui.ImVec2(x, y), imgui.ImVec2(x + width, y + bar_height), background_color)

    imgui.GetBackgroundDrawList():AddRectFilled(imgui.ImVec2(x, y), imgui.ImVec2(x + filled_width, y + bar_height), bar_color)

    local text_x = x + filled_width - 5
    local text_y = y - 12
    local outline_color_text = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.0, 0.0, 0.0, 1.0))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x - 1, text_y - 1), outline_color_text, tostring(current_armor))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x + 1, text_y - 1), outline_color_text, tostring(current_armor))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x - 1, text_y + 1), outline_color_text, tostring(current_armor))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x + 1, text_y + 1), outline_color_text, tostring(current_armor))
    imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(text_x, text_y), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), tostring(current_armor))
end

-- clear nametags
clearTags = function()
    lua_thread.create(function()
        while true do wait(2000)
            if settings.ESP.enabled_nicks[0] and settings.ESP.drawing[0] then
                for k, v in ipairs(getAllChars()) do
                    local _, id = sampGetPlayerIdByCharHandle(v)
                    if _ then
                        local bs = raknetNewBitStream()
                        raknetBitStreamWriteInt16(bs, tonumber(id))
                        raknetBitStreamWriteInt8(bs, 0)
                        raknetEmulRpcReceiveBitStream(80, bs)
                        raknetDeleteBitStream(bs)
                    end
                end
            else
                for k, v in ipairs(getAllChars()) do
                    local _, id = sampGetPlayerIdByCharHandle(v)
                    if _ then
                        local bs = raknetNewBitStream()
                        raknetBitStreamWriteInt16(bs, tonumber(id))
                        raknetBitStreamWriteInt8(bs, 1)
                        raknetEmulRpcReceiveBitStream(80, bs)
                        raknetDeleteBitStream(bs)
                    end
                end
            end
        end
    end)
end

-- convert color to ImVec4
function get_player_color_imvec4(id)
  local color = sampGetPlayerColor(id)
  local opaquee_color = bit.bor(bit.band(color, 0xFFFFFF), 0xFF000000)

  local r = bit.band(bit.rshift(opaquee_color, 16), 0xFF)
  local g = bit.band(bit.rshift(opaquee_color, 8), 0xFF)
  local b = bit.band(opaquee_color, 0xFF)
  local a = bit.band(bit.rshift(opaquee_color, 24), 0xFF)

  local r_float = r / 255.0
  local g_float = g / 255.0
  local b_float = b / 255.0
  local a_float = a / 255.0

  return imgui.ImVec4(r_float, g_float, b_float, a_float)
end

-- for filled box --
function get_player_color_imvec4_2(id)
    local color = sampGetPlayerColor(id)
    local opaquee_color = bit.bor(bit.band(color, 0xFFFFFF), 0xFF000000)

    local r = bit.band(bit.rshift(opaquee_color, 16), 0xFF)
    local g = bit.band(bit.rshift(opaquee_color, 8), 0xFF)
    local b = bit.band(opaquee_color, 0xFF)

    local r_float = r / 255.0
    local g_float = g / 255.0
    local b_float = b / 255.0

  return imgui.ImVec4(r_float, g_float, b_float, settings.ESP.fillboxvalue[0])
end

-- no fall
function antifall()
    lua_thread.create(function()
        while settings.ped.nofall[0] do -- no falltaskPlayAnim(playerPed HANDSUP PED 4.0 0 0 0 0 4)
            wait(0)
            if isCharPlayingAnim(playerPed, 'KO_SKID_BACK') or isCharPlayingAnim(playerPed, 'FALL_COLLAPSE') then
                clearCharTasksImmediately(playerPed)
            end
        end
    end)
end

-- anti car skill
function events.onSendVehicleDamaged()
	if settings.car.anticarskill[0] then
		return false
	end
end

-- setskill
function events.onSetPlayerSkillLevel(playerId, skill, level)
    if settings.ped.setskills[0] then
        return false
    end
end

-- Battery Percentage
function getBatteryPercentage()
    if success or success2 then
    local batteryManager = jniUtil.GetSystemService(jniUtil.SystemService.BATTERY_SERVICE)

    if batteryManager == nil then
        sampAddChatMessage("[Miku] Ошибка: не удалось получить сервис BatteryManager", -1)
        sampAddChatMessage("[Miku] Процент заряда в Watermark не будет отображаться корректно", -1)
        return -1
    end

    local percentage = -1
    local param = ffi.new("jint", BATTERY_PROPERTY_CAPACITY)
    local ok, result = pcall(jniUtil.CallIntMethod, batteryManager, "getIntProperty", "(I)I", param)

    if ok then
        percentage = result
    else
        sampAddChatMessage("[Miku] Ошибка вызова getIntProperty(BATTERY_PROPERTY_CAPACITY): " .. tostring(result), -1)
        percentage = -1
    end

    env.DeleteLocalRef(batteryManager)
    return percentage
    end
end