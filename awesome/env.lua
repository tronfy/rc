return {
    MOD = "Mod4",
    ALT = "Mod1",

    TERM    = os.getenv("TERM") or "alacritty",
    EDITOR  = os.getenv("EDITOR") or "nano",

    HOME = os.getenv("HOME") .. "/",
}
