; +
; $Id: tok_sysvar__define.pro,v 1.2 2011/01/20 23:04:55 jpmorgen Exp jpmorgen $

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
  ;; For numerical small and large values, calculate some handy
  ;; numbers in base 2.
  ;; http://en.wikipedia.org/wiki/Single_precision 
  ;; http://en.wikipedia.org/wiki/Double_precision
  f_smallest = 2.^(-126) * 2.^(-23)
  d_smallest = 2d^(-1022) * 2d^(-52)
  ;; [fd]f is the largest single [double] precision fraction.  These
  ;; end up calculating to something very close to 2 in decimal.
  ff = 1. & for i=1, 23 do ff=ff + 2.^(-i)
  df = 1d & for i=1, 52 do df=df + 2d^(-i)
  f_largest = 2.^((2^8-2)-127) * ff
  d_largest = 2d^((2^11-2)-1023) * df
  ;; When we actually do calculations, like exp(alog(d_smallest)), we
  ;; need to give the computer a little room to work.  f_small worked
  ;; with 1.1, but do 2 just to be neat.
  f_small = 2.^(-126) * 2
  d_small = 2d^(-1022)
  f_large = 2.^((2^8-2)-127)
  d_large = 2d^((2^11-2)-1023)
  max_int = 2^15-1
  min_int = 2^15                ; This computes to -2^15 in decimal notation
  max_long = 2L^31-1
  min_long = 2L^31               ; This computes to -2^31 in decimal notation
  
  tok $
    = {tok_sysvar, $
       no	:	0, $
       yes	:	1, $
       $ ;; Thanks to David Fanning's coyote library testlineformat.pro 
       $ ;; for helping me find 10B (linefeed).  This works in all environments I care about
       newline	:	string(10B), $
       $ ;; PSYM
       plus	:	1, $
       asterisk	:	2, $
       dot	:	3, $
       diamond	:	4, $
       triangle	:	5, $
       square	:	6, $
       psym_x	:	7, $
       hist	:	10, $
       $ ;; LINESTYLE
       solid	:	0, $
       dotted	:	1, $
       dashed	:	2, $
       dash_dot	:	3, $
       dash_3dot:	4, $
       long_dash:	5, $
       $ ;; [XYZ]STYLE
       exact	:	1, $
       extend	:	2, $
       no_axes	:	4, $
       no_box	:	8, $
       yfloat	:	16, $
       $ ;; TEK_COLORs
       black	:	0, $
       white	:	1, $
       red	:	2, $
       green	:	3, $
       blue	:	4, $
       cyan	:	5, $
       magenta	:	6, $
       orange	:	8, $
       $ ;; !MOUSE.BUTTON.  Also in widet draw events
       left	:	1, $
       middle	:	2, $
       right	:	4, $
       $ ;; PLOTERR plot type
       lin_lin	:	0, $
       lin_log	:	1, $
       log_lin	:	2, $
       log_log	:	3,  $
       $ ;; Widget draw event types
       down	:	0, $
       up	:	1, $
       motion	:	2, $
       scroll	:	3, $
       expose	:	4, $
       char	:	5, $
       key	:	6,  $
       $ ;; Type codes
       BYTE     :	1 , $ ;; Byte                     
       INT      :	2 , $ ;; Integer                  
       LONG     :	3 , $ ;; Longword integer         
       FLOAT    :	4 , $ ;; Floating point           
       DOUBLE   :	5 , $ ;; Double-precision floating
       COMPLEX  :	6 , $ ;; Complex floating         
       STRING   :	7 , $ ;; String                   
       STRUCT   :	8 , $ ;; Structure                
       DCOMPLEX :	9 , $ ;; Double-precision complex 
       POINTER  :	10, $ ;; Pointer                  
       OBJREF   :	11, $ ;; Object reference         
       UINT     :	12, $ ;; Unsigned Integer         
       ULONG    :	13, $ ;; Unsigned Longword Integer
       LONG64   :	14, $ ;; 64-bit Integer           
       ULONG64  :	15, $ ;; Unsigned 64-bit Integer   
       $ ;; Units in widgets
       pixels	:	0, $
       inches	:	1, $
       cm	:	2, $
       $ ;; ![XYZ].type
       lin	:	0, $
       log	:	1, $
       $ ;; ON_ERROR codes
       stop	:	0, $
       retall	:	1, $
       return	:	2, $
       ret_here	:	3, $
       $ ;; numerical values that would have been nice to see in !values
       f_small	:	f_small, $
       f_large	:	f_large, $
       d_small	:	d_small, $
       d_large	:	d_large, $
       min_int	:	min_int, $
       max_int	:	max_int, $
       min_long	:	min_long, $
       max_long	:	max_long, $
       $ ;; IDL's where returns -1 as an invalid index.  Call the invalid index (which, in IDL 8 is no longer inalid (sigh), "nowhere"
       nowhere	:	-1L}
  
  defsysv, '!tok', tok

  ;; I find myself wanting to use !dradeg for double conversion
  ;; to/from degrees:
  defsysv, '!dradeg', exists=dradeg_exists
  if dradeg_exists eq 0 then begin
     defsysv, '!dradeg', 180d/!dpi
     return
  endif else begin
     message, /CONTINUE, 'WARNING: system variable !dradeg already exists'
     help, !dradeg
  endelse

end


