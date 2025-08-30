![image](./assets/tardis.webp)

Tardis allows you to travel in time (git history) scrolling through each
revision of your current file.

Inspired by
[git-timemachine](https://github.com/emacsmirror/git-timemachine) which
I used extensively when I was using emacs.

# Installation

Like with any other

``` lua
{
    'fredehoey/tardis.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
}
```

The default options are

``` lua
require('tardis-nvim').setup {
    keymap = {
        ["next"] = '<C-j>',             -- next entry in log (older)
        ["prev"] = '<C-k>',             -- previous entry in log (newer)
        ["quit"] = 'q',                 -- quit all
        ["revision_message"] = '<C-m>', -- show revision message for current revision
        ["commit"] = '<C-g>',           -- replace contents of origin buffer with contents of tardis buffer
    },
    settings = {
        initial_revisions = 10,         -- initial revisions to create buffers for
        max_revisions = 256,            -- max number of revisions to load
        show_commit_index = false,      -- append [index|total] to buffer names when browsing revisions
    },
}
```

# Usage

Using tardis is pretty simple

    :Tardis <adapter>

This puts you into a new buffer where you can use the keymaps, like
described above, to navigate the revisions of the currently open file

List of currently supported adapters:

-   git

# Known issues

See ![issues](https://github.com/FredeHoey/tardis.nvim/issues)

# Contributing

Go ahead :)
