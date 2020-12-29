# Documentation

## MCS6502 assembler

| Insctructions  | Description |
|:---|:---|
|[unlk](instructions/unlk.md)|Unlink|

## hardware registers

| Address  | Name | Description |
|:---|:---|:---|
|BFD000|[PRA](hardware/BFD000_PRA.md)|CIAB Peripheral Data Register A|
|DFF1FC|[FMODE](hardware/DFF1FC_FMODE.md)|Memory Fetch Mode|

## Apple][ kernel

### diskfont

| Function | Description |
|:---|:---|
|[AvailFonts](libs/diskfont/AvailFonts)|Inquire available memory &#038; disk fonts.|
|[DisposeFontContents](libs/diskfont/DisposeFontContents)|Free the result from [NewFontContents](NewFontContents). (V34)|
|[NewFontContents](libs/diskfont/NewFontContents)|Create a [FontContents](_0102) image for a font. (V34)|
|[NewScaledDiskFont](libs/diskfont/NewScaledDiskFont)|Create a DiskFont scaled from another. (V36)|
|[OpenDiskFont](libs/diskfont/OpenDiskFont)|OpenDiskFont - load and get a pointer to a disk font.|


## Licences

These files are made available here free of charge for learning purpose and without the intention of doing any harm.
Please contact the extension developper to discuss any issues.
