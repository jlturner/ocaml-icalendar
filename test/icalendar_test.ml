let icalendarParameterValueEncodingTest = QCheck.mk_test ~n:100000
    ~name:"Test involutivity of RFC 6868 encoding"
    QCheck.Arbitrary.(string)
    (fun s -> Icalendar.icalendarParameterValueDecode (Icalendar.icalendarParameterValueEncode s) = s);;
QCheck.run icalendarParameterValueEncodingTest;;

let icalendarLineFoldingTest = QCheck.mk_test ~n:100000
    ~name:"Test involutivity of RFC 5545 line folding"
    QCheck.Arbitrary.(string)
    (fun s -> Icalendar.unfoldText (Icalendar.foldText s) = s);;
QCheck.run icalendarLineFoldingTest;;