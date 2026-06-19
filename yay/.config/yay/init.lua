yay.opt.build_dir = os.getenv("HOME") .. "/.cache/yay"

dofile(os.getenv("HOME") .. "/.config/yay/hooks/maintainer_change.lua")
dofile(os.getenv("HOME") .. "/.config/yay/hooks/recently_modified.lua")
