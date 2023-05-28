$srcDir = 'src'
$buildDir = 'build'
$outDir = 'bin'
$execName = 'out.exe'
$compilerFlags = '/c /O1 /GS- /MD'
$linkerFlags = '/SUBSYSTEM:WINDOWS'
$staticLibraries = 'user32.lib'
$platform = 'amd64'

function Invoke-Setup {
    $vsPath = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
    Import-Module (Join-Path $vsPath "Common7\Tools\Microsoft.VisualStudio.DevShell.dll")
    Enter-VsDevShell -Arch $platform -VsInstallPath $vsPath -SkipAutomaticLocation

    if ( -Not(Test-Path $buildDir) ) {
        New-Item -ItemType Directory $buildDir | Out-Null
    }

    if ( -Not(Test-Path $outDir) ) {
        New-Item -ItemType Directory $outDir | Out-Null
    }
}

function Invoke-Build {
    $compilerFlags = $compilerFlags + ' /Fo:' + (Join-Path $buildDir '/')
    $linkerFlags = $linkerFlags + ' /OUT:' + (Join-Path $outDir $execName)
    $srcPath = Join-Path $srcdir '*.c'
    $buildPath = Join-Path $buildDir '*.obj'

    Invoke-Expression ( 'cl.exe ' + $compilerFlags + ' ' +  $srcPath )
    Invoke-Expression ( 'link.exe ' + $buildPath + ' ' + $staticLibraries + ' ' + $linkerFlags )
}

function Invoke-Cleanup {
    if ( Test-Path $buildDir ) {
        Remove-Item $buildDir -Recurse
    }

    if ( Test-Path $outDir ) {
        Remove-Item $outDir -Recurse
    }
}

if  ( $args[0] -eq "clean" ) {
    Invoke-Cleanup
} else {
    Invoke-Setup
    Invoke-Build
}