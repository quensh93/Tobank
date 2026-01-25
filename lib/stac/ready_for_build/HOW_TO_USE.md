# How to Use ready_for_build Folder

## Quick Start

1. **Copy your Dart file** to this folder:
   ```bash
   # Example: Building promissory_intro.dart
   cp lib/stac/tobank/flows/promissory/dart/promissory_intro.dart lib/stac/ready_for_build/
   ```

2. **Run build**:
   ```bash
   stac build
   ```

3. **Find generated JSON** in `lib/stac/.build/`

## Windows Commands

```powershell
# Copy file
Copy-Item lib\stac\tobank\flows\promissory\dart\promissory_intro.dart lib\stac\ready_for_build\

# Or create symlink (requires admin or developer mode)
New-Item -ItemType SymbolicLink -Path lib\stac\ready_for_build\promissory_intro.dart -Target lib\stac\tobank\flows\promissory\dart\promissory_intro.dart
```

## Linux/Mac Commands

```bash
# Copy file
cp lib/stac/tobank/flows/promissory/dart/promissory_intro.dart lib/stac/ready_for_build/

# Or create symlink
ln -s lib/stac/tobank/flows/promissory/dart/promissory_intro.dart lib/stac/ready_for_build/promissory_intro.dart
```

## Important Notes

- **Only files in this folder are built** - `stac build` ignores all other files
- **Maintain folder structure** if your file has relative imports
- **File name doesn't matter** - The `@StacScreen(screenName: '...')` annotation determines the output JSON name
- **After building**, you can remove files from here or keep them for future builds

## Example Workflow

```bash
# 1. Copy file to build folder
cp lib/stac/tobank/flows/promissory/dart/promissory_intro.dart lib/stac/ready_for_build/

# 2. Build
stac build

# 3. Check output
ls lib/stac/.build/promissory_intro.json

# 4. (Optional) Remove from build folder after successful build
rm lib/stac/ready_for_build/promissory_intro.dart
```

