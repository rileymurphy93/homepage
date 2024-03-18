# Set the homepage URL
$homepage = "http://10.100.1.11:5555/learn/main.jsp"

# Path to the prefs.js file of Firefox
$prefsPath = "$env:APPDATA\Mozilla\Firefox\Profiles\*.default-release\prefs.js"

#Get-Content $prefsPath

if (
Select-String $prefsPath -Pattern '"browser.startup.homepage",'){
    (Get-Content $prefsPath) | ForEach-Object {
        $_ -replace 'user_pref\("browser.startup.homepage", ".*"\);', "user_pref(""browser.startup.homepage"", ""$homepage"");" 
    } | Out-File $prefsPath
}
Else {
    Add-Content -Path $prefsPath -Value 'user_pref("browser.startup.homepage", "http://10.100.1.11:5555/learn/main.jsp");' -Encoding UTF8
}
