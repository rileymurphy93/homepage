# Set the homepage URL
$homepage = "http://10.100.1.11:5555/learn/main.jsp"

# Path to the prefs.js file of Firefox
$prefsPath = "$env:APPDATA\Mozilla\Firefox\Profiles\*.default-release\prefs.js"

# Replace the homepage URL in prefs.js

if (Get-Content $prefsPath -Raw -ErrorAction -SilentlyContinue -ea 0 -contains "browser.startup.homepage" )
{
(Get-Content $prefsPath) | ForEach-Object {
    $_ -replace 'user_pref\("browser.startup.homepage", ".*"\);', "user_pref(""browser.startup.homepage"", ""$homepage"");"
} | Set-Content $prefsPath
}

else {
   Add-Content -Path $prefsPath -Value "user_pref("browser.startup.homepage", "http://10.100.1.11:5555/learn/main.jsp");" -Encoding UTF8
}