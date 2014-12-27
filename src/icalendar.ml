(* iCalendar & vCard Parameter Value Encoding RFC6868, see http://tools.ietf.org/html/rfc6868 *)
let caret = "^";;
let encodedCaret = "^^";;
let newline = "\n";;
let encodedNewline = "^n";;
let doubleQuote = "\"";;
let encodedDoubleQuote = "^\'";;
let regexp = Str.regexp_string;;
  
let icalendarParameterValueEncode text =
  Str.global_replace (regexp caret) encodedCaret text
  |> Str.global_replace (regexp newline) encodedNewline
  |> Str.global_replace (regexp doubleQuote) encodedDoubleQuote;;

let icalendarParameterValueDecode text =
  Str.global_replace (regexp encodedDoubleQuote) doubleQuote text
  |> Str.global_replace (regexp encodedNewline) newline
  |> Str.global_replace (regexp encodedCaret) caret;;

(* All lines in iCalendar format must not be longer than 75 octets and lines broken with a CRLF *)
let crlf = "\r\n"
let maxLineLength = 75
let rec foldText text = 
	if String.length text <= maxLineLength
	then text
	else String.sub text 0 maxLineLength ^ crlf ^ foldText (String.sub text maxLineLength (String.length text - maxLineLength))

let unfoldText text = String.concat "" (Str.split (regexp crlf) text)
