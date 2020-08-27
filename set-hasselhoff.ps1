Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace HasselhoffSetter
{
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
         RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
		 key.SetValue(@"TileWallpaper", "0");
		 key.SetValue(@"WallpaperStyle", "2") ;
         key.Close();
      }
   }
}
"@

$wallpaper_link = "https://raw.githubusercontent.com/medicalgorithmics/hasselhoff-setter/master/hasselhoff.jpg"
$web_client = New-Object System.Net.WebClient
$save_location = "$env:USERPROFILE\Pictures\hasselhoff.jpg"
$web_client.DownloadFile($wallpaper_link, $save_location)

[HasselhoffSetter.Setter]::SetWallpaper($save_location)
