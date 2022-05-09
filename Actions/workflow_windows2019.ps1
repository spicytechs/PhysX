

function CL_SETUP
{
  echo "CL_SETUP ..."
   
  $VSWHERE="C:\ProgramData\Chocolatey\bin\vswhere.exe"

  $VSTOOLS = &($VSWHERE) -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
  Write-Output "[VSTOOLS]:'$VSTOOLS' "

  if($VSTOOLS) 
  {
    $VSTOOLS = join-path $VSTOOLS 'Common7\Tools\vsdevcmd.bat'
    if (test-path $VSTOOLS) 
    {
      cmd /s /c " ""$VSTOOLS""  -arch=x64 -host_arch=x64 $args && set" | where { $_ -match '(\w+)=(.*)' } | 
      foreach{$null = new-item -force -path "Env:\$($Matches[1])" -value $Matches[2] }
    }
  }
  
  cl.exe 
  cmake.exe --version 
  ninja.exe --version 
}


function COMPILATION
{
  Write-Host "[COMPILATION] ... " #-NoNewline
  
  #Get-Location 
  ls 
  pwd
  
  
  #Get-ChildItem 
  
  Set-Location -Path physx 
  
  .\generate_projects.bat vc16win64 
  
  Set-Location -Path compiler\vc16win64 
  
  
  ninja.exe -j4 install 
  
  cd ..
  cd .. 

  ls install\vc15win64\PhysX 
  
  tar -cvf PhysX.tar install\vc15win64\PhysX
  
  ls PhysX.tar
  
  Write-Host "[COMPILATION] OK!"
}

CL_SETUP
COMPILATION 

