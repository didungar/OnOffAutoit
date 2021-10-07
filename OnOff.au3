#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

$sFilePath = @TempDir & "\OnOff.txt";

Local $isOn = false;
Local $debug = false;

; On analyse :
If ( FileExists($sFilePath) ) Then
   Local $hFileOpen = FileOpen($sFilePath, $FO_READ);
   Local $sActualContent = FileRead($hFileOpen)
   If(StringInStr($sActualContent, "On")) Then
	  $isOn = true;
   EndIf
   If ( $debug ) Then
	  MsgBox(0, $sFilePath, $sActualContent)
   EndIf
   FileClose($hFileOpen)
Else
   MsgBox(0, "", "File not-found")
EndIf

; On inverse :
Local $sNewContent = "On";
If( $isOn ) Then
   $sNewContent = "Off"; On => Off
Else
   $sNewContent = "On"; Off => On
EndIf

; On sauvegarde :
Local $hFileOpen = FileOpen($sFilePath, $FO_CREATEPATH  + $FO_OVERWRITE);
 If $hFileOpen = -1 Then
	 MsgBox($MB_SYSTEMMODAL, "", "Une erreur est survenue pendant la lecture du fichier.")
	 Return False
 EndIf
FileWrite($hFileOpen, $sNewContent); Off => On
FileClose($hFileOpen)