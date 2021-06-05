# toggle.nvim

Quickly toggle between different sets of values.

## Features

- Customizable sets
- Seek to closest set, like `<C-a>` and `<C-x>`
- Automatic generation of different casing variants
- Fast lookup using lua tables

## Installation
### [packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'ten3roberts/toggle.nvim',
  config = function()
    require'toggle'.setup{}
  end
}
```


### [vim-plug](https://github.com/junegunn/vim-plug)


```vim
Plug 'ten3roberts/toggle.nvim'

lua require'toggle'.setup{}
```

## Usage

```vim
:Toggle
```

or

```lua
require'toggle'.toggle()
```

or using keymapping `gb`

```vim
nmap gb <cmd>lua require'toggle'.toggle()<CR>
```

## Configuration

Configuration is done by passing a table to setup. Variants for `Title`, `UPPER`, and `lower` case will automatically be generated if `variants == true`

Default configuration:

```lua
{
  { 'true', 'false' },
  { 'on', 'off' },
  { 'enable', 'disable' },
  { 'enabled', 'disabled' },
  { 'manual', 'auto' },
  { 'always', 'never' },
  variants = true
}
```
