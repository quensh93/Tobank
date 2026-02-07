# Run Flutter app with Supabase configuration
# This script passes Supabase credentials as compile-time constants

$SUPABASE_URL = "https://yjhedjtbtqnxudxgodhc.supabase.co"
$SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlqaGVkanRidHFueHVkeGdvZGhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMzMzIxNjUsImV4cCI6MjA3ODkwODE2NX0.Jh_2TouVA1sEPKwLNC-NqWgOMtEOv3hr3KVoONHZG7o"

Write-Host "🚀 Running Flutter app with Supabase configuration..." -ForegroundColor Cyan
Write-Host "📍 Supabase URL: $SUPABASE_URL" -ForegroundColor Green
Write-Host "🔑 Anon Key: SET" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  If you see 'Invalid API key' error:" -ForegroundColor Yellow
Write-Host "   1. Go to https://supabase.com/dashboard/project/yjhedjtbtqnxudxgodhc" -ForegroundColor Yellow
Write-Host "   2. Navigate to Settings → API" -ForegroundColor Yellow
Write-Host "   3. Copy the 'anon' 'public' key" -ForegroundColor Yellow
Write-Host "   4. Update this script with the correct key" -ForegroundColor Yellow
Write-Host ""

flutter run `
  --dart-define=SUPABASE_URL=$SUPABASE_URL `
  --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
