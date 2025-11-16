# SuperScribe - World of Warcraft Classic Addon

A powerful scribing and note-taking addon for World of Warcraft Classic (Mists of Pandaria expansion).

## Features

- **Modern UI Framework**: Built with Ace3 framework for reliability and best practices
- **Note Management**: Create, edit, and organize your in-game notes
- **Minimap Integration**: Convenient minimap button with LibDBIcon support
- **Configuration Panel**: Full settings panel accessible through Blizzard's Interface Options
- **Chat Commands**: Quick access via `/superscribe` or `/ss` commands
- **Saved Variables**: All notes and settings are automatically saved per character/profile
- **Localization Ready**: Built with localization support (currently English only)

## Installation

1. **Download Required Libraries**: This addon requires the Ace3 framework. In a real installation, you would need to download:
   - Ace3 (complete package from CurseForge or WoWInterface)
   - LibDBIcon-1.0

2. **Install the Addon**:
   - Copy the entire `SuperScribe` folder to your `World of Warcraft\_classic_\Interface\AddOns\` directory
   - Ensure the folder structure is: `AddOns\SuperScribe\SuperScribe.toc`

3. **Install Dependencies**:
   - The current implementation includes stub libraries for development
   - For production use, replace the `Libs` folder contents with real Ace3 libraries from:
     - https://www.curseforge.com/wow/addons/ace3
     - https://www.curseforge.com/wow/addons/libdbicon-1-0

## Usage

### Opening SuperScribe
- **Minimap Button**: Left-click the minimap button
- **Chat Command**: Type `/ss` or `/superscribe` 
- **Slash Commands**:
  - `/ss show` - Show the main window
  - `/ss hide` - Hide the main window  
  - `/ss config` - Open configuration panel

### Creating Notes
1. Click the "New Note" button in the left panel
2. Enter a title in the "Note Title" field
3. Write your note content in the large text area
4. Click "Save" to store your note

### Managing Notes
- **View Notes**: Click any note in the left panel to view/edit it
- **Delete Notes**: Select a note and click "Delete Note"
- **Auto-Save**: Notes are saved when you click the Save button

### Configuration
Right-click the minimap button or use `/ss config` to access settings:
- **Minimap Button**: Show/hide and lock the minimap button
- **Font Size**: Adjust text size (8-24)
- **Window Scale**: Scale the main window (0.5x to 2.0x)

## File Structure

```
SuperScribe/
├── SuperScribe.toc          # Addon manifest
├── SuperScribe.lua          # Main addon file
├── Libs/                    # Framework libraries (Ace3, LibDBIcon)
├── Locales/
│   └── enUS.lua            # English localization
└── Core/
    ├── Database.lua        # Data management
    ├── Config.lua          # Configuration system
    └── GUI.lua             # User interface
```

## For Developers

### Architecture
- **Ace3 Framework**: Uses AceAddon-3.0 for addon structure
- **AceGUI**: Creates the user interface with proper widgets
- **AceConfig**: Handles configuration with Blizzard's interface
- **AceDB**: Manages saved variables and profiles
- **LibDBIcon**: Provides minimap button functionality

### Customization
The addon is designed to be easily extensible:
- Add new note categories in `Database.lua`
- Extend the UI in `GUI.lua` 
- Add more configuration options in `Config.lua`
- Support additional languages by adding locale files

### Dependencies
- **Interface Version**: 50400 (WoW Classic Mists of Pandaria)
- **Required Libraries**: Ace3 complete package, LibDBIcon-1.0
- **Optional**: Any additional Ace3 modules for extended functionality

## Compatibility

- **World of Warcraft Classic**: Mists of Pandaria (5.4.x)
- **Interface Version**: 50400
- **Dependencies**: Ace3, LibDBIcon-1.0

## Version History

- **v1.0.0**: Initial release
  - Basic note creation and management
  - Minimap button integration
  - Configuration panel
  - Chat command support

## License

This addon is released under the MIT License. See the LICENSE file in the root directory for details.

## Support

For issues, suggestions, or contributions, please visit the project repository or contact the addon author.

---

**Note**: This is a development skeleton. For production use, replace the stub libraries in the `Libs` folder with the actual Ace3 framework downloaded from official sources.