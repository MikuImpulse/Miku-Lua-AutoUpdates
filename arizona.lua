-- Part of the @osp_x Android Lua library for MonetLoader.
-- Arizona RolePlay API wrapper for MonetLoader. 
-- Work in progress: Basic functionality available, more features coming soon
-- More info: t.me/monetbinder

local ffi = require("ffi")
local env = require("android.jnienv")
local envu = require("android.jnienv-util")
local activity = require("android.jni-raw").activity

local file = getWorkingDirectory() .. "/lib/android/jar/arzapi.jar"

local code, class, cldr = envu.InjectJar(file, "monetloader/ArizonaAPI", "init", "(Lcom/arizona/game/GTASA;)V", activity)
if code ~= 0 then error(class) return end

local M = {
    cldr = ffi.cast('jclass', env.NewGlobalRef(cldr))
}
env.DeleteLocalRef(cldr)

function M.closeCurrentDialog()
    envu.CallStaticVoidMethod(class, "closeCurrentDialog", "()V")
end

function M.createNotification(title, content)
    envu.CallStaticVoidMethod(class, "createNotification", "(Ljava/lang/String;Ljava/lang/String;)V", env.NewStringUTF(title), env.NewStringUTF(content))
end

function M.sampCloseCurrentDialogWith(button, listview, input)
    listview = listview or -1
    input = input or ''
    sampSendDialogResponse(sampGetCurrentDialogId(), button, listview, input)
    M.closeCurrentDialog()
end

function M.sampCloseCurrentDialogWithButton(button)
    M.sampCloseCurrentDialogWith(button)
end

return M