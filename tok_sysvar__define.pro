; +
; $Id: pfo_sysvar__define.pro,v 1.2 2004/01/15 17:05:49 jpmorgen Exp $

; tok_sysvar__define.pro 

; This procedure makes use of the handy feature in IDL 5 that calls
; the procedure mystruct__define when mystruct is referenced.
; Unfortunately, if IDL calls this proceedure itself, it uses its own
; idea of what null values should be.  So call explicitly with an
; argument if you need to have a default structure with different
; initial values, or as in the case here, store the value in a system
; variable.

;; This defines the !tok system variable, which contains global
;; variables handy for remembering the arbitrary numbers IDL uses
;; everywhere.

; -

pro tok_sysvar__define
  ;; System variables cannot be redefined and named structures cannot
  ;; be changed once they are defined, so it is OK to check this right
  ;; off the bat
  defsysv, '!tok', exists=tok_exists
  if tok_exists eq 1 then return
  
  tok $
    = {tok_sysvar, $
       $ ;; Use C printf-style quoted string formatting to get newline
       $ ;; (is there a way to do this in the FORTAN style?) 
       newline	:	string(format='(%"%s\n")', ''), $
       $ ; PSYM
       plus	:	1, $
       asterisk	:	2, $
       dot	:	3, $
       diamond	:	4, $
       triangle	:	5, $
       square	:	6, $
       psym_x	:	7, $
       hist	:	10, $
       $ ; LINESTYLE
       solid	:	0, $
       dotted	:	1, $
       dashed	:	2, $
       dash_dot	:	3, $
       dash_3dot:	4, $
       long_dash:	5, $
       $ ; [XYZ]STYLE
       exact	:	1, $
       extend	:	2, $
       no_axes	:	4, $
       no_box	:	8, $
       yfloat	:	16}

  defsysv, '!tok', tok

end


