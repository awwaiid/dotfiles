--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Layout.Tabbed
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Maximize
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizeScreen
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger
import XMonad.Actions.CycleWS
import XMonad.Hooks.UrgencyHook
import XMonad.Actions.GroupNavigation
import XMonad.Config.Gnome
import XMonad.Util.Paste


-- Help fix fullscreen apps
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.MouseResizableTile


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal           = "~/bin/terminal"

myFocusFollowsMouse  = True      -- Whether focus follows the mouse pointer.
myBorderWidth        = 1         -- Width of the window border in pixels.
myModMask            = mod4Mask  -- This is left-alt usually
myNumlockMask        = 0         -- Treat numlock status separately (mod2Mask otherwise)
myNormalBorderColor  = "#000000" -- was "#0B3B0B"
myFocusedBorderColor = "#666666" -- was "#58FA58"

-- I give my workspaces boring names
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- These are the one-by-one keybindings
    [
      -- launch a terminal
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),

      -- launch dmenu
      ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\""),

      -- launch gmrunjust a simple one-off run dialog
      ((modm .|. shiftMask, xK_p     ), spawn "gmrun"),

      -- lock screen
      ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command -l"),
      -- ((modm .|. shiftMask, xK_l     ), spawn "gnome-screensaver-command -l"),

      -- Experimental!
      ((modm, xK_F5     ), spawn "reload-browser"),

      -- Experimental!
      ((modm, xK_i     ), pasteSelection),

      -- close focused window
      ((modm .|. shiftMask, xK_c     ), kill),

       -- Rotate through the available layout algorithms
      ((modm,               xK_space ), sendMessage NextLayout),

      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf),

      -- Resize viewed windows to the correct size
      -- What is this one for?
      ((modm,               xK_n     ), refresh),

      -- History based alt-tab
      ((modm,               xK_Tab   ), nextMatch History (return True)),

      -- Move focus to the next window (standard alt-tab),
      --  ((modm,               xK_Tab   ), windows W.focusDown),
      
      -- Move focus to the previous window (standard shift-alt-tab),
      --  ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp),

      -- Move focus to the next window
      ((modm,               xK_j     ), windows W.focusDown),
      --  ((modm,               xK_j     ), focusDown),

      -- Move focus to the previous window
      ((modm,               xK_k     ), windows W.focusUp  ),
      --  ((modm,               xK_k     ), focusUp  ),

      -- Move focus to the master window
      ((modm,               xK_m     ), windows W.focusMaster  ),

      -- Swap the focused window and the master window
      --  ((modm,               xK_Return), windows W.swapMaster),

      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ),

      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ),

      -- Shrink the master area
      ((modm,               xK_h     ), sendMessage Shrink),

      -- Expand the master area
      ((modm,               xK_l     ), sendMessage Expand),

      -- Push window back into tiling
      ((modm,               xK_t     ), withFocused $ windows . W.sink),

      -- Increment the number of windows in the master area
      ((modm              , xK_comma ), sendMessage (IncMasterN 1)),

      -- Deincrement the number of windows in the master area
      ((modm              , xK_period), sendMessage (IncMasterN (-1))),

      -- Quit xmonad
      ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)),

      -- Restart xmonad
      ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart"),

      -- Focus on the urgent window
      ((modm              , xK_equal), focusUrgent),

      -- Temporarily maximize
      ((modm, xK_Return), sendMessage ToggleLayout),

      -- Shuffle windows leftright, up, and down
      -- no workey?
      --  ((modm .|. controlMask, xK_h), sendMessage $ pullGroup L),
      --  ((modm .|. controlMask, xK_l), sendMessage $ pullGroup R),
      --  ((modm .|. controlMask, xK_k), sendMessage $ pullGroup U),
      --  ((modm .|. controlMask, xK_j), sendMessage $ pullGroup D),

      -- Navigate focus using arrow keys
      ((modm,                 xK_Right), sendMessage $ Go R),
      ((modm,                 xK_Left ), sendMessage $ Go L),
      ((modm,                 xK_Up   ), sendMessage $ Go U),
      ((modm,                 xK_Down ), sendMessage $ Go D),

      -- Swap windows using arrow keys
      -- no workey?
      ((modm .|. shiftMask, xK_Right), sendMessage $ Swap R),
      ((modm .|. shiftMask, xK_Left ), sendMessage $ Swap L),
      ((modm .|. shiftMask, xK_Up   ), sendMessage $ Swap U),
      ((modm .|. shiftMask, xK_Down ), sendMessage $ Swap D),

      -- Navigate workspaces using arrow keys
      -- Uses multiple-of-3 rule for up/down
      ((modm .|. controlMask,  xK_Left),  prevWS),
      ((modm .|. controlMask,  xK_Right),  nextWS),
      ((modm .|. controlMask,  xK_Up),  prevWS >> prevWS >> prevWS),
      ((modm .|. controlMask,  xK_Down),  nextWS >> nextWS >> nextWS),


      -- Collapse/expand all windows into a single tabbed sub-window
      ((modm .|. controlMask, xK_m), withFocused (sendMessage . MergeAll)),
      ((modm .|. controlMask, xK_u), withFocused (sendMessage . UnMerge)),

      -- what were these for again? hmmm...
      ((modm .|. controlMask, xK_period), onGroup W.focusUp'),
      ((modm .|. controlMask, xK_comma), onGroup W.focusDown')
    
    ] ++ [

      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      ((m .|. modm, k), windows $ f i)
          | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++ [

      -- Same, but also switch to workspace N with symbol keys
      ((m .|. modm, k), windows $ f i)
          | (i, k) <- zip myWorkspaces symbolKeys
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++ [

      -- Same, but with keypad keypad [1..9], switch to spacial workspace
      ((m, k), windows $ f i)
          | (i, k) <- zip myWorkspaces numPadKeys
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++ [

      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
          | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]

    ] ++ [

      -- mod- keypad {/,*,-}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift- keypad {/,*,-}, Move client to screen 1, 2, or 3
      ((m, key), screenWorkspace sc >>= flip whenJust (windows . f))
          | (key, sc) <- zip [xK_KP_Subtract, xK_KP_Multiply, xK_KP_Divide] [0..]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

-- Non-numeric num pad keys, sorted by number 
numPadKeys = [
    xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up,   -- 7, 8, 9
    xK_KP_Left, xK_KP_Begin, xK_KP_Right,     -- 4, 5, 6
    xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down, -- 1, 2, 3
    xK_KP_Insert                              -- 0
  ]

-- symbol keys, sorted by order of switching
symbolKeys = [
    xK_exclam, xK_at, xK_numbersign,
    xK_dollar, xK_percent, xK_asciicircum,
    xK_ampersand,  xK_asterisk,  xK_parenleft,
    xK_parenright
  ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout =
  windowNavigation
  $ windowArrange
  $ layoutHintsToCenter
  $ toggleLayouts (noBorders $ Full)
  --  $ noBorders
  $ smartBorders
  $ tiled
    -- ||| (noBorders $ simpleTabbed)
    ||| simpleTabbed
    ||| mirror_tiled
    --  ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled  =
       noBorders
       -- $ subTabbed
       $ boringWindows
       $ spacing 1
       $ mouseResizableTile

     mirror_tiled  =
       noBorders
       -- $ subTabbed
       $ boringWindows
       $ spacing 1
       $ mouseResizableTileMirrored

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Fullscreen floats a window that is supposed to be fullscreen,
-- like presentations in OpenOffice.org or fullscreen mode in
-- Flash. Used in myManageHook, and requires XMonad.Hooks.ManageHelpers
fullScreenFloats = composeOne [ isFullscreen -?> doFullFloat ]

-- These are run when matching windows are first created
applicationHooks = composeAll [
    -- className =? "MPlayer"        --> doFloat,
    -- className =? "Gimp"           --> doFloat,
    resource  =? "desktop_window" --> doIgnore,
    resource  =? "kdesktop"       --> doIgnore,
    resource  =? "xfce4-notifyd"  --> doIgnore
    -- className =? "Ardour"         --> doShift "8",
  ]

myManageHook = fullScreenFloats <+> applicationHooks


------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = historyHook

myUrgencyHook = SpawnUrgencyHook "ledson " 

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return ()
myStartupHook = gnomeRegister

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad
  $ withUrgencyHookC
      myUrgencyHook
      -- FocusHook
      urgencyConfig {
        suppressWhen = XMonad.Hooks.UrgencyHook.Focused,
        remindWhen = Every 5
      }
  $ defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    --numberlockMask     = myNumlockMask,
    --numlockMask        = myNumlockMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
  }

