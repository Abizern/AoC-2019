private let rawInput = """
220222220222200212222221022222222222222222020122202221212220122222122221222222222222222222222022222222212222202222222222122202222222222212222002222222222222222222220222222221222222222222222222120022202220212222222222022222222222222222222222222122222222222222222222222222022212222222222202222022222222220122220222220212222222022222222222222222120122212222212222022222022222222222222222222222222122222222222222212222222222022222222222222222222002222222221122221222202202222220222222222222222222022122212221222222022222022221222222222222222222222122222222222222202222222222122222222222222202222022222222222222221222210202222222022222222222222222222122222221212222022222222221222222222222222222222122222222202222202222222222022222222222222212222112222222222122221222210202222222122222222222222222101222222222202220122222022222222222222202222222222022222222212222202222222222222202222222222222222222222222220122221222210202222221222222220222222222110122202220202222022222222221222222222212222222222022222222202222202222222222022222222222222212222012222222222022220222210212222221222222221222222222021022222221202222222222220022222222222202222222222222222022222222212222222222022212222222222212222212222222221222221222220222222222222222222222222222021222202221212220122222121122222222222202222222222122222222222222222222222222122212222222222212222202222222220222220222201222222220020222222222222222001222202222222222222222121220222222222202222222222022222022212222202222222222022212222222222221222112222222222222220222221202222220121222222222222222111122212221212221122222120222202222222212022222222122222022202222202222222222122202222222222222222222222222221222222222222202202222122222222222222222211122202222202222022222020220222222222222022222222022222022202222212222222222222222222222222212222122222222122122222222212212212222220222221222222220102122202220202220222222220022202222222212222222222022222022222222222202222222222222222222222210222212222222022122220222221202202220022222220222222220011222202221212220222222121021222222222212022222222122222222212222222222222222022202222222222212222022222222120022220222221222202220020222220222222020102122212220202222222222120221202222222222022222222222222022212222222222222222122222222222222220222002222222121222220222221222222222020222222222222220111222222221212221222222122222202222222202222222222122222022222222202222222222022222222222222011222112222222021122222222222212212221221222221222202022010222202222202222122222221020212222222202112222222122222222212222222222222222222222222222222100222102222222020022220222200202212220122222220222202121122222212221202220222222022122212222222212122222222122222022202222212222222222022212222222222122222122222222121122220222200202212220022222221222212221121122202220222222222222121221222222222202022222222122222022212222222222222222022212222222222021222002222222021022220222200222212220121222200222212022012022222222202222022222222021212222222212212222222122222022222222202222222222222222222222222100222102222222120022221222200112212222120222220222202120112122202222212220022222121121202222222222222222222022222122222222202202222222122202222202222022222202222222120022220222220112202222222212200222222220211022222220212221122222222020222222222212122222222022222022212222202212222222022202222222222110222022222222120022222222212102201221022212201222212222202022202221202221222222121221202122222212222222222122222122212222212202222222022202222212222201222002222222021022222222210222220220021212220222202021011022202221222220222222220221202222222220122222222022222222222222202212222222122222222222222012222122212222122122221222210222221222020202222222202220201022222221222222022222010121222122222202022222222222222222222222222222222222002212222222222122222012202220120022222222222122211211221212201222222220100022221221222220122222201021202122222210212222222122222222212222222222222222222212222222222210222102212221122222221222222122222200221202220222202020222022201220222220022222112012222222222220212222222122220122222222222212222222222202222202222100222102222220022222211222221012200211220212201222222121211122222222222222222222000221202122202202022222222022222122202222212202222222002202222222222120222222212222220222200222222022221211121202220222212220010222201122202221222222002202202222202222112222202022222222222222212222222222202222222222222011221122212221021122200222220202202210122212200222222220100122200121202222022222211022202222222221202222202222221122222222202212222222102202222212222111222112202220220022222222211221200212221212200222212122221020221120222220222222202102212222212212122222212122221222212222202222222222002222222212222212222002202220022120220222212212210201222212220222222021000122212220022222222222120202202122212212102222222022220022222222202202222222202222222202222210220112212221120220221222211201200210122212211222202121110221211222112222122222220001222222222211212222212022220222212222202222222222112212222202222202221212202221121121220222220021212210122202202222202022000222222022222221222222100022202122202200222222222122222122202222202202222222212212222202222110221022222221021222201222221121212201221012222222212121000121220121212221022222101202212022222222212222212222221022222222202212222222112212222202222101220222222220220222201222211010221201222102212222222121201020211121022220222222222121222122222201002222222222220022212222202202222222112212222202222100220222212220121120201222210120212201122122201222202121110121201121012220222222121221222122212220002222202122221022202222202202222222122212222222222120220022212222222021222222220201202212020022200222212022222121212220112221222222200220212222122220022222222222220122212222222222222222112202222202222102221002212221220022202222201020221201121102222221202120122220210020102222022222112021202122202221122222222122220122212222202222222222022202222212222000221022212220021220210222221112220202020022201222202120000121210121122221122222110222202222022201122222212021221122222222202202222222122212222202222200221022222222222022202222210101221201221212210222212122000121200122002222222022021222222122122210002222202020222022212222222202222222122222222222222101220212222220222120222222220021210210121212211221222222200120211121102220222022102011212122122201112222222122222022202222222202222222202202222222222100220102202221020222202222210102212202221022210222202122001122222220002222122122020110202022102202222222202220220022202222202212222222002212222222222120222112202221022021222222220020211221120222210221202021000122222020202220222122122002202222222210222220222121220122212222202202220222122202222222222111222202202220221122222222220202220210020002222220212222000220202020212220222122222012212022022212212221202120220122212222212222221222112212222212222001221202212221220220202222221000122211220112200222222021012220222220222221022022021020202122102201122221202121221222222222202222222222102202222202222220222012202222122221210222200122220210021002210221222021000122210220012220222022010100202122102201112220222220222122222222212212222222022222222212222121222102212221020022202222201111210100220012211222212121102120222222102221122022221011212222212220022221212020220222222222122202222222122212222212222110221122222222222122222222222020121200222112200221212222012221221020222222022122000011202222022200222221222121221022222222112202220222102222222212222122220222202222020221220222202010002211220002222221212021022001201020022222022022221121222122202220202222202020222022212222202222221222022202222202222001221112222221021020210222202010122201221002202222222022112100212220212222122022011101202222021221112221202222220022202222022202221222002212202222222221220022212221122122211222221102121222222022210200222120111100211121222220122222210002222022100220202221222022222122222222122222222222012222202222222010221212212221022121220222221212221202221222200202222121020220220021022220122222122020212122012222122212212022221222212222002202221222112222202202222021222012212220121120222022222211101011021210200202222122202002202221102220122022021001212122001200112220222021222122222222202222222222122212222212222212221012222221121021200222201222120002222012212201212220012010210221102020222022201001202122012211102211212222222022222222212222220222102202222202222200221012202221222222212022221112012121220110210220222222210102221222022021222122202020212122122200212200212021220222212222002222220222112222212212222102221022222222220122201022210222221121222112201220202122012210221120222020222222110100222222022010012210202222221222202222202222222222202222222212222000220202212222220221202122210122020022122011220222222220010102220122102020022222011202222022121100012202202122222222212222112212221222112212212212222221220012212221022122200222212120201001122101200210022021121210211020102122022122102100212122020022022221222120021122212222002222220222002212222222222011220202202121122022212222220021212102122020222212022222212100201022012020022022002122212022012010112212222121020022222222012202220222112212212222222002221112212022022220212122221102101000121122201201012021020202212220112021122022210102222222212011122221212022122022212222112202221222122202212202222121222002212220122221222022201112222012121221222201102020201221221220222022222222021011202022121022212221202220220222212222212212222222212212212202222210221112212121120221220022220002202222020220200210012020020111200221022020222222210102222222211012002201202222121022222222002222221222212202212202222002222022222220220022201222200000212022222001221201002220212222201121102022122222021021212022011012012200202120221222212222022212222222212222212222220112222112212022120121210022202122100221222200221212222120121220220010212121222122111002202122122212002210222020122022212222212202221222002212202022222020222112222021021121212022220201220022121021200202202222221121212221002022122122020101222222201211112220212122221222212222112202221222122222211202221212221102222022221121202122220001220210120012222222112220110122200202112020022022002000222022100222112212222222220022202222122212221222022222002212220221221002222012220020210022210211000112222021221200202222012221201210222221022122200201202122200100022212222220022122212220021202221222102202221002222012221002212121122121200122200021022022021122210212122122000021210202002121122022221111212122111101012212212221220222222222211202222222222212112022220200221102222221222121210222221020020202121220201221112222111020201021222220022122212222222222100101122202202220021222202220100212222222002222020102222110220112212200220120200022201122201202222112211211102022000201221211022220022022212202212022022202202222222221120022212221212202220222112212100202220111220102212112121221220002200211200022020110201210222122210001201220212022222122202200202022200100002212222220022122222222100202221222102202100202221202222002212122022122221202221112220012222020200202112220012010201212112020222222222211222222201022222202202222020022202220200222220222002222122222221120221102222210220121210022210201222000222010210202022121022000210220222222122122122122202122100210102211102222220022212220010222220022112212021222221212221002222022221022222212200220121022221220121210102120011100201101112222122102112121222222110201102201002221122022212222102202222122022202201012222111221202222120221220222012210011001021020100111202202122100120211000202021122102202100202222201111012221012220121122202220202202220022122212012212221212221212212201122222202102201221222122220102201220222021022011212022202020020212222221212022110012002220112221120122212220212212222222022212120102221220221002212100020122201112200001212121222002000221202220111220210022022021020002201120212222011001002212022022220022222220121202221022212202112002220011222100222221121221220122221111002012122101020202122122210110200012002122220212111001212022102112120220112221120122212222101222221122002222222102220022220122222001221121212222200102121111220012001210002112102202220010212120120002122221212122222220000202212022021122202200211222220222112202200012220101220222202122121121110122222001021102221220120211002022120022202022112221122102220202222222022220220200202020221022222201122202220122022202211022201102221210222121220220111202212101101201120012211222012121102011200102122020020012121222202122012111200210012022020022220212011222222022102202200222211202220110212002121021220112222010012021122201022200222002111120220010002121021212112020212222001010212201002121122122010212012212222222202212220202222112220222202222020220101212222211212101222221221201222010101100202222212121221022022201202122121001201222222122121022210222012201222222002222202212201012220202212100022121102012222112000210120011020210112001220002201000122221021222110212212222102002102201002222122122212222221201222122202202210022210220222000202121220120202002210012121021021021210200212001100202201020112122120012112202112122101000000222102222222122102201020200220022122212122102222222221102212101120022212112220000121012121201101211112201221102200002012120221112021212112022020021221202002121220022102220001201220222202222012202201221221000222100120121100122201200121210121211110211012211012010222222002022120222210100002122111101020212102020022022022211101211222122012212212012200012221010202122021122202102211012212112020021220202122111021221021002122020120022121211122122222112021211102222221222000221111211220122202212100012201120220200202122020121122002210202112121122002112221122010102012020200222222222012010200222222120100120210102221121122200201000220222002202222001102210112221002202201120021102022201211001221122021220212222010102122210002122121021102100122122222110220120211122020022022011221201212221012212202021122210021220200222101221122110112210200211121020202001222112221200002111212012021121202111011102002220112202201112122122122001210021211221122222212010102211212220000221212122020121012222221012000022211002202012110202111110020022121220102020012202002002112010211002222221022202221200212220122202202212202211212221201222222220120022212200212020101122021020220002102120121222202122122022002001111102002000120220221022021120022021222211211221212202202210222212020221111210010002020000012222112012111220211020210102220010111112010122220222002211200020022010121000221212121121022011221022222220112202222210022200011220202201022000022011202200010210011021010011221222112101220022111002022222022100202102002202220112222112120021122111222102212222222212202201022200021222121201012102220020222202020112021222021111202102222201111101100202220120102211002212202122021022201112122220222021210111011221002012212101012220201220210201222220120010212220002020002220020002121112022222111111002202121220112022210110112211201000211112221021222210221120002221112022212201012201122221122221011111221002212221122200002022011201122201102112220021010012022120012202220011212211010100201102021220022122212202002220112012222202012222121222021211002020100210111102101212001112021012222211110221100010012010100202111211011211210122021112122010102200110001120212001012100120001010011112210102212020011
"""

let day8Input = rawInput