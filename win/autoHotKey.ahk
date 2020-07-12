; 改键
; 下载安装autoHotkey，将脚本放入自启动目录即可
; 自启动目录：C:\ProgramData\Microsoft\Ctrldows\Start Menu\Programs\StartUp

; Ctrl & h::send,{left}      
; Ctrl & j::send,{down}
; Ctrl & k::send,{up}
; Ctrl & l::send,{right}
; Ctrl & g::send,{Home}
; Ctrl & '::send,{End}

; 右alt + hjkl
<!h::send,{left}      
<!j::send,{down}
<!k::send,{up}
<!l::send,{right}

;自定义功能键
<!u::send,{Home}
<!i::send,{End}
<!p::send,{Delete}
; <![::send,{BackSpace}
; <!p::send,{PgUp}
; <!n::send,{PgDn}

; Esc
Ctrl & [::send,{Esc}