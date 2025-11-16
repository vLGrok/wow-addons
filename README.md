# WoW AddOns

A collection of World of Warcraft AddOns.

## MoP Helper

A simple helper addon for **Mists of Pandaria Classic** (WoW Classic expansion).

### Features

- Welcome message on login
- Player coordinate display toggle
- Slash command interface
- Persistent settings across sessions

### Installation

1. Download or clone this repository
2. Copy the `MoPHelper` folder to your World of Warcraft `Interface/AddOns/` directory
3. Restart WoW or reload UI (`/reload`)
4. The addon will be loaded automatically

### Usage

The addon supports the following slash commands:

- `/mophelper` or `/moph` - Show help menu
- `/mophelper welcome` - Toggle welcome message on login
- `/mophelper coords` - Toggle coordinate display
- `/mophelper version` - Show addon version

### Compatibility

- **Interface Version:** 50400 (Mists of Pandaria Classic 5.4.0)
- **WoW Version:** World of Warcraft Classic - Mists of Pandaria

### Technical Details

The addon consists of:
- `MoPHelper.toc` - AddOn manifest file
- `MoPHelper.lua` - Main addon logic

Settings are saved in the `MoPHelperDB` saved variable and persist across sessions.

## License

See [LICENSE](LICENSE) file for details.