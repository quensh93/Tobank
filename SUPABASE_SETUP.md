# Supabase Configuration Guide

## The Problem

You were setting environment variables in PowerShell like this:
```powershell
$env:SUPABASE_URL="https://yjhedjtbtqnxudxgodhc.supabase.co"
$env:SUPABASE_ANON_KEY="your_key"
```

However, these are **runtime** environment variables. The code uses `String.fromEnvironment()` which reads **compile-time** constants, not runtime environment variables.

## The Solution

Supabase credentials must be passed as **compile-time** flags using `--dart-define` when running Flutter.

### Quick Start

Use the provided PowerShell script:
```powershell
.\run_with_supabase.ps1
```

### Manual Run

If you prefer to run manually:
```powershell
flutter run `
  --dart-define=SUPABASE_URL=https://yjhedjtbtqnxudxgodhc.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

## How It Works

1. **Enable Supabase in Debug Panel**: 
   - Open the debug panel
   - Go to Settings tab
   - Toggle "Use Supabase" switch ON

2. **Run with Credentials**:
   - Stop your current Flutter app
   - Run using `.\run_with_supabase.ps1`
   - The app will now use Supabase instead of mock data

3. **Verify Connection**:
   - Check the Logs tab in the debug panel
   - You should see messages like:
     - `🔧 API Config - Supabase enabled: true`
     - `🔧 API Config - Env URL: SET`
     - `🔧 API Config - Env Key: SET`
     - `✅ Using Supabase API with environment credentials`

## Important Notes

- The Supabase switch in the debug panel only **enables/disables** Supabase mode
- The actual credentials come from the `--dart-define` flags
- If you enable Supabase but don't provide credentials, it will fall back to Mock API with a warning
- You must restart the app after changing the `--dart-define` flags

## For Production Builds

For production builds, you would include these in your build command:
```powershell
flutter build apk --release `
  --dart-define=SUPABASE_URL=https://yjhedjtbtqnxudxgodhc.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

## Troubleshooting

**Problem**: Supabase switch is ON but still using Mock API

**Solution**: 
1. Check the Logs tab for warnings
2. Make sure you're running with `.\run_with_supabase.ps1`
3. Verify the credentials in the script are correct

**Problem**: Can't see Supabase logs

**Solution**:
1. Open Debug Panel → Logs tab
2. Look for messages starting with `🔧 API Config`
3. If you see "NOT SET" for URL or Key, the credentials weren't passed correctly
