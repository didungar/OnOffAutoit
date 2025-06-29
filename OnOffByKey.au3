#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Global Const $g_sTogglePath = @TempDir & "\OnOff.txt"
Global Const $g_sKeyPath = @ScriptDir & "\OnOff.key.txt"

Global $g_sHotKey = '{PAUSE}' ; par défaut
Global $g_bIsOn = False

; === Chargement ou création du fichier de touche ===
If Not FileExists($g_sKeyPath) Then
	FileWrite($g_sKeyPath, "") ; crée un fichier vide
Else
	Local $key = StringStripWS(FileRead($g_sKeyPath), $STR_STRIPALL)
		If $key <> "" Then
		Switch $key
			Case "{DELETE}"
				$g_sHotKey = '{DELETE}'
			Case "{SUPPR}"
				$g_sHotKey = '{DELETE}'
			Case Else
				$g_sHotKey = $key
		EndSwitch
	EndIf
EndIf

; === Lecture de l’état actuel ===
If FileExists($g_sTogglePath) Then
	Local $content = FileRead($g_sTogglePath)
	If StringInStr($content, "On") Then
		$g_bIsOn = True
	EndIf
EndIf

; === Fonction de bascule ===
Func _ToggleOnOff()
	SetOnOff(Not $g_bIsOn)
EndFunc

; === Association de la touche ===
HotKeySet($g_sHotKey, "_ToggleOnOff")

; Fonction pour forcer un état
Func SetOnOff($bState)
	$g_bIsOn = $bState
	Local $status = $g_bIsOn ? "On" : "Off"
	Local $file = FileOpen($g_sTogglePath, $FO_OVERWRITE + $FO_CREATEPATH)
	If $file <> -1 Then
		FileWrite($file, $status)
		FileClose($file)
	EndIf
EndFunc
