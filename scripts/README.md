# SuperScribe Addon Deployment Scripts

This directory contains scripts to automatically deploy the SuperScribe addon to your World of Warcraft Classic AddOns directory.

## Available Scripts

### Windows Users

#### Option 1: PowerShell Script (Recommended)
```powershell
.\deploy.ps1
```

**Advanced Usage:**
```powershell
# Deploy to custom WoW path
.\deploy.ps1 -WowPath "C:\Games\WoW\_classic_\Interface\AddOns"

# Force overwrite without prompting
.\deploy.ps1 -Force

# Verbose output showing all deployed files
.\deploy.ps1 -Verbose

# Combine options
.\deploy.ps1 -WowPath "C:\Games\WoW\_classic_\Interface\AddOns" -Force -Verbose
```

#### Option 2: Batch Script (Simple)
```batch
deploy.bat
```
Double-click or run from command prompt. This is a simple wrapper for the PowerShell script.

### Unix/Linux/Mac Users

```bash
# Default path (Wine)
./deploy.sh

# Custom WoW path
./deploy.sh "/path/to/wow/_classic_/Interface/AddOns"

# Force overwrite
./deploy.sh --force

# Verbose output
./deploy.sh --verbose

# Get help
./deploy.sh --help
```

## Default Installation Paths

The scripts use these default WoW Classic AddOns directory paths:

- **Windows**: `D:\Blizzard\World of Warcraft\_classic_\Interface\AddOns`
- **Unix/Linux/Mac (Wine)**: `$HOME/.wine/drive_c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns`

## How It Works

1. **Validates Paths**: Checks that both source addon and target WoW directories exist
2. **Backup Check**: Warns if the addon already exists and asks for confirmation (unless `--force` is used)
3. **Clean Deploy**: Removes any existing version and copies the fresh addon files
4. **Verification**: Shows deployment status and next steps

## After Deployment

1. Launch World of Warcraft Classic
2. Type `/reload` in-game to reload your UI
3. Use `/ss` to open SuperScribe or look for the minimap button

## Troubleshooting

### Common Issues

**"Source addon path not found"**
- Ensure you're running the script from the `scripts` directory
- Check that the SuperScribe addon exists in `../AddOns/SuperScribe`

**"WoW AddOns directory not found"**
- Verify your WoW Classic installation path
- Use the `-WowPath` parameter to specify the correct path

**"Access denied" or Permission errors**
- Run PowerShell as Administrator (Windows)
- Ensure you have write permissions to the WoW directory

### Custom WoW Installation Paths

If your WoW installation is not in the default location, specify the full path to your AddOns directory:

**Windows Examples:**
```powershell
.\deploy.ps1 -WowPath "C:\Program Files (x86)\World of Warcraft\_classic_\Interface\AddOns"
.\deploy.ps1 -WowPath "C:\Games\WoW\_classic_\Interface\AddOns"
```

**Unix/Linux/Mac Examples:**
```bash
./deploy.sh "/Applications/World of Warcraft/_classic_/Interface/AddOns"
./deploy.sh "/home/user/Games/wow/_classic_/Interface/AddOns"
```

## Development Workflow

For addon development, you can use these scripts to quickly test changes:

1. Make changes to the addon code
2. Run the deployment script
3. Type `/reload` in WoW
4. Test your changes

The scripts are designed to be fast and safe for repeated use during development.

## Script Features

- ✅ Path validation and error checking
- ✅ Backup and overwrite protection
- ✅ Cross-platform support (Windows, Unix, Linux, Mac)
- ✅ Verbose output option
- ✅ Force deployment option
- ✅ Helpful error messages and guidance
- ✅ Dependency reminders