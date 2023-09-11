import XMonad
import Data.Monoid
import Data.Maybe
import System.IO.Unsafe (unsafePerformIO)
import System.Exit

import XMonad.Layout.Hidden
import qualified XMonad.Layout.IndependentScreens as LIS
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig (additionalKeysP)
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.Loggers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import qualified XMonad.Actions.CycleWS as CWS
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Colours

myTerminal = "kitty"

myFocusFollowsMouse :: Bool 
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth  = 2


-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["dev","www","doc","chat","mus","vid","game","ext1"]
--myWorkspaces    = ["1","2","3","4","5","6","7","8"]



--------------------------------------------------------------------------------

-- Key bindings. Add, modify or remove key bindings here.

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask  = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    --[ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    --, ((modm,               xK_p     ), spawn "dmenu_run")
    
    -- launch rofi
    , ((modm,               xK_d     ), spawn "rofi -show run")

    -- launch rofi drun
    , ((modm .|. shiftMask, xK_d     ), spawn "rofi -show drun")
    
    -- lock screen
    , ((modm .|. mod1Mask,  xK_x     ), spawn "betterlockscreen -l")

    -- close focused window
    , ((modm,               xK_w     ), kill)

    -- hide window
    , ((mod1Mask .|. shiftMask, xK_m), withFocused hideWindow)
    , ((modm     .|. mod1Mask,  xK_m), popOldestHiddenWindow)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_m     ), sendMessage NextLayout)
    , ((modm,               xK_f     ), composeAll [sendMessage ToggleLayout, sendMessage ToggleStruts])

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm .|. shiftMask, xK_c     ), windows W.focusDown)

    -- Move focus to the next window
    --, ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    --, ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    --, ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    --, ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    --Toggle the status bar gap
    --Use this binding with avoidStruts from Hooks.ManageDocks.
    --See also the statusBar function from Hooks.DynamicLog.
    
    --, ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. mod1Mask,  xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "~/.cabal/bin/xmonad --recompile; killall -q xmobar; ~/.cabal/bin/xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    --, ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    -- Next Workspace, Previous Workspace

    [ ((modm              , xK_bracketright), CWS.nextWS)
    , ((modm              , xK_bracketleft) , CWS.prevWS)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    -- ++
    

    -- Custom Script Launches
    [ ((controlMask .|. shiftMask,  xK_k), spawn "$HOME/code_Master/dmscripts/scripts/dm-kill")
    , ((controlMask .|. shiftMask,  xK_e), spawn "$HOME/code_Master/dmscripts/scripts/dm-confedit")
    , ((controlMask .|. shiftMask,  xK_s), spawn "$HOME/code_Master/dmscripts/scripts/dm-scriptlauncher")
    ]

    ++

    
    -- XF86Keys
    [ ((0 , 0x1008ff12), spawn "$HOME/code_Master/scripts/volume-notif.sh mute")
    , ((0 , 0x1008ff11), spawn "$HOME/code_Master/scripts/volume-notif.sh down")
    , ((0 , 0x1008ff13), spawn "$HOME/code_Master/scripts/volume-notif.sh up")
    , ((0 , 0x1008ff03), spawn "$HOME/code_Master/scripts/brightness-notif.sh down")
    , ((0 , 0x1008ff02), spawn "$HOME/code_Master/scripts/brightness-notif.sh up")
    , ((0 , 0x1008ff14), spawn "$HOME/code_Master/scripts/fb2k.sh")
		, ((0 , 0x1008ff17), spawn "playerctl next")
    , ((0 , 0x1008ff16), spawn "playerctl previous")
    , ((0 , 0xff61)    , spawn "flameshot gui")
    ]


--------------------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Layouts:
--myLayout = toggleLayouts (noBorders Full) (avoidStruts $ myBorders $ tiled ||| Mirror tiled ||| Full)
myLayout = hiddenWindows $ toggleLayouts (noBorders Full) (avoidStruts $ myBorders $ tiled ||| Full)
  where -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 3/5

     -- Percent of screen to increment by when resizing panes
     delta   = 5/100
     
     -- Borders
     myBorders = spacingRaw False (Border 3 3 10 10) True (Border 5 5 5 5) True

-- Window rules:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Wine"           --> doFloat
    , className =? "copyq"          --> doFloat
    , title     =? "foobar2000 v2.0" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "discord"        --> doShift "chat"
    , className =? "Wine"           --> doShift "chat"
    , className =? "foobar2000.exe" --> doShift "mus"
    ]

-- Event handling
myEventHook = mempty

-- Status bars and logging
myLogHook = return ()

-- Startup hook
myStartupHook = do
  spawnOnce "picom --experimental-backends &"
  spawnOnce "xrdb ~/.Xresources &"
  spawnOnce "feh --bg-fill --no-fehbg ~/.config/wall.png &"
  spawnOnce "betterlockscreen -u ~/.config/wall.png &"
  spawnOnce "easyeffects --gapplication-service &"
  spawnOnce "dunst &"
  --spawnOnce "exec /usr/bin/trayer --edge top --distance 15 --align right --distancefrom right --SetDockType true --SetPartialStrut true --widthtype request --expand true --transparent true --alpha 0 --tint 000000 --height 29 &"
  spawnOnce "fcitx &"
  spawnOnce "copyq &"
  spawnOnce "python /home/julian/code_Master/Last.fm-Discord-Rich-Presence/main.py"
  spawnOnce "xrandr --setprovideroutputsource 1 0 --setprovideroutputsource 2 0 &"
  spawn "exec ~/.config/xmonad/monitors.sh"

-- # of windows on workspace
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Main Process
main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"
  xmonad $ ewmhFullscreen 
         $ ewmh 
         $ withEasySB (statusBarProp "xmobar" (clickablePP myXmobarPP)) toggleStrutsKey
         $ defaults
    where
      toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
      toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)


defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook defaults <> Hacks.trayerPaddingXmobarEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = xmobarMagenta " <fn=2>\xf054</fn> "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = xmobarWhite . wrap " " "" . xmobarBorder "Bottom" blue    3 . wrap "" "" 
		, ppVisible         = xmobarWhite . wrap " " "" . xmobarBorder "Bottom" yellow  3 . wrap "" ""
    , ppHidden          = xmobarWhite . wrap " " "" . xmobarBorder "Top"    magenta 3 . wrap "" ""   
    , ppHiddenNoWindows = xmobarLowWhite . wrap " " ""
    , ppUrgent          = xmobarRed . wrap (xmobarYellow "!") (xmobarYellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, wins]
		--, ppExtras          = [logTitles formatFocused formatUnfocused]
		, ppExtras          = [windowCount]
    }
  where
    formatFocused   = wrap (xmobarWhite    "[") (xmobarWhite    "]") . xmobarBlue    . ppWindow
    formatUnfocused = wrap (xmobarLowWhite "[") (xmobarLowWhite "]") . xmobarMagenta . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    xmobarBlue, xmobarLowWhite, xmobarMagenta, xmobarRed, xmobarWhite, xmobarYellow :: String -> String
    xmobarMagenta  = xmobarColor magenta  ""
    xmobarBlue     = xmobarColor blue     ""
    xmobarWhite    = xmobarColor white    ""
    xmobarYellow   = xmobarColor yellow   ""
    xmobarRed      = xmobarColor red      ""
    xmobarLowWhite = xmobarColor lowWhite ""

blue, lowWhite, magenta, orange, red, white, yellow :: String
blue     = "#4f97d7"
lowWhite = "#b8b8b8"
magenta  = "#a31db1"
orange   = "#ffa500"
red      = "#f2241f"
white    = "#f8f8f8"
yellow   = "#ebbf83"

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#263238"
myFocusedBorderColor = "#88c0d0"
--myFocusedBorderColor = "#4f97d7"
