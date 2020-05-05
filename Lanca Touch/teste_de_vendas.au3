#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;========= BUILD =====
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay.

#RequireAdmin
AutoItSetOption('MouseCoordMode', 0)
AutoItSetOption('SendKeyDelay', 10)
AutoItSetOption('WinTitleMatchMode',2) ;Opt("WinTitleMatchMode", 1) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase

Run("C:\MBD\Lança-Touch\Touch.exe", "C:\MBD\Lança-Touch")
Sleep(8000)

#Global $sBotaoMensagemLancaTouch = '[CLASS:TButton; INSTANCE:1]'
#Sleep(1000)

#Global $hWndMensagemTouch  = WinWait('[CLASS:TFRM_Mensagem]',10)
#Global $handleMENSAGEM= WinGetHandle($hWndMensagemTouch)

#ControlClick($handleMENSAGEM,'',$sBotaoMensagemLancaTouch,'primary',1)
#Sleep(300)

#operador TIAGO RAFAEL ((8274) senha 4728 )
Local $sPassword = '4728'


#mbd
#Local $sPassword = '1230'


Local $sInputPassword = '[CLASS:TEdit; INSTANCE:4]'
Global $sWndPrincipal = '[CLASS:TFRM_Principal]'
Global $sInputMesa = '[CLASS:TEdit; INSTANCE:3]'
Global $sInputProduto = '[CLASS:TEdit; INSTANCE:1]'
Global $sPanelBottom = '[CLASS:TJvPanel; INSTANCE:1]'

Global $hWndPrincipal = WinWait($sWndPrincipal,'')
Global $sWndPergunta = '[CLASS:TFRM_Pergunta]'
Global $sBotaPerguntaSIM = '[CLASS:TButton; INSTANCE:2]'

ControlSetText($hWndPrincipal,'',$sInputPassword,$sPassword)
Send('{ENTER}')

Global $aProducts = ['7892840814809', '7896230300033', '7896004006475', '7896042010762', '7896042010779', '7898629570867', '7897947613614', '7896042069029', '7622210617903', '7896042069012', '7896042084077', '7897395031657', '7891024034781', '7896042068237', '7622300861346', '7622210762962', '7891000277928', '7896042089690', '7892840815141', '7898052410570', '78919457', '7896042090771', '2190002013080', '2190002013059', '190002013103', '7898913434509', '7892840814526', '7898913434516', '7898913434493', '7896056102255', '7898936111180', '7896665280917', 'D69317', 'D69319', 'D69321', 'D69322', 'D69326', 'D69328', 'D69340', 'D69344', 'D69375', 'D69404', 'D69407', 'D69437', 'F2005A', 'F2007', 'F62042', 'F62044A', 'F62055', 'F62056', 'F62058', 'F62063', 'F62068', '867', '7898052410259', '7898052410150', '0751320180216', '7891962053196', 'F62072', 'F62077', 'F62078', 'F62079', 'F62081', 'F68036', 'M2000', 'M2001', 'M62028', 'M62036', '7622300861957', '7891055337318']

Global $iProductRows = UBound($aProducts, $UBOUND_ROWS)
Global $hWndPergunta = ''
For $i = 10 To 1 Step -1
	Local $iCodMesa = Random(1600,1700,1)
	ControlSetText($hWndPrincipal,'',$sInputMesa,$iCodMesa)
	Send('{ENTER}')

	For $j = 5 To 1 Step -1
		insertProducts()
		Sleep(3000)
	Next
	ControlClick($hWndPrincipal,'',$sPanelBottom, 'primary',1, 772, 51)
	Sleep(300)
	$hWndPergunta = WinWait($sWndPergunta,'')
	ControlClick($hWndPergunta,'',$sBotaPerguntaSIM, 'primary',1)
	Sleep(3000)

Next






;~ #click on MBD User (need to verify coordinates)
;~ #ControlClick($hWndLoginCardapio,'', $sPanelFuncionarios, 'primary',1,$nCoordUserX,$nCoordUserY)
;~ MouseClick('primary',$nCoordUserX,$nCoordUserY,1)
;~ Sleep(1000)

;~ #ControlFocus($hWndLoginCardapio,'Turnos: ',$sInputPassword)
;~ Send($sPassword)
;~ Send('{ENTER}')
;~ Sleep(1000)

;~ Local $hWndMensagem = WinWait($sWndMensagemCardapio,'Data sincronizada com o servidor!!')
;~ If ($hWndMensagem = 0) Then
;~ 	ConsoleWriteError('Falha em encontrar a janela mensagem')
;~ EndIf
;~ Send('{ALTDOWN}o{ALTUP}')
;~ Sleep(2000)

;~ Local $hWndPrincipal = WinWait($sWndPrincipal)
;~ Global $handlePrincipal = WinGetHandle($hWndPrincipal)

;~ For $i = 100 To 1 Step -1
;~  efetuarVenda()
;~  Sleep(3000)
;~ Next



Func insertProducts()

	Local $k = Random(0,$iProductRows-1,1)
	ControlSetText($hWndPrincipal,'',$sInputProduto,$aProducts[$k])
	Send('{ENTER}')


;~ 	Local $nCoordGrupoX = 43
;~ 	Local $nCoordGrupoY = 60
;~ 	#increments of 40 or 38 to hit buttons below

;~ 	For $i = 5 To 1 Step -1
;~ 	 If (Random(0,1,1)) Then
;~ 		 #choose a different product group
;~ 		 ControlClick($handlePrincipal,'', '[CLASS:TJvScrollBox; INSTANCE:1]', 'primary',1,$nCoordGrupoX, $nCoordGrupoY + Random(1,4,1)*38)
;~ 		 Sleep(300)
;~ 	 EndIf

;~ 	 #choose a product
;~ 	 #ControlClick($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&Random(8,37,1)&']', 'primary',1)

;~ 	 While 1
;~ 		$iInstance = Random(8,37,1)
;~ 		$hControl = ControlGetHandle($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&$iInstance&']')
;~ 		If IsHWnd ( $hControl ) Then
;~ 			ControlClick($handlePrincipal,'', '[CLASS:TPanel; INSTANCE:'&$iInstance&']', 'primary',1)
;~ 			ExitLoop
;~ 		EndIf

;~ 	 WEnd
;~ 	 Sleep(800)

;~ 	Next

;~ 	 Send('{ALTDOWN}z{ALTUP}')
;~ 	 #Sleep(1000)

;~ 	 FinalizarVenda()


EndFunc

;~ Func FinalizarVenda ($hWnd = 0)
;~ 	Local $sWndFinalizar = '[CLASS:TFRM_Finalizar]'
;~ 	Local $sPanelPagamentos = '[CLASS:TJvScrollBox; INSTANCE:1]'
;~ 	Local $nCoordPgtoX = 88
;~ 	Local $nCoordPgtoY = 70
;~ 	#increments of 70 to hit buttons below (DINHEIRO=288)

;~ 	Local $sPanelGrupos = '[CLASS:TJvScrollBox; INSTANCE:1]'
;~ 	If WinExists($hWnd) = 0 Then
;~ 		Local $hWndFinalizar = WinWait($sWndFinalizar)
;~ 		Local $handleFinalizar = WinGetHandle($hWndFinalizar)
;~ 	Else
;~ 		Local $handleFinalizar = WinGetHandle($hWnd)
;~ 	EndIf

;~ 	ControlClick($handleFinalizar,'', $sPanelPagamentos, 'primary',1,$nCoordPgtoX,$nCoordPgtoY + Random(1,4,1)*70)
;~ 	Sleep(1000)

;~ 	If WinExists($sWndMensagemCardapio,'Esta Condição de Pagamento requer a escolha de um Cliente!') Then
;~ 		Send('{ALTDOWN}o{ALTUP}')
;~ 		Sleep(300)
;~ 		FinalizarVenda($handleFinalizar)
;~ 		Return
;~ 	EndIf

;~ 	Send('{ALTDOWN}o{ALTUP}')
;~ 	Sleep(800)
;~ 	Send('{ALTDOWN}f{ALTUP}')
;~ 	Sleep(1500)

;~ EndFunc