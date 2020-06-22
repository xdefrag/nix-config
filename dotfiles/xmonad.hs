import XMonad
import XMonad.Config.Kde

baseConfig = kdeConfig

main = xmonad baseConfig
       { terminal    = "alacritty"
       , modMask     = mod4Mask
       }
