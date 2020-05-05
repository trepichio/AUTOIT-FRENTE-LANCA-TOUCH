#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <EditConstants.au3>
#include <WinAPIFiles.au3>

;========= BUILD =====

AutoItSetOption('MouseCoordMode', 0)
AutoItSetOption('SendKeyDelay', 10)
AutoItSetOption('WinTitleMatchMode',2) ;Opt("WinTitleMatchMode", 1) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase

Opt('MustDeclareVars', 1)


TestesFrenteTouch()


; #FUNCTION# ======================================================================================================
; Name...........: TestesFrenteTouch
; Description ...: Launchs the EXE of dropped FrenteTouch and executes the desired test script
; Syntax.........: TestesFrenteTouch()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================

Func TestesFrenteTouch()

	Global $sWndLoginCardapio = '[CLASS:TFRM_Login]'
	Global $sPanelFuncionarios = '[CLASS:TJvScrollBox; INSTANCE:2]'
	Global $sWndMensagemCardapio = '[CLASS:TFRM_Mensagem]'
	Global $sWndPrincipal = '[CLASS:TFRM_Principal]'
	Global $sWndCNPJ = '[CLASS:TFRM_LanDocCliente]'
	Global $handlePrincipal = ''
	Global $hWndLoginCardapio  = ''
	Global $hWndMensagemCardapio = ''
	Global $sWndPergunta = '[CLASS:TFRM_Pergunta]'
	Global $sWndPerguntaImpressoesPendentes = 'Existem impressões remotas pendentes. Deseja visualizar o gerenciador de impressões?'

    ; Create a GUI with various controls.
    Local $hGUI = GUICreate("Teste automatizado de Vendas no Frente Touch", 420, 500, -1, -1, -1, $WS_EX_ACCEPTFILES)

	 Opt("GUICoordMode", 0)

    ; Create a label and set the state as drop accepted.
    Global $idLabel = GUICtrlCreateLabel("Arraste aqui o arquivo EXE do Frente Touch", 10, 10, 400, 40, $WS_BORDER)
    GUICtrlSetState($idLabel, $GUI_DROPACCEPTED)

    ; Create an input and set the state as drop accepted.
	#GUICtrlCreateLabel("Número de vendas:", 10, 30,100)
    #Local $idInputVendas = GUICtrlCreateInput("", -1, -20, 30, 22)
    #GUICtrlSetState($idInputVendas, $GUI_DROPACCEPTED)

	GUICtrlCreateLabel("Intervalo a selecionar/inserir aleatoriamente", -1, 50, 250)
	GUICtrlCreateLabel("de itens:", -1, 20,50)
    Global $idInputProdutos = GUICtrlCreateInput("", 50, 0, 30, 22)

	GUICtrlCreateLabel("de quantidade de produtos:", 50, 0,140)
    Global $idQuantidadeProduto = GUICtrlCreateInput("", 135, 0, 30, 22)


	Global $idCheckBox_Login = GUICtrlCreateCheckbox("Sem login", -235, 30)

	Global $idCheckBox_Delivery = GUICtrlCreateCheckbox("Com Entrega", 110, 1)
	Global $idCheckBox_Guardar = GUICtrlCreateCheckbox("Guardar aleatoriamente?", 100, 0,100)
	GUICtrlSetState($idCheckBox_Guardar,$GUI_DISABLE)

	GUICtrlCreateLabel("Senha:", -210, 30,50)
	Global $idInputPassword = GUICtrlCreateInput("", 40, 0, 50, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))


	Global $cCheckPassword = GUICtrlCreateCheckbox("Mostrar senha", 70, 0, 150, 20)


	; Create the controls
	GUICtrlCreateGroup("Posição do Usuario MBD", -110, 30, 350, 80)
	GUIStartGroup()
	Local $idRadio_11 = GUICtrlCreateRadio("", 50, 20, 20, 20)
	Local $idRadio_12 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_13 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_14 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_15 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_16 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_21 = GUICtrlCreateRadio("", -250, 20, 20, 20)
	Local $idRadio_22 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_23 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_24 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_25 = GUICtrlCreateRadio("", 50, 0, 20, 20)
	Local $idRadio_26 = GUICtrlCreateRadio("", 50, 0, 20, 20)

	Local $idButton_OK = GUICtrlCreateButton("OK", -35, 50, 85, 25)

	GUICtrlCreateLabel("Teste Automatizado criado por João Trepichio - 2019", -250, 150,300)

	Global $aArrayRadios[12] = [$idRadio_11, $idRadio_12, $idRadio_13, $idRadio_14, $idRadio_15, $idRadio_16, $idRadio_21, $idRadio_22, $idRadio_23, $idRadio_24, $idRadio_25, $idRadio_26]

	#11 79, 24
	#12 230, 24
	#13 381, 24
	#14 534, 24
	#15 676, 24
	#16 828, 24

	#21 79, 80
	#22 230, 80
	#23 381, 80
	#24 534, 80
	#25 676, 80
	#26 828, 80


	; Set the defaults (radio buttons clicked, default button, etc)
	GUICtrlSetState($idRadio_11, $GUI_CHECKED)

	; Init our vars that we will use to keep track of radio events
	Local $iRadioVal[2] = [0,0] ; We will assume 0 = first radio button selected


    ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

	;Retrieve the ASCII value of the default password char
	Global $sDefaultPassChar = GUICtrlSendMsg($idInputPassword, $EM_GETPASSWORDCHAR, 0, 0)

	Global $aInputs[2] = [$idInputPassword, $cCheckPassword]

	Global $iPID = 0
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_DROPPED
                ; If the value of @GUI_DropId is $idLabel, then set the label of the dragged file.
                If @GUI_DropId = $idLabel Then GUICtrlSetData($idLabel, @GUI_DragFile)

			Case $cCheckPassword

				If GUICtrlRead($cCheckPassword) = $GUI_CHECKED Then
					GUICtrlSendMsg($idInputPassword, $EM_SETPASSWORDCHAR, 0, 0)
					GUICtrlSetData($cCheckPassword, "Ocultar senha")
				Else
					GUICtrlSendMsg($idInputPassword, $EM_SETPASSWORDCHAR, $sDefaultPassChar, 0)
					GUICtrlSetData($cCheckPassword, "Mostrar senha")
				EndIf

				GUICtrlSetState($idInputPassword, $GUI_FOCUS)

			Case $idCheckBox_Login
				If GUICtrlRead($idCheckBox_Login) = $GUI_CHECKED Then
					_Action($aArrayRadios, "OFF")
					_Action($aInputs, "OFF")
					GUICtrlSetData($idInputPassword,'')
				Else
					_Action($aArrayRadios, "ON")
					_Action($aInputs, "ON")
				EndIf

			Case $idCheckBox_Delivery
				If GUICtrlRead($idCheckBox_Delivery) = $GUI_CHECKED Then
					Local $aDeliveryInputs[1] = [$idCheckBox_Guardar]
					_Action($aDeliveryInputs, "ON")
				Else
					_Action($aDeliveryInputs, "OFF")
				EndIf

			Case $idRadio_11
				$iRadioVal[0] = 0
				$iRadioVal[1] = 1

			Case $idRadio_12
				$iRadioVal[0] = 1
				$iRadioVal[1] = 0

			Case $idRadio_13
				$iRadioVal[0] = 2
				$iRadioVal[1] = 0

			Case $idRadio_14
				$iRadioVal[0] = 3
				$iRadioVal[1] = 0

			Case $idRadio_15
				$iRadioVal[0] = 4
				$iRadioVal[1] = 0

			Case $idRadio_16
				$iRadioVal[0] = 5
				$iRadioVal[1] = 0

			Case $idRadio_21
				$iRadioVal[0] = 0
				$iRadioVal[1] = 1

			Case $idRadio_22
				$iRadioVal[0] = 1
				$iRadioVal[1] = 1

			Case $idRadio_23
				$iRadioVal[0] = 2
				$iRadioVal[1] = 1

			Case $idRadio_24
				$iRadioVal[0] = 3
				$iRadioVal[1] = 1

			Case $idRadio_25
				$iRadioVal[0] = 4
				$iRadioVal[1] = 1

			Case $idRadio_26
				$iRadioVal[0] = 5
				$iRadioVal[1] = 1

			Case $idButton_OK

				ConsoleWrite("idLabel: " & $idLabel & @CRLF)
				ConsoleWrite("File dropped: " & GUICtrlRead($idLabel) & @CRLF)
				ConsoleWrite("Directory:" & GetDir(GUICtrlRead($idLabel)) & @CRLF)
				If (GUICtrlRead($idLabel) <> 'Arraste aqui o arquivo EXE do Frente Touch') Then
					ConsoleWrite("Run program " & GUICtrlRead($idLabel) & @CRLF)
					$iPID = Run(GUICtrlRead($idLabel), GetDir(GUICtrlRead($idLabel)))
					OKButton($iRadioVal[0],$iRadioVal[1])
				ElseIf ProcessExists("FrenteTouch.exe") Then
					WinActivate('Frente-Touch')
					Opt('MouseCoordMode', 2)
					OKButton($iRadioVal[0],$iRadioVal[1])
				Else
					MsgBox($MB_OK,'ALERTA','Não há nenhuma instância do executável rodando no momento.' & @CRLF)
					ContinueLoop
				EndIf

			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

  ; Delete the previous GUI and all controls.
  GUIDelete($hGUI)

	; Close the PROGRAM process using the PID returned by Run.
  If $iPID Then ProcessClose($iPID)
EndFunc   ;==> TesteFrenteTouch


Func OKButton($x,$y)
    ; Note: At this point @GUI_CtrlId would equal $idButton_OK,
    ; and @GUI_WinHandle would equal $hMainGUI

	#With login process
	If GUICtrlRead($idCheckBox_Login) <> $GUI_CHECKED Then
		#And with dropped file wait for a few moments loading program before start login task
		If (GUICtrlRead($idLabel) <> 'Arraste aqui o arquivo EXE do Frente Touch') Then Sleep(5000)
		LoginFrenteTouch($idLabel, $x,$y)
	Else
		#Without login process wait for a few moments loading program before testing task giving time to user do login in case WinWaitNotActive doesn't work
		If (GUICtrlRead($idLabel) <> 'Arraste aqui o arquivo EXE do Frente Touch') Then Sleep(7000)
		#try to detect windows and wait for login be closed (not actived actually)
		WinWaitNotActive($sWndLoginCardapio)
		WinWaitNotActive($sWndMensagemCardapio)
	EndIf


	While 1
		If GUICtrlRead($idCheckBox_Delivery) = $GUI_CHECKED Then
			Local $iRandom = Random(1,5,1)
			ConsoleWrite("random: " & $iRandom & @CRLF)
			If ($iRandom = 2) Then TesteFrenteTouch_Entrega()
		EndIf
		efetuarVenda()
	WEnd

EndFunc   ;==>OKButton


Func CLOSEButton()
    ; Note: At this point @GUI_CtrlId would equal $GUI_EVENT_CLOSE,
    ; and @GUI_WinHandle would equal $hMainGUI
    Exit
EndFunc   ;==>CLOSEButton





; #FUNCTION# ======================================================================================================
; Name...........: _Action
; Description ...: Enable/Disable all controls
; Syntax.........: _Action($aArrayOfControls)
; Parameters ....: $aHWnd - Array of Control Handles
; Return values .: None
; Author ........: João Trepichio
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func _Action(ByRef $aHWnd, $sAction)
    Local $sState = $GUI_ENABLE
    If $sAction = "OFF" Then $sState = $GUI_DISABLE
    For $i = 0 To UBound($aHWnd) - 1 ; No need for Step 1 = default
        ConsoleWrite($sAction & " - " & $aHWnd[$i] & @CRLF)
        GUICtrlSetState($aHWnd[$i], $sState)
    Next

EndFunc

; #FUNCTION# ======================================================================================================
; Name...........: GetDir
; Description ...: Returns the directory of the given file path
; Syntax.........: GetDir($sFilePath)
; Parameters ....: $sFilePath - File path
; Return values .: Success - The file directory
;                  Failure - -1, sets @error to:
;                  |1 - $sFilePath is not a string
; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================

Func GetDir($sFilePath)


    If Not IsString($sFilePath) Then
        Return SetError(1, 0, -1)
    EndIf

    Local $FileDir = StringRegExpReplace($sFilePath, "\\[^\\]*$", "")

    Return $FileDir

EndFunc   ;==>GetDir


; #FUNCTION# ======================================================================================================
; Name...........: closeImpressoesRemotasWnd
; Description ...: close window that says 'Existem impressões remotas pendentes. Deseja visualizar o gerenciador de impressões?'
; Syntax.........: closeImpressoesRemotasWnd()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func closeImpressoesRemotasWnd()

	If (WinExists($sWndPergunta, $sWndPerguntaImpressoesPendentes)) Then
		ConsoleWrite("Window Pergunta Impressões Remotas Pendentes opened.")
		ControlClick($sWndPergunta,$sWndPerguntaImpressoesPendentes,'[CLASS:TButton; INSTANCE:1]','primary',1)
	EndIf

EndFunc ;==>closeImpressoesRemotasWnd



; #FUNCTION# ======================================================================================================
; Name...........: TesteFrenteTouch_Entrega
; Description ...: Launch a delivery sale
; Syntax.........: TesteFrenteTouch_Entrega()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================

Func TesteFrenteTouch_Entrega()
	ConsoleWrite("TesteFrenteTouch_Entrega")

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibRegister("closeImpressoesRemotasWnd")


	Local $file = './Clientes_entrega.ini'

	Local $sDeliveryButton = '[CLASS:TJvPanel; INSTANCE:1]'
	Local $iXButton = 263
	Local $iYButton = 32

	Global $sWndDelivery = '[CLASS:TfrmEntrega]'


	Global $sFieldPhone = '[CLASS:TDBEdit; INSTANCE:10]'
	Global $sFieldName = '[CLASS:TDBEdit; INSTANCE:9]'
	Global $sFieldCPF = '[CLASS:TDBEdit; INSTANCE:8]'
	Global $sFieldCEP = '[CLASS:TDBEdit; INSTANCE:7]'
	Global $sFieldEndereco = '[CLASS:TDBEdit; INSTANCE:6]'
	Global $sFieldNumero = '[CLASS:TDBEdit; INSTANCE:5]'
	Global $sFieldBairro = '[CLASS:TDBEdit; INSTANCE:4]'
	Global $sFieldCidade = '[CLASS:TDBLookupComboBox; INSTANCE:2]'
	Global $sFieldComplemento = '[CLASS:TDBEdit; INSTANCE:3]'
	Global $sFieldOBS = '[CLASS:TDBMemo; INSTANCE:1]'
	Global $sFieldTaxaFixa = '[CLASS:TDBEdit; INSTANCE:2]'
	Global $sFieldTaxaCliente = '[CLASS:TDBEdit; INSTANCE:2]'
	Global $sFieldEntregador = '[CLASS:TDBLookupComboBox; INSTANCE:1]'

	; Read the INI section labelled 'Cliente X'. This will return a 2 dimensional array.
	#Local $aArray = IniReadSection($sFilePath, "Cliente" & Random(1,8,1))

	; Read the INI file for the value of 'Title' in the section labelled 'General'.
	#Local $sTelefone = IniRead($sFilePath, "Cliente" & Random(1,8,1), "TELEFONE", "")

	ControlClick($sWndPrincipal,'',$sDeliveryButton,'primary',1,$iXButton,$iYButton)
	Sleep(2000)

	#Local $hWndDelivery = WinGetHandle($sWndDelivery,'Entrega')
	Local $hWnd = WinWait($sWndDelivery,'Entrega',5)
	ConsoleWrite("WndDelivery: " & $hWnd & @CRLF)
	WinActivate($hWnd)

	Local $idCliente = "Cliente " & Random(1,8,1)

	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = $file

	; Read the INI file for the value of 'TELEFONE' in the section labelled 'Cliente X'.
	Local $sPhoneNumber = IniRead($sFilePath, $idCliente, "TELEFONE", "")
	ConsoleWrite("PhoneNumber: " & $sPhoneNumber & @CRLF)

	Local $hFieldPhone = ControlGetHandle($hWnd,'',$sFieldPhone)

	ConsoleWrite("Focus in " & $hFieldPhone)

	ControlSetText($sWndDelivery,'',$sFieldPhone,$sPhoneNumber)
	Send('{ENTER}')
	Sleep(500)

	#Local $hFieldName = ControlGetHandle($hWnd,'',$sFieldName)

	If WinActive('[CLASS:TfrmEntregaTelefone]') Then
		Send('{ALTDOWN}s{ALTUP}')
		Sleep(500)
	EndIf


	If (ControlGetText($hWnd, '', $sFieldName) = '') Then
		ConsoleWrite("Field Name is empty.")
		Cadastra_Entrega($idCliente, $file)
	Else
		If Valida_Entrega() Then
			#Finish delivery register/sale
			Send('{ALTDOWN}f{ALTUP}')
		Else
			ConsoleWrite("Cadastro de entrega não preenchido corretamente.")
		EndIf
	EndIf


	; Unregister the function closeImpressoesRemotasWnd() from being called every 250ms.
    AdlibUnRegister("closeImpressoesRemotasWnd")

	Return

EndFunc   ;==>TesteFrenteTouch_Entrega


; #FUNCTION# ======================================================================================================
; Name...........: Valida_Entrega
; Description ...: Validates mandatory fields at Delivery screen
; Syntax.........: Valida_Entrega()
; Parameters ....: None
; Return values .: Boolean
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================

Func Valida_Entrega()

	Local $aArray[6] = [$sFieldPhone, $sFieldName, $sFieldEndereco, $sFieldNumero, $sFieldBairro, $sFieldCidade]

	For $cField In $aArray

		If (ControlGetText($sWndDelivery, '', String($cField) = '')) Then
			ConsoleWrite($cField & "IS EMPTY" & @CRLF)
			Return False
		EndIf
	Next


	Return True

EndFunc ;==>Valida_Entrega




; #FUNCTION# ======================================================================================================
; Name...........: Cadastra_Entrega
; Description ...: Register a customer info at Delivery screen
; Syntax.........: TesteFrenteTouch_Entrega($sPhoneNumber)
; Parameters ....: $idCliente, $file
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func Cadastra_Entrega($idCliente, $file)
	ConsoleWrite("Cadastra_Entrega" & @CRLF)

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibRegister("closeImpressoesRemotasWnd")

	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = $file

	; Read the INI section labelled 'Cliente X'. This will return a 2 dimensional array.
	Local $aArray = IniReadSection($sFilePath, $idCliente)

;~ 	The number of elements returned will be in $aArray[0][0]. If an @error occurs, no array is created.
;~     $aArray[0][0] = Number
;~     $aArray[n][0] = nth Key
;~     $aArray[n][1] = nth Value


	; Check if an error occurred.
    If Not @error Then
        ; Enumerate through the array displaying the keys and their respective values.
        For $i = 1 To $aArray[0][0]

			Local $sField = $aArray[$i][0]
			Local $sValue = $aArray[$i][1]
			ConsoleWrite("Field: " & $sField & @CRLF)
			ConsoleWrite("Value: " & $sValue & @CRLF)

			Switch $sField
;~ 				Case "TELEFONE"
;~ 					ControlSetText($sWndDelivery,'',$sFieldPhone,$sValue)
;~ 					Sleep(500)
;~ 					ControlFocus($sWndDelivery,'',$sFieldPhone)

				Case "NOME"
					ControlFocus($sWndDelivery,'',$sFieldName)
					If ControlGetText($sWndDelivery,'',$sFieldName) = '' Then
						ControlSetText($sWndDelivery,'',$sFieldName,$sValue)
						Send('{ENTER}')
						Sleep(500)
					EndIf

				Case "CPF"
					If ($sValue <> '') Then
						ControlSetText($sWndDelivery,'',$sFieldCPF,$sValue)
						Sleep(500)
					EndIf

				Case "CEP"
					ControlFocus($sWndDelivery,'',$sFieldCEP)
					ControlSetText($sWndDelivery,'',$sFieldCEP,$sValue)
					Sleep(300)
					Send('{F3}')
					Sleep(300)

				Case "ENDERECO"
					If ($sValue <> '') Then
						ControlFocus($sWndDelivery,'',$sFieldEndereco)
						ControlSetText($sWndDelivery,'',$sFieldEndereco,$sValue)
						Sleep(500)
					EndIf

				Case "NUMERO"
					If (ControlGetText($sWndDelivery, '',$sFieldNumero) = '') Then
						ControlFocus($sWndDelivery,'',$sFieldNumero)
						If $sValue = '' Then
							ControlSetText($sWndDelivery,'',$sFieldNumero, String(Random(1,3500,1)))
						Else
							ControlSetText($sWndDelivery,'',$sFieldNumero,$sValue)
						EndIf
						Sleep(500)
					EndIf

				Case "BAIRRO"
					If ($sValue <> '') Then
						ControlFocus($sWndDelivery,'',$sFieldBairro)
						ControlSetText($sWndDelivery,'',$sFieldBairro,$sValue)
						Sleep(500)
					EndIf

				Case "CIDADE"
					If ($sValue <> '') Then
						ControlFocus($sWndDelivery,'',$sFieldCidade)
						ControlSetText($sWndDelivery,'',$sFieldCidade,$sValue)
						Sleep(500)
					EndIf

				Case "COMPLEMENTO"
					ControlFocus($sWndDelivery,'',$sFieldComplemento)
					ControlSetText($sWndDelivery,'',$sFieldComplemento,$sValue)
					Sleep(500)

				Case "OBS"
					ControlFocus($sWndDelivery,'',$sFieldOBS)
					ControlSetText($sWndDelivery,'',$sFieldOBS,$sValue)
					Sleep(500)

			EndSwitch

        Next
    EndIf

	If Valida_Entrega() Then
		#Finish delivery register/sale
		Send('{ALTDOWN}f{ALTUP}')
	Else
		ConsoleWrite("Cadastro inválido. Preencha corretamente os campos obrigatórios.")
	EndIf

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibUnRegister("closeImpressoesRemotasWnd")

EndFunc ;==>Cadastra_Entrega


; #FUNCTION# ======================================================================================================
; Name...........: LoginFrenteTouch
; Description ...: executes login of Frente Touch
; Syntax.........: LoginFrenteTouch()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func LoginFrenteTouch($idLabel, $x, $y)
	ConsoleWrite("LoginFrenteTouch")
	ConsoleWrite("Y: " & $y)
	Opt("MouseCoordMode", 2) ;1=absolute, 0=relative, 2=client

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibRegister("closeImpressoesRemotasWnd")

	#$iPID = Run($idLabel, GetDir($idLabel))
	#Sleep(2000)


	Local $aArray_nCoordUserX[6] = [79, 230, 381, 534, 676, 828]
	Local $aArray_nCoordUserY[2] = [25, 80]

	#Sleep(5000)


	#11 79, 24
	#12 230, 24
	#13 381, 24
	#14 534, 24
	#15 676, 24
	#16 828, 24

	#21 79, 80
	#22 230, 80
	#23 381, 80
	#24 534, 80
	#25 676, 80
	#26 828, 80

	#MBD - ULTIMA OPÇÃO SEGUNDA LINHA
	#Local $nCoordUserX = 824

	#A_JOAO - SEGUNDA OPÇÃO SEGUNDA LINHA
	#Local $nCoordUserX = 232
	#Local $sPassword = '2419'

	#MBD- QUARTA OPÇÃO SEGUNDA LINHA
	Local $nCoordUserX = $aArray_nCoordUserX[$x]

	#LINE 2
	Local $nCoordUserY = $aArray_nCoordUserY[$y]

	If GUICtrlRead($idInputPassword) <> Null And GUICtrlRead($idInputPassword) <> "" Then
		Local $sPassword = GUICtrlRead($idInputPassword)
	Else
		Local $sPassword = '1230'
	EndIf

	Local $sInputPassword = '[CLASS:TEdit; INSTANCE:1]'
	#Global $sWndMensagemCardapio = '[CLASS:TFRM_Mensagem]'
	#Global $sWndPrincipal = '[CLASS:TFRM_Principal]'


	$hWndLoginCardapio = WinWait($sWndLoginCardapio,'')
	Sleep(8000)

	ControlSetText($hWndLoginCardapio,'Turnos: ',$sInputPassword,$sPassword)

	#click on MBD User (need to verify coordinates)
	#ControlClick($hWndLoginCardapio,'', $sPanelFuncionarios, 'primary',1,$nCoordUserX,$nCoordUserY)
	MouseClick('primary',$nCoordUserX,$nCoordUserY,1)
	Sleep(1000)

	#ControlFocus($hWndLoginCardapio,'Turnos: ',$sInputPassword)
	Send($sPassword)
	Send('{ENTER}')
	Sleep(1000)

	$hWndMensagemCardapio = WinWait($sWndMensagemCardapio,'Data sincronizada com o servidor!!')
	If ($hWndMensagemCardapio = 0) Then
		ConsoleWriteError('Falha em encontrar a janela mensagem')
	EndIf
	Send('{ALTDOWN}o{ALTUP}')
	Sleep(2000)

	Local $hWndPrincipal = WinWait($sWndPrincipal)
	$handlePrincipal = WinGetHandle($hWndPrincipal)

	; Unregister the function closeImpressoesRemotasWnd() from being called every 250ms.
    AdlibUnRegister("closeImpressoesRemotasWnd")

EndFunc		;==>LoginFrenteTouch



; #FUNCTION# ======================================================================================================
; Name...........: efetuarVenda
; Description ...: executes process of selecting different products in Frente Touch and launch them to finalizarVenda
; Syntax.........: efetuarVenda()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func efetuarVenda()

;~ 	ConsoleWrite('Efetuar venda -> $handlePrincipal: ' & $handlePrincipal & @CRLF)
;~ 	If $handlePrincipal = '' Then
;~ 		Local $hWndPrincipal = WinWait($sWndPrincipal)
;~ 		$handlePrincipal = WinGetHandle($hWndPrincipal)
;~ 	EndIf
;~ 	ConsoleWrite('Efetuar venda -> $handlePrincipal: ' & $handlePrincipal & @CRLF)

;~ 	ConsoleWrite('Efetuar venda -> $hWndLoginCardapio: ' & WinExists($sWndLoginCardapio) & @CRLF)
;~ 	ConsoleWrite('State:' &  BitAND(WinGetState($hWndLoginCardapio), $WIN_STATE_VISIBLE) & @CRLF)

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibRegister("closeImpressoesRemotasWnd")

	Local $iLoginState = WinGetState($sWndLoginCardapio)
	If BitAND($iLoginState, 5) Then
		ConsoleWrite("Minimized!")
	Else

;~ 		$hWndLoginCardapio = WinGetHandle($sWndLoginCardapio)
		ConsoleWrite("Estado do login: " & WinGetState($sWndLoginCardapio) & @CRLF)
		Sleep(300)
	EndIf

;~ 	ConsoleWrite('Efetuar venda -> $hWndLoginCardapio: ' & $hWndLoginCardapio & @CRLF)

;~ 	If WinExists($sWndMensagemCardapio) Then
;~ 		$hWndMensagemCardapio = WinGetHandle($sWndMensagemCardapio)
;~ 		WinWaitClose($sWndMensagemCardapio)
;~ 		Sleep(300)
;~ 	EndIf

;~ 	ConsoleWrite('Efetuar venda -> $hWndMensagemCardapio: ' & $hWndMensagemCardapio & @CRLF)

;~ 	Sleep(1500)


	ConsoleWrite('Efetuar venda')
	Local $nCoordGrupoX = 43
	Local $nCoordGrupoY = 60
	#increments of 40 or 38 to hit buttons below

	Local $iInstance = 0
	Local $hControl = ''
	Local $nProdutos = GUICtrlRead($idInputProdutos)
	Local $nQuantidadeProduto = GUICtrlRead($idQuantidadeProduto)

	If $nProdutos = '' Then $nProdutos = 5
	If $nQuantidadeProduto = '' Then $nQuantidadeProduto = 1

	; Random number of products to select
	Local $iRandomProducts = Random(1,$nProdutos, 1)
	ConsoleWrite("nProdutos a selecionar: " & $iRandomProducts & @CRLF)

;TODO: Do not repeat a selected item
;~ 	; Return $nProdutos unique numbers from 8 to 49
;~ 	Local $aRandomProducts[$iRandomProducts]
;~
;~ 	_RandomUnique($iRandomProducts, 8, 49, 1)
;~ 	For $iInstance In $aRandomProducts
;~ 		$hControl = ControlGetHandle($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&$iInstance&']')
;~ 		If Not IsHWnd ( $hControl ) Then
;~ 			_ArrayDelete ( ByRef $aRandomProducts, $iInstance )
;~ 			ConsoleWrite("deleted. New array: " & $aRandomProducts & @CRLF)
;~ 			_ArrayAdd( ByRef $aRandomProducts, Random(
;~ 		EndIf
;~ 	Next
;~
;~ 	While $iRandomProducts >=  UBound($aRandomProducts, $UBOUND_ROWS)
;~
;~ 	WEnd

	For $i = $iRandomProducts To 1 Step -1
	 If (Random(0,1,1)) Then
		 #choose a different product group
		 ControlClick($handlePrincipal,'', '[CLASS:TJvScrollBox; INSTANCE:1]', 'primary',1,$nCoordGrupoX, $nCoordGrupoY + Random(1,4,1)*38)
		 Sleep(300)
	 EndIf

	 #choose a product
	 #ControlClick($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&Random(8,37,1)&']', 'primary',1)
	 Local $sButtonAddQuantity = '[CLASS:TPanel; INSTANCE:7]'

	 While 1
		#Input quantity of products
		ControlClick($handlePrincipal,'',$sButtonAddQuantity, 'primary', Random(0,$nQuantidadeProduto - 1,1), 392, 28)


		$iInstance = Random(8,49,1)
		$hControl = ControlGetHandle($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&$iInstance&']')
		If IsHWnd ( $hControl ) Then
			ControlClick($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&$iInstance&']', 'primary',1)
			ExitLoop
		EndIf

	 WEnd
	 Sleep(800)

	Next


	If GUICtrlRead($idCheckBox_Delivery) = $GUI_CHECKED Then
		Local $iRandom = Random(0,5,1)
		If GUICtrlRead($idCheckBox_Guardar) = $GUI_CHECKED And ($iRandom = 3) Then
			Send('{ALTDOWN}g{ALTUP}')
			Sleep(500)
		Else
			FinalizarVenda()
			Sleep(1000)
		EndIf
	Else

		FinalizarVenda()
		Sleep(1000)
	EndIf


	; Unregister the function closeImpressoesRemotasWnd() from being called every 250ms.
    AdlibUnRegister("closeImpressoesRemotasWnd")

EndFunc ;==>efetuarVenda




; #FUNCTION# ======================================================================================================
; Name...........: FinalizarVenda
; Description ...: finishes process of selling products in Frente Touch
; Syntax.........: FinalizarVenda()
; Parameters ....:
; Return values .: None
; Author ........: João Trepichio <trepichio@gmail.com>
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ==================================================================================================================
Func FinalizarVenda ($hWnd = 0)
	ConsoleWrite("FinalizarVenda" & @CRLF)

	; Register the function closeImpressoesRemotasWnd() to be called every 250ms (default).
    AdlibRegister("closeImpressoesRemotasWnd")

	#Cut code begin
	Send('{ALTDOWN}z{ALTUP}')
	Sleep(2000)

	ConsoleWrite("Wait for CNPJ" & @CRLF)
	#CNPJ Window only appears when SAT is running
	WinWait($sWndCNPJ, '', 3)

	If WinExists($sWndCNPJ) Then
		Send('{ALTDOWN}n{ALTUP}')
		Sleep(500)
	Endif

	Local $sWndFinalizar = '[CLASS:TFRM_Finalizar]'
	Local $sPanelPagamentos = '[CLASS:TJvScrollBox; INSTANCE:1]'
	Local $nCoordPgtoX = 88
	Local $nCoordPgtoY = 70
	#increments of 70 to hit buttons below (DINHEIRO=288)

	ConsoleWrite("Check if there already is a handle for Window Finalizar Venda" & @CRLF)
	Local $sPanelGrupos = '[CLASS:TJvScrollBox; INSTANCE:1]'
	If WinExists($hWnd) = 0 Then
		Local $hWndFinalizar = WinWait($sWndFinalizar)
		Local $handleFinalizar = WinGetHandle($hWndFinalizar)
	Else
		Local $handleFinalizar = WinGetHandle($hWnd)
	EndIf

	Local $iPaymentOK = 1
	While $iPaymentOK

	ConsoleWrite("Choose a random payment method" & @CRLF)
	ControlClick($handleFinalizar,'', $sPanelPagamentos, 'primary',1,$nCoordPgtoX,$nCoordPgtoY + Random(1,4,1)*70)
	Sleep(1000)

	Local $sMsgMensalista = 'Não é permitido Forma de Pagamento Mensalista para cliente NÃO MENSALISTA.'
	Local $sMsgEscolhaCliente = 'Esta Condição de Pagamento requer a escolha de um Cliente!'

	ConsoleWrite("Check if a disturbing window like 'Mensalista' appears" & @CRLF)
	If WinExists($sWndMensagemCardapio,$sMsgEscolhaCliente) Or WinExists($sWndMensagemCardapio, $sMsgMensalista) Then
		ConsoleWrite("Appeared. So, let's close it." & @CRLF)
		Send('{ALTDOWN}o{ALTUP}')
		Sleep(300)
		$iPaymentOK = 1
		Else
		ConsoleWrite("No disturbing window. Let's finish the sale process." & @CRLF)
		$iPaymentOK = 0
	EndIf
	WEnd

	Send('{ALTDOWN}o{ALTUP}')
	Sleep(800)
	Send('{ALTDOWN}f{ALTUP}')
	Sleep(2500)

	; Unregister the function closeImpressoesRemotasWnd() from being called every 250ms.
    AdlibUnRegister("closeImpressoesRemotasWnd")

EndFunc ;==>FinalizarVenda

; #FUNCTION# ====================================================================================================================
; Version........: 1.1 - 2011/11/24
; Name...........: _RandomUnique
; Description ...: Returns an array of unique random numbers
; Syntax.........: _RandomUnique($iCount, $nMin, $nMax, [$iInt = 0, [$nSeed = Default]])
; Parameters ....: $iCount  - The amount of numbers to generate Number between 1 and 10^6-1
;                 $nMin   - The smallest number to be generated. Number between -2^31 and 2^31-1
;                 $nMax   - The largest number to be generated. Number between -2^31 and 2^31-1
;                 $iInt   - [optional] If this is set to 1 then an integer result will be returned. Default is a floating point number.
;                 $nSeed     - [optional] Seed value for random number generation. Number between -2^31 and 2^31-1
; Return values .: Success  - Returns a 1-dimensional array containing only unique numbers
;                            $Array[0] = count of generated numbers
;                            $Array[1] = first number
;                            $Array[2] = second number, etc
;                Failure     - Returns 0 and sets @error:
;                               | 1 - $iCount is too small
;                               | 2 - $iCount is too large
;                               | 3 - $nMin and $nMax are equal
;                               | 4 - $nMin is larger than $nMax
;                               | 5 - $nMin or $nMax exceeds limit
;                               | 6 - $nSeed exceeds limit
; Author ........: money
; Modified.......:
; Remarks .......:  If $iInt is 1 and $iCount exceeds total unique numbers than @extend is set to 1 and item count is adjusted to the
;                  + maximum numbers that can be returned
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _RandomUnique($iCount, $nMin, $nMax, $iInt = 0, $nSeed = Default)
    ; error checking
    Select
        ; $iCount is too small
        Case ($iCount < 1)
            Return SetError(1, 0, 0)
        ; $iCount is too large
        Case ($iCount > 10^6-1)
            Return SetError(2, 0, 0)
        ; $nMin and $nMax cannot be equal
        Case ($nMin = $nMax)
            Return SetError(3, 0, 0)
        ; $nMin cannot be larger than $nMax
        Case ($nMin > $nMax)
            Return SetError(4, 0, 0)
        ; $nMin or $nMax exceeds limit
        Case ( ($nMin < -2^31) Or ($nMax > 2^31-1) )
            Return SetError(5, 0, 0)
    EndSelect
    ; user specific seed
    If IsNumber($nSeed) Then
        ; $nSeed exceeds limit
        If (($nSeed < -2^31) Or ($nSeed > 2^31-1) ) Then Return SetError(6, 0, 0)
        SRandom($nSeed)
    EndIf
    ; $iCount is equal too or exceeds maximum possible unique values
    Local $iCountInval = 0
    If ($iInt) Then
        ; positive
        If ($nMin >= 0) Then
            If ($iCount > ($nMax-$nMin)+1) Then
                $iCountInval = 1
            ElseIf ($iCount = ($nMax-$nMin)+1) Then
                $iCountInval = 3
            EndIf
        ; negative to positive
        Else
            If ($iCount > ($nMax + Abs($nMin)+1)) Then
                $iCountInval = 2
            ElseIf ($iCount = ($nMax + Abs($nMin)+1)) Then
                $iCountInval = 3
            EndIf
        EndIf
    EndIf
    ; courtesy
    If ($iInt And $iCount = 1) Then
        Local $aArray[2] = [1, Random($nMin, $nMax, $iInt)]
    ; $iCount is too large so we will generate as much we can from $nMin to $nMax values
    ElseIf $iCountInval Then
        If $iCountInval = 1 Then
            $iCount = Int($nMax - $nMin)+1
        ElseIf $iCountInval = 2 Then
            $iCount = Int($nMax + Abs($nMin))+1
        EndIf
        ; $iCount is equal to total unique numbers
        If $iCountInval = 3 Then $iCountInval = 0
        Local $aTmp, $iA, $iNumber = $nMin, $aArray[$iCount + 1] = [$iCount]
        ; add our numbers sequentially (from $iMin to $iMax)
        For $i = 1 To $aArray[0]
            $aArray[$i] = $iNumber
            $iNumber += 1
        Next
        ; swap every x index value with a random index value
        For $i = 1 To $aArray[0]
            $iA = Random($i, $aArray[0], 1)
            If $i = $iA Then ContinueLoop
            If $iA = 0 Then $iA = $aArray[0]
            $aTmp = $aArray[$i]
            $aArray[$i] = $aArray[$iA]
            $aArray[$iA] = $aTmp
        Next
    Else
    ; everything else is ok, generate unique numbers
        Local $nRnd, $iStep = 0, $aArray[$iCount + 1] = [$iCount]
        While ($iStep <= $iCount-1)
            $nRnd = Random($nMin, $nMax, $iInt)
            ; check if the number already exist
            If IsDeclared($nRnd) <> -1 Then
                $iStep += 1
                $aArray[$iStep] = $nRnd
                ; store our numbers in a local variable
                Assign($nRnd, '', 1)
            EndIf
        WEnd
    EndIf
    Return SetError(0, Number($iCountInval > 0), $aArray)
EndFunc ;==>_RandomUnique
