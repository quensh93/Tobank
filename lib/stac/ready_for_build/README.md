# Ready for Build Folder

This folder contains Dart files that are ready to be built to JSON using `stac build`.

## How to Use

1. **Copy or move** the Dart file you want to build into this folder
2. **Maintain the folder structure** if the file has imports from other files
3. **Run `stac build`** - it will only build files in this folder
4. **Generated JSON** will appear in `lib/stac/.build/`

## Example

To build `promissory_intro.dart`:

```bash
# Copy the file to this folder
cp lib/stac/tobank/flows/promissory/dart/promissory_intro.dart lib/stac/ready_for_build/

# Or create a symlink (Windows)
mklink lib\stac\ready_for_build\promissory_intro.dart lib\stac\tobank\flows\promissory\dart\promissory_intro.dart

# Build only files in this folder
stac build
```

## Notes

- Only files with `@StacScreen` annotation will be built
- The folder structure in `ready_for_build` should match the original structure if files have relative imports
- After building, you can remove files from this folder or keep them for future builds

