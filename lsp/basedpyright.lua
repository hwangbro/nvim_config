return {
    cmd = {"basedpyright-langserver", "--stdio"},
    filetypes = { "python" },
    settings = {
        basedpyright = {
            analysis = {
                  typeCheckingMode = "standard"
            }
        }
    }
}
