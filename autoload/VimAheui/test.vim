scriptencoding utf-8

" https://github.com/aheui/snippets

let s:test_case = []

function! VimAheui#test#run()

    call s:prepare()

    let l:success = 0
    let l:failed = 0
    let l:failed_id = []

    for Case in s:test_case
        let l:item = Case()
        let l:result = VimAheui#debugger#execute(join(l:item.code, "\n"), l:item.args)

        if s:isPassed(l:item, l:result)
            let l:success += 1
            echom printf('passed: %30s, elapsed time: %f sec', l:item.id, l:result.time)
        else
            let l:failed += 1
            call add(l:failed_id, l:item.id)
            echom 'failed: ' . l:item.id
            echom 'result: ' . string(l:result)
        endif
    endfor

    echom l:success . '/' . len(s:test_case) . ' success'

    if len(l:failed_id) > 0
        echom 'failed id list : '.string(l:failed_id)
    endif
endfunction

function! s:isPassed(expectItem, resultSet)
    if a:resultSet.out != string(join(a:expectItem.expect, "\n"))
        return 0
    endif
    if has_key(a:expectItem, 'exitCode') && a:expectItem.exitCode != a:resultSet.exitCode
        return 0
    endif
    return 1
endfunction

function! s:case_99bottles()
    " https://github.com/aheui/snippets/blob/master/99bottles/99bottles.aheui
    let l:case = {}
    let l:case.id = '99bottles'
    let l:case.args = []
    let l:case.code = [
        \ '산발발밥따따빠빠빠빠빠빠빠빠빠뿌'
        \,'쑱썴썳썲썱썰썯썮썭뻐뻐뻐뻐뻐뻐뻐'
        \,'쌆쌇쌈쌉쌊쌋쌌쌎반타삱발밦다다숞'
        \,'뚜벌벋섥더너벅벅설더벓섣더떠벆벆'
        \,'다삶박다삷밝반따다삸발반따다삹불'
        \,'숨더더벋떠범범섫더범섪터떠번더벖'
        \,'받타삽밞밪따반다타삿밪발따반다두'
        \,'쑼뻐떠범더벐범섳더벑섲더떠벋벍섰'
        \,'샄반다샅밣밨따수박지민제작붸에엙'
        \,'아아아아아아유붊다뚜샤먕뿌아아아아아'
        \,'뿌섢멓뻐섡빠몋발봆숙오뽀처삭뿌뚫맣숮'
        \,'빠맣맣삳뿌손야몋우바오ㅇㅇ숥차숤뽀뿌'
        \,'뿌서멓뻐맣셜뷁뽀섵모오ㅇㅇ빠뭏뻐솥뭏'
        \,'싺삮반반나타우쀼오속여ㅇㅇ어삱빠뫃숝'
        \,'숢멓뻐섡멓우차솕훍ㅇ요ㅇㅇ오멓뭏뻐뿌'
        \,'뿌빠맣순뽀섵어멓슓오ㅇ어ㅇㅇ뽀설솗멓'
        \,'맣솥먛뻐살빠빠맣뫃ㅇ오ㅇㅇㅇㅇ어지민'
        \,'뉴번번섞썪뻐석멓뻐맣숨오ㅇㅇㅇㅇㅇ어'
        \,'뺘섵맣삱빠맣삸빠뭏뽀뿌ㅇㅇㅇ맣ㅇ불오'
        \,'타초숦멓뻐섢멓뻐섵솛뭏ㅇ숙멓뽀ㅇ뿌초'
        \,'뿌섴빠맣살빠맣샅빠뫃삳빠뽜뫃솤ㅇ두회'
        \,'맣발반따맣삭마반수아숯어바타초ㅇ뭏툐'
        \,'숱멓뻐섡멓섭차붌뼈ㅇ뿌노번번머ㅇ수소'
        \,'빠맣삲빠뭏뚜떠반볎ㅇ맣샅빠맣아오뿌쏘'
        \,'뿌섵멓뻐섡맣삼빠뭏ㅇㅇㅇㅇㅇㅇㅇ숨도'
        \,'맣삵빠맣숞숛썫뻐섪오ㅇㅇㅇㅇㅇ어빠본'
        \,'뭏뻐섡멓뻐받다맣술맣술맣불맣숝오ㅇ어ㅇㅇㅇㅇㅇㅇㅇㅇ어'
        \,'삷빠맣살뿌뿌섵멓뻐뽀뿌뽀뿌또뿌맣숪토맣사마밡밡반다따오'
        \,'숨멓뻐섵멓맣삱빠맣솘맣솥밤또뭏뽀뿌노뽀설멓뻐섧멓뻐섡멓'
        \,'빠맣삸빠뭏숨멓뻐섵멓뻐섨멓뻐섫솘뭏뽀맣살빠맣샅빠맣샂뽀'
        \,'뿌섵멓뻐섮빠맣삸빠맣발빠밤따뚜뫃사본뽀섲멓뻐섡멓뻐섥멓'
        \,'맣산빠맣숫숨멓더번뻐섨멓뻐섵멓뽀섯멓뻐섡멓뻐섧멓뻐섬뽀'
        \,'멓뻐섰멓뻐빠맣삵빠빠맣맣샅빠맣삾빠발다맣삲빠맣샅빠뫃솥']
    let l:case.expect = [
        \ '99 bottles of beer on the wall, 99 bottles of beer.'
        \, 'Take one down and pass it around, 98 bottles of beer on the wall.'
        \, '98 bottles of beer on the wall, 98 bottles of beer.'
        \, 'Take one down and pass it around, 97 bottles of beer on the wall.'
        \, '97 bottles of beer on the wall, 97 bottles of beer.'
        \, 'Take one down and pass it around, 96 bottles of beer on the wall.'
        \, '96 bottles of beer on the wall, 96 bottles of beer.'
        \, 'Take one down and pass it around, 95 bottles of beer on the wall.'
        \, '95 bottles of beer on the wall, 95 bottles of beer.'
        \, 'Take one down and pass it around, 94 bottles of beer on the wall.'
        \, '94 bottles of beer on the wall, 94 bottles of beer.'
        \, 'Take one down and pass it around, 93 bottles of beer on the wall.'
        \, '93 bottles of beer on the wall, 93 bottles of beer.'
        \, 'Take one down and pass it around, 92 bottles of beer on the wall.'
        \, '92 bottles of beer on the wall, 92 bottles of beer.'
        \, 'Take one down and pass it around, 91 bottles of beer on the wall.'
        \, '91 bottles of beer on the wall, 91 bottles of beer.'
        \, 'Take one down and pass it around, 90 bottles of beer on the wall.'
        \, '90 bottles of beer on the wall, 90 bottles of beer.'
        \, 'Take one down and pass it around, 89 bottles of beer on the wall.'
        \, '89 bottles of beer on the wall, 89 bottles of beer.'
        \, 'Take one down and pass it around, 88 bottles of beer on the wall.'
        \, '88 bottles of beer on the wall, 88 bottles of beer.'
        \, 'Take one down and pass it around, 87 bottles of beer on the wall.'
        \, '87 bottles of beer on the wall, 87 bottles of beer.'
        \, 'Take one down and pass it around, 86 bottles of beer on the wall.'
        \, '86 bottles of beer on the wall, 86 bottles of beer.'
        \, 'Take one down and pass it around, 85 bottles of beer on the wall.'
        \, '85 bottles of beer on the wall, 85 bottles of beer.'
        \, 'Take one down and pass it around, 84 bottles of beer on the wall.'
        \, '84 bottles of beer on the wall, 84 bottles of beer.'
        \, 'Take one down and pass it around, 83 bottles of beer on the wall.'
        \, '83 bottles of beer on the wall, 83 bottles of beer.'
        \, 'Take one down and pass it around, 82 bottles of beer on the wall.'
        \, '82 bottles of beer on the wall, 82 bottles of beer.'
        \, 'Take one down and pass it around, 81 bottles of beer on the wall.'
        \, '81 bottles of beer on the wall, 81 bottles of beer.'
        \, 'Take one down and pass it around, 80 bottles of beer on the wall.'
        \, '80 bottles of beer on the wall, 80 bottles of beer.'
        \, 'Take one down and pass it around, 79 bottles of beer on the wall.'
        \, '79 bottles of beer on the wall, 79 bottles of beer.'
        \, 'Take one down and pass it around, 78 bottles of beer on the wall.'
        \, '78 bottles of beer on the wall, 78 bottles of beer.'
        \, 'Take one down and pass it around, 77 bottles of beer on the wall.'
        \, '77 bottles of beer on the wall, 77 bottles of beer.'
        \, 'Take one down and pass it around, 76 bottles of beer on the wall.'
        \, '76 bottles of beer on the wall, 76 bottles of beer.'
        \, 'Take one down and pass it around, 75 bottles of beer on the wall.'
        \, '75 bottles of beer on the wall, 75 bottles of beer.'
        \, 'Take one down and pass it around, 74 bottles of beer on the wall.'
        \, '74 bottles of beer on the wall, 74 bottles of beer.'
        \, 'Take one down and pass it around, 73 bottles of beer on the wall.'
        \, '73 bottles of beer on the wall, 73 bottles of beer.'
        \, 'Take one down and pass it around, 72 bottles of beer on the wall.'
        \, '72 bottles of beer on the wall, 72 bottles of beer.'
        \, 'Take one down and pass it around, 71 bottles of beer on the wall.'
        \, '71 bottles of beer on the wall, 71 bottles of beer.'
        \, 'Take one down and pass it around, 70 bottles of beer on the wall.'
        \, '70 bottles of beer on the wall, 70 bottles of beer.'
        \, 'Take one down and pass it around, 69 bottles of beer on the wall.'
        \, '69 bottles of beer on the wall, 69 bottles of beer.'
        \, 'Take one down and pass it around, 68 bottles of beer on the wall.'
        \, '68 bottles of beer on the wall, 68 bottles of beer.'
        \, 'Take one down and pass it around, 67 bottles of beer on the wall.'
        \, '67 bottles of beer on the wall, 67 bottles of beer.'
        \, 'Take one down and pass it around, 66 bottles of beer on the wall.'
        \, '66 bottles of beer on the wall, 66 bottles of beer.'
        \, 'Take one down and pass it around, 65 bottles of beer on the wall.'
        \, '65 bottles of beer on the wall, 65 bottles of beer.'
        \, 'Take one down and pass it around, 64 bottles of beer on the wall.'
        \, '64 bottles of beer on the wall, 64 bottles of beer.'
        \, 'Take one down and pass it around, 63 bottles of beer on the wall.'
        \, '63 bottles of beer on the wall, 63 bottles of beer.'
        \, 'Take one down and pass it around, 62 bottles of beer on the wall.'
        \, '62 bottles of beer on the wall, 62 bottles of beer.'
        \, 'Take one down and pass it around, 61 bottles of beer on the wall.'
        \, '61 bottles of beer on the wall, 61 bottles of beer.'
        \, 'Take one down and pass it around, 60 bottles of beer on the wall.'
        \, '60 bottles of beer on the wall, 60 bottles of beer.'
        \, 'Take one down and pass it around, 59 bottles of beer on the wall.'
        \, '59 bottles of beer on the wall, 59 bottles of beer.'
        \, 'Take one down and pass it around, 58 bottles of beer on the wall.'
        \, '58 bottles of beer on the wall, 58 bottles of beer.'
        \, 'Take one down and pass it around, 57 bottles of beer on the wall.'
        \, '57 bottles of beer on the wall, 57 bottles of beer.'
        \, 'Take one down and pass it around, 56 bottles of beer on the wall.'
        \, '56 bottles of beer on the wall, 56 bottles of beer.'
        \, 'Take one down and pass it around, 55 bottles of beer on the wall.'
        \, '55 bottles of beer on the wall, 55 bottles of beer.'
        \, 'Take one down and pass it around, 54 bottles of beer on the wall.'
        \, '54 bottles of beer on the wall, 54 bottles of beer.'
        \, 'Take one down and pass it around, 53 bottles of beer on the wall.'
        \, '53 bottles of beer on the wall, 53 bottles of beer.'
        \, 'Take one down and pass it around, 52 bottles of beer on the wall.'
        \, '52 bottles of beer on the wall, 52 bottles of beer.'
        \, 'Take one down and pass it around, 51 bottles of beer on the wall.'
        \, '51 bottles of beer on the wall, 51 bottles of beer.'
        \, 'Take one down and pass it around, 50 bottles of beer on the wall.'
        \, '50 bottles of beer on the wall, 50 bottles of beer.'
        \, 'Take one down and pass it around, 49 bottles of beer on the wall.'
        \, '49 bottles of beer on the wall, 49 bottles of beer.'
        \, 'Take one down and pass it around, 48 bottles of beer on the wall.'
        \, '48 bottles of beer on the wall, 48 bottles of beer.'
        \, 'Take one down and pass it around, 47 bottles of beer on the wall.'
        \, '47 bottles of beer on the wall, 47 bottles of beer.'
        \, 'Take one down and pass it around, 46 bottles of beer on the wall.'
        \, '46 bottles of beer on the wall, 46 bottles of beer.'
        \, 'Take one down and pass it around, 45 bottles of beer on the wall.'
        \, '45 bottles of beer on the wall, 45 bottles of beer.'
        \, 'Take one down and pass it around, 44 bottles of beer on the wall.'
        \, '44 bottles of beer on the wall, 44 bottles of beer.'
        \, 'Take one down and pass it around, 43 bottles of beer on the wall.'
        \, '43 bottles of beer on the wall, 43 bottles of beer.'
        \, 'Take one down and pass it around, 42 bottles of beer on the wall.'
        \, '42 bottles of beer on the wall, 42 bottles of beer.'
        \, 'Take one down and pass it around, 41 bottles of beer on the wall.'
        \, '41 bottles of beer on the wall, 41 bottles of beer.'
        \, 'Take one down and pass it around, 40 bottles of beer on the wall.'
        \, '40 bottles of beer on the wall, 40 bottles of beer.'
        \, 'Take one down and pass it around, 39 bottles of beer on the wall.'
        \, '39 bottles of beer on the wall, 39 bottles of beer.'
        \, 'Take one down and pass it around, 38 bottles of beer on the wall.'
        \, '38 bottles of beer on the wall, 38 bottles of beer.'
        \, 'Take one down and pass it around, 37 bottles of beer on the wall.'
        \, '37 bottles of beer on the wall, 37 bottles of beer.'
        \, 'Take one down and pass it around, 36 bottles of beer on the wall.'
        \, '36 bottles of beer on the wall, 36 bottles of beer.'
        \, 'Take one down and pass it around, 35 bottles of beer on the wall.'
        \, '35 bottles of beer on the wall, 35 bottles of beer.'
        \, 'Take one down and pass it around, 34 bottles of beer on the wall.'
        \, '34 bottles of beer on the wall, 34 bottles of beer.'
        \, 'Take one down and pass it around, 33 bottles of beer on the wall.'
        \, '33 bottles of beer on the wall, 33 bottles of beer.'
        \, 'Take one down and pass it around, 32 bottles of beer on the wall.'
        \, '32 bottles of beer on the wall, 32 bottles of beer.'
        \, 'Take one down and pass it around, 31 bottles of beer on the wall.'
        \, '31 bottles of beer on the wall, 31 bottles of beer.'
        \, 'Take one down and pass it around, 30 bottles of beer on the wall.'
        \, '30 bottles of beer on the wall, 30 bottles of beer.'
        \, 'Take one down and pass it around, 29 bottles of beer on the wall.'
        \, '29 bottles of beer on the wall, 29 bottles of beer.'
        \, 'Take one down and pass it around, 28 bottles of beer on the wall.'
        \, '28 bottles of beer on the wall, 28 bottles of beer.'
        \, 'Take one down and pass it around, 27 bottles of beer on the wall.'
        \, '27 bottles of beer on the wall, 27 bottles of beer.'
        \, 'Take one down and pass it around, 26 bottles of beer on the wall.'
        \, '26 bottles of beer on the wall, 26 bottles of beer.'
        \, 'Take one down and pass it around, 25 bottles of beer on the wall.'
        \, '25 bottles of beer on the wall, 25 bottles of beer.'
        \, 'Take one down and pass it around, 24 bottles of beer on the wall.'
        \, '24 bottles of beer on the wall, 24 bottles of beer.'
        \, 'Take one down and pass it around, 23 bottles of beer on the wall.'
        \, '23 bottles of beer on the wall, 23 bottles of beer.'
        \, 'Take one down and pass it around, 22 bottles of beer on the wall.'
        \, '22 bottles of beer on the wall, 22 bottles of beer.'
        \, 'Take one down and pass it around, 21 bottles of beer on the wall.'
        \, '21 bottles of beer on the wall, 21 bottles of beer.'
        \, 'Take one down and pass it around, 20 bottles of beer on the wall.'
        \, '20 bottles of beer on the wall, 20 bottles of beer.'
        \, 'Take one down and pass it around, 19 bottles of beer on the wall.'
        \, '19 bottles of beer on the wall, 19 bottles of beer.'
        \, 'Take one down and pass it around, 18 bottles of beer on the wall.'
        \, '18 bottles of beer on the wall, 18 bottles of beer.'
        \, 'Take one down and pass it around, 17 bottles of beer on the wall.'
        \, '17 bottles of beer on the wall, 17 bottles of beer.'
        \, 'Take one down and pass it around, 16 bottles of beer on the wall.'
        \, '16 bottles of beer on the wall, 16 bottles of beer.'
        \, 'Take one down and pass it around, 15 bottles of beer on the wall.'
        \, '15 bottles of beer on the wall, 15 bottles of beer.'
        \, 'Take one down and pass it around, 14 bottles of beer on the wall.'
        \, '14 bottles of beer on the wall, 14 bottles of beer.'
        \, 'Take one down and pass it around, 13 bottles of beer on the wall.'
        \, '13 bottles of beer on the wall, 13 bottles of beer.'
        \, 'Take one down and pass it around, 12 bottles of beer on the wall.'
        \, '12 bottles of beer on the wall, 12 bottles of beer.'
        \, 'Take one down and pass it around, 11 bottles of beer on the wall.'
        \, '11 bottles of beer on the wall, 11 bottles of beer.'
        \, 'Take one down and pass it around, 10 bottles of beer on the wall.'
        \, '10 bottles of beer on the wall, 10 bottles of beer.'
        \, 'Take one down and pass it around, 9 bottles of beer on the wall.'
        \, '9 bottles of beer on the wall, 9 bottles of beer.'
        \, 'Take one down and pass it around, 8 bottles of beer on the wall.'
        \, '8 bottles of beer on the wall, 8 bottles of beer.'
        \, 'Take one down and pass it around, 7 bottles of beer on the wall.'
        \, '7 bottles of beer on the wall, 7 bottles of beer.'
        \, 'Take one down and pass it around, 6 bottles of beer on the wall.'
        \, '6 bottles of beer on the wall, 6 bottles of beer.'
        \, 'Take one down and pass it around, 5 bottles of beer on the wall.'
        \, '5 bottles of beer on the wall, 5 bottles of beer.'
        \, 'Take one down and pass it around, 4 bottles of beer on the wall.'
        \, '4 bottles of beer on the wall, 4 bottles of beer.'
        \, 'Take one down and pass it around, 3 bottles of beer on the wall.'
        \, '3 bottles of beer on the wall, 3 bottles of beer.'
        \, 'Take one down and pass it around, 2 bottles of beer on the wall.'
        \, '2 bottles of beer on the wall, 2 bottles of beer.'
        \, 'Take one down and pass it around, 1 bottle of beer on the wall.'
        \, '1 bottle of beer on the wall, 1 bottle of beer.'
        \, 'Take one down and pass it around, no more bottles of beer on the wall.'
        \, 'No more bottles of beer on the wall, no more bottles of beer.'
        \, 'Go to store and buy some more, 99 bottles of beer on the wall.'
        \, '']
    return l:case
endfunction

function! s:case_99dan()
    " https://github.com/aheui/snippets/blob/master/99dan/99dan.aheui
    let l:case = {}
    let l:case.id = '99dan'
    let l:case.args = []
    let l:case.code = [
        \  '삼바반빠빠빠빠빠빠아아우'
        \, '우어어번벋범벌벖벍벓벒석'
        \, '삭싿삳빠빠빠빠빠빠빠빠술'
        \, '초섬어어어어쑫썽뻐선썽부'
        \, '숭밝밦따뭏오삳따쌍술뽀분'
        \, '망속숙멍성오어어어차솓뿌'
        \, '송어밢밦따밝다맣상뭉노뿌'
        \, 'ㄹ모뻐희셩멓떠벌번선뽀뿌'
        \, '최종찬만듦밦발밤받반뽀뿌'
        \, '유덕남고침볽벓벒선뻐뻐뻐']
    let l:case.expect = [
        \  '2*1=2', '2*2=4', '2*3=6', '2*4=8', '2*5=10', '2*6=12', '2*7=14', '2*8=16', '2*9=18'
        \, '3*1=3', '3*2=6', '3*3=9', '3*4=12', '3*5=15', '3*6=18', '3*7=21', '3*8=24', '3*9=27'
        \, '4*1=4', '4*2=8', '4*3=12', '4*4=16', '4*5=20', '4*6=24', '4*7=28', '4*8=32', '4*9=36'
        \, '5*1=5', '5*2=10', '5*3=15', '5*4=20', '5*5=25', '5*6=30', '5*7=35', '5*8=40', '5*9=45'
        \, '6*1=6', '6*2=12', '6*3=18', '6*4=24', '6*5=30', '6*6=36', '6*7=42', '6*8=48', '6*9=54'
        \, '7*1=7', '7*2=14', '7*3=21', '7*4=28', '7*5=35', '7*6=42', '7*7=49', '7*8=56', '7*9=63'
        \, '8*1=8', '8*2=16', '8*3=24', '8*4=32', '8*5=40', '8*6=48', '8*7=56', '8*8=64', '8*9=72'
        \, '9*1=9', '9*2=18', '9*3=27', '9*4=36', '9*5=45', '9*6=54', '9*7=63', '9*8=72', '9*9=81'
        \, '']
    return l:case
endfunction

function! s:case_bahmanghui()
    " https://github.com/aheui/snippets/tree/master/bahmanghui
    let l:case = {}
    let l:case.id = 'bahmanghui'
    let l:case.args = ['밯']
    let l:case.code = ['밯망희']
    let l:case.expect = ['48175']
    return l:case
endfunction

function! s:case_fibonacci()
    " https://github.com/aheui/snippets/blob/master/fibonacci/fibonacci.codroc.aheui
    let l:case = {}
    let l:case.id = 'fibonacci'
    let l:case.args = []
    let l:case.code = [
        \ '반반나빠빠쌈다빠망빠쌈삼파싸사빠발발밖따따쟈하처우'
        \,'ㅇㅇㅇㅇㅇㅇ오어어어어어어어어어어어어어어어어어어']
    let l:case.expect = ['23581321345589144233']
    return l:case
endfunction

function! s:case_helloworld()
    " https://github.com/aheui/snippets/blob/master/hello-world/hello-world.puzzlet.aheui
    let l:case = {}
    let l:case.id = 'helloworld'
    let l:case.args = []
    let l:case.code = [
        \ '밤밣따빠밣밟따뿌'
        \,'빠맣파빨받밤뚜뭏'
        \,'돋밬탕빠맣붏두붇'
        \,'볻뫃박발뚷투뭏붖'
        \,'뫃도뫃희멓뭏뭏붘'
        \,'뫃봌토범더벌뿌뚜'
        \,'뽑뽀멓멓더벓뻐뚠'
        \,'뽀덩벐멓뻐덕더벅']
    let l:case.expect = ['Hello, world!', '']
    return l:case
endfunction

function! s:case_hello()
    " https://github.com/aheui/snippets/blob/master/hello-world/hello.puzzlet.aheui
    let l:case = {}
    let l:case.id = 'hello'
    let l:case.args = []
    let l:case.code = [
        \ '어듀벊벖버범벅벖떠벋벍떠벑번뻐버떠뻐벚벌버더벊벖떠벛벜버버'
        \,'　ㅇ　　ㅏㄴㄴㅕㅇ　　ㅎ　　ㅏ　ㅅ　　ㅔ　ㅇ　　ㅛ　　　\0'
        \,'　뿌멓더떠떠떠떠더벋떠벌뻐뻐뻐'
        \,'붉차밠밪따따다밠밨따따다　박봃'
        \,'받빠따따맣반발따맣아희～']
    let l:case.expect = ['안녕하세요?', '']
    return l:case
endfunction

function! s:case_32bit_integer()
    " https://github.com/aheui/snippets/blob/master/integer/32bit.aheui
    let l:case = {}
    let l:case.id = '32bit integer'
    let l:case.args = []
    let l:case.code = [
        \ '삭반사밣밣따뿌'
        \,'분ㅇㅇ희멍석차'
        \,'타삭반ㅇ따사뽀'
        \,''
        \,'구현체의 정수 범위를 확인하기 위한 예제입니다.'
        \,'2^33을 제대로 출력할 수 있는지 확인합니다.']
    let l:case.expect = [8589934592]
    return l:case
endfunction

function! s:case_64bit_integer()
    " https://github.com/aheui/snippets/blob/master/integer/64bit.aheui
    let l:case = {}
    let l:case.id = '64bit integer'
    let l:case.args = []
    let l:case.code = [
        \ '삭반사밣밣따빠다뿌'
        \,'분ㅇㅇㅇㅇ희멍석차'
        \,'타삭반ㅇㅇㅇ따사뽀'
        \,''
        \,'구현체의 정수 범위를 확인하기 위한 예제입니다.'
        \,'2^65을 제대로 출력할 수 있는지 확인합니다.']
    let l:case.expect = [36893488147419103232]
    return l:case
endfunction

function! s:case_ha_ut()
    " https://github.com/aheui/snippets/blob/master/literary/ha-ut.aheui
    let l:case = {}
    let l:case.id = 'ha-ut'
    let l:case.args = []
    let l:case.code = ['삶은밥과야근밥샤주세양♡밥사밥사밥사밥사밥사땅땅땅빵☆따밦내발따밦다빵맣밥밥밥내놔밥줘밥밥밥밗땅땅땅박밝땅땅딻타밟타맣밦밣따박타맣밦밣따박타맣밦밣따박타맣박빵빵빵빵따따따따맣희']
    let l:case.expect = ['하읏... ']
    return l:case
endfunction

function! s:case_pokryong()
    " https://github.com/aheui/snippets/blob/master/literary/pokryong.aheui
    let l:case = {}
    let l:case.id = 'pokryong'
    let l:case.args = [1024]
    let l:case.code = [
        \ '육체는　단명하고'
        \,'근성은　영원한것'
        \,'방산반밧나뿌서어뎐근성'
        \,'대류…분선창사반나산분'
        \,'폭룡이탄뭉폭룡의뇨시볏'
        \,'최고다아하＃김끼룩제작']
    let l:case.expect = [10]
    return l:case
endfunction

function! s:case_ddeok()
    " https://github.com/aheui/snippets/blob/master/literature/ddeok.out
    let l:case = {}
    let l:case.id = 'ddeok'
    let l:case.args = []
    let l:case.code = ['발냄새엔 망개떡 밤삶으면 홍두깨떡']
    let l:case.expect = [1]
    return l:case
endfunction

function! s:case_hammer()
    " https://github.com/aheui/snippets/blob/master/literature/hammer.aheui
    let l:case = {}
    let l:case.id = 'hammer'
    let l:case.args = []
    let l:case.code = ['바쁜 망치에 흘린 못 없다']
    let l:case.expect = [0]
    return l:case
endfunction

function! s:case_sijo_div()
    " https://github.com/aheui/snippets/blob/master/literature/sijo-div.aheui
    let l:case = {}
    let l:case.id = 'sijo-div'
    let l:case.args = [249, 12]
    let l:case.code = [
        \ '첩첩산 방방곡곡 굽굽이 찾아들어'
        \,'겹겹골 심심봉봉 둘둘러 돌아들어'
        \,'아희야 하늘나리가 멍멍하게 피누나']
    let l:case.expect = [20]
    return l:case
endfunction

function! s:case_sweat()
    " https://github.com/aheui/snippets/blob/master/literature/sweat.aheui
    let l:case = {}
    let l:case.id = 'sweat'
    let l:case.args = []
    let l:case.code = [
        \ '발받악에 땀 망희 났어'
        \, ''
        \,'http://comic.naver.com/webtoon/detail.nhn?titleId=678499&no=15&weekday=fri']
    let l:case.expect = [15]
    return l:case
endfunction

function! s:case_quine_puzzlet()
    " https://github.com/aheui/snippets/blob/master/quine/quine.puzzlet.aheui
    let l:case = {}
    let l:case.id = 'quine.puzzlet'
    let l:case.args = []
    let l:case.code = [
        \ '버분벗벖벓법벌벋벖법벍벋벌벋벌벗벌벍벌벋벗벓벖법벌벋벖벌벗벓벌벋벗벌벗벓벌벋벖벋벓벋벌벋벗벓벖법벌벋벌법법벓벌벋벗벖벓법벌벋벖법벍벋벌벋벌벗벖벓벌벋버벖법벍벋벌벋벒벋벓벓벌벋벖벍벍벌벍벋벗법벌벒벌벋벗벋법벓벌벋벖벋벓벋벌벋벖벓벖벍벌벋벗벌법벓벖벋벒벋벓벓벌벋벌벋벌벓벌벋벖벖벌벋벌벋벗벌벒법벌벋벗벍벍법벌벋버벗벓벗벋벖벋벗법벗벌벌벋벖벌벗벓벌벋벖벌벗벓벌벋벗벍벗벓벖벋벗벗벍벒벌벋벗벋벒벌벖벋벌벖벗벓벌벋벖벌벋법벍벋벖벋벖벋벍벋버벖벍벒벋벍벋벗벗벌벗벍벋벗벌벗벓벌벋벖벌벋벖벌벋벌벌벗벓벌벋벗벒벍벗벌벋벗벒벌벓벌벋벗법벋벓벌벋벖벋벒벒벌벋벗벋법벓벌벋벗벖벓벗벍벋버벖벋벓벗벖벋벗벒벌벋벖벋벗벖벓벗벍벋벖벗벒벋벌벋벌벖벗벓벌벋벋벖벗벓벌벋벗법벋법벌벋벖벖벗벓벌벋벖벍벒벌벌벋벗벋벖벓벖벋벖법벓벓벖벋벗벖벋벒벌벋벖벍벌법벖벋버벖벖벌벋벌벋벖벋벒벒벌벋벍벗벌벗벖벋벖벖벌벋벌벋벖벒벍법벖벋벓벌벋벓벌벋벖벒벍법벖벋벗법벌벗벌벋벖벒벍법벖벋벗법벋벓벌벋벖벒벍법벖벋벖벒벗벗벖벋벌벖벒벖벌벋버벒법법벓벌벋벖법벍벋벌벋벗법벌벒벌벋벋벗벓벋벖벋벗법벌벒벌벋벌법벋벍벌벋벌법법벓벌벋벌법법벓벌벋벖법법벓벌벋벗벖벓법벌벋벗벖벓법벌벋벗법벋법벌벋버벖벌법벌벌벋벗벗벌벗벍벋벋벖벗벓벌벋벗벓벖법벌벋벗벓벖법벌벋벌벖벗벓벌벋벗벖벗벓벌벋벗벖벗벓벌벋벗벓벖법벌벋벗벓벖법벌벋벒벋법벓벌벋벗벌벋벓벌벋'
        \,'뱘벏따따밠밠밣따따밡타뚜'
        \,'두떠떠범벓벓멓뻐쎁뻐더벗'
        \,'맣쀼야뱐야냐야뱞야다샅뿌다'
        \,'쓬빠추초러밤두밡밣도토싸소'
        \,'토번뿌뱐본노받로반타포'
        \,'파표밣쟈뽀차발발또숰'
        \,'땨뗘다볋붏처무뎌번뻐희붏더'
        \,'봃더떠벓따뎌반발따뫃더떠']
    let l:case.expect = l:case.code
    return l:case
endfunction

function! s:case_quine_puzzlet_40col()
    " https://github.com/aheui/snippets/blob/master/quine/quine.puzzlet.40col.aheui
    let l:case = {}
    let l:case.id = 'quine.puzzlet.40col'
    let l:case.args = []
    let l:case.code = [
        \ '상밢밢밣밦발받밧밥밣밦밦받밦밢밝받밝받밦밧밢받발받밧밣밦밥발받밝밥밧밦밦받밧받붑'
        \,'붇벌벖벒벖벌벋벖법벍벒벖벋벍벌벍벍벖버벋벌벍벌벗벌벋벌법벓벖벗벋벌벓법벋벖벋벌벓'
        \,'밦밦발받발받밧밣밦밥발받발밦밧밣발받밦밦발받발받밧밣밦밥발받발밦밧밣발받밦밦발붇'
        \,'붉벗벋벌벓벓벋벒벋벌벓벗벖벌벋벌법벖벓벗벋벌벋벌벖벖벋벌벓벗벖벌벋벌법벖벓벗벋벌'
        \,'밧밣밦받밦밣밦밝발받밧받밢발밦받밦밥밧밣발받밧밦받밢발받바밦밝밢밥밦받밧밧발밣불'
        \,'붒벓벍벋벌벋벍법벖벋벖법벒벍벖벋벌벓벌벋벓벋벖법벒벍벖벋벌벗벍벗벗벋벖법벒벍벖벋'
        \,'밧밦받밧받밦밢발받밦밧밢받발받밧밝밝받밦받밦밦발밧밦받바밧밝밝받밦받밦받밣밧밦붇'
        \,'붏법법벋벋벌벋벒벗벖벋벌벓법법벖벋벌벌벍벒벖벋벖벓벓법벖벋벖벓벖벋벗벋벌벒벌법벗'
        \,'발받발밥밥밣발받밧밥받밥발받밦밝밧받밝받밧밢발밣발받밝밝밥밧밦받밦밥밥밣발받밦붏'
        \,'불벓벓벗벖벋벌벓벌벗벗벋벌벒벍벗벗벋벖법벋벒벖벋벌벒벍벗벗벋벖벋벗벍벍버벋벌벓벍'
        \,'받밦밧밧받발받발받밥밣발받밧밝발밦발받밧받밥밣발받밧밣밦밧밝받밧밢받밥밝받밧밦붏'
        \,'붇벌벓법법벌벋벍벋벗벍벖벋벌벓법벋벗버벋벌벋벍법벖벋벖벋벓벓벗벋벖벗벖벌벖벋벍벗'
        \,'밧밢밧밦밦받밦받밢밢발받밧발밥밣밦받밦받밥밣발받밦받밥밣발받밦발밥발발받밧받밥붏'
        \,'붓벋벌벌벗법벗버벋벌벌벗법벗벋벌벓벒벒벋벋벖벓벓법벖벋벌벒법벌벗벋벖벖벗벒벗벋벌'
        \,'밣밦밥발받밦밦밧밣발받밦밦밧밣발받밝발밧밣발받밝밧발밧밦받발밥받밝발받밦밧밝밥붒'
        \,'붓벌벍벋벌벓벗벖벖벋벌법벖벓벗벋벌법벖벓벗벋벌벋벌벖벖벋벖벋벖벋벗벋벖벗벌벓벖벋'
        \,'밣발받밦발밦밧밦받밣밥받밣발받밦받밦발발받바밧밢발밣발받밧밧발밧밝받밦밧밢받발붇'
        \,'붑벍벒벖벋벌벋벌벖벖벋벖벗벌벗벍벋벌벒벍벗벗벋벌벓벗벖벓벋벌벓벋법벍벋벌법벒벌벗'
        \,'밦받밣발받밣발받밦밢밝밥밦받밧밥발밧발받밦밢밝밥밦받밧밥받밣발받밦밢밝밥밦받발붑'
        \,'불벓벓법벗벋벌벌벗법벗벋벌벓벋법벖벋벌벓벌벒벖버벋벌법벍벍벗벋벖벋법벖벋벋벌벍벋'
        \,'받밧밧밝밢발받받밦밧밣발받밧발밢받밦받밦밝밧받밝받밧밥받밥발받발밦밧밣발받받밦붓'
        \,'붓벋벌벒벋벖벗벋벖벓벖벋벗벋벖벓벓법벖벋벌벌벒벍벖벋벌벓벗벖벖벋벌벋벒벗벖벋벌벓'
        \,'밣밣밢발받밦밧밣밣발받바밧밣밧받밦받밧밥밧발발받밢받밝밝발받밦밦발받발받받받밣붏'
        \,'붉벗벋벌벓벗벌벗벋벍벗벌벗벗벋벍법벋벒벗벋벖벗벓벋벖벋벌벒벒벋벖벋벌벌벗법벗벋벌'
        \,'발밦발받발발밧밣발받밦밧밧받발받밦밧밣밣발받밧밥받밣발받밧밧밝밢발받밦밢받밥밦붇'
        \,'붎벋벗벋벖벋벗벌벗벋벖벓법벌벗벋벖벗법벍벖벋벌벖벒벖벌버벋벖벋벌벒벗벋벖벋벗벌벗'
        \,'발밦받밧밥받밥발받밦받밣받발받밧밥받밣발받밝밝밥밧밦받밦발밥발발받밦발밧밣발받붒'
        \,'불벓벗벌벗벋벍벋벗벍벖벋벌벓벗벖벌벋벖벌벒벋벗벋벌벒벒벋벖벋벖벓벗벍벗벋벌벓벗벌'
        \,'받밝밝밧받밦받바밧밦밣밥발받밧밦밣밥발받받받밥밣발받밧밣밦밧밝받발밥받밝발받밝붏'
        \,'붇벌벒벌법벗벋벍벗벖벓벗벋벌벓법벋벗벋벌법벓벖벗벋벌벒벌법벗벋벌벓법벋벖벋벖벗벖'
        \,'밧밦밣밥발받밣밥밥밣발받밝받밥밣발받밦밥밝받발받밧밦밣밥발받밝받밥밣발받밧밦밣붑'
        \,'불벋벌벓벗벌벗벋벌법벖벓벗벋벌법벖벓벗벋벌벌법벌벖버벋벌법벋법벗벋벌벓법벋벓벋벌'
        \,'발밧밣발받받발밧밣발받받발밧밣발받밝발밧밣발받밧밧발밧밝받밧발밧밣발받밧밣밦밥불'
        \,'붑벍벖벋벌벓벗벌벌벋벖벋벌벒벋벋벌벓벗법벖벋벖벋벌벒법벋벌벓벗벌벍벋벌벒벋벖벗벋'
        \,'밧밦받사받싹바싺밝빠따반타밝밙밙받반따따뚜'
        \,'두벎떠벍떠더벍벖떠뻐터번떠뻐벌섵멓터벉떠떠'
        \,'숭반투밣쟈뿌차발발뚜삭뱐뎌두쟈수처사맣'
        \,'싸수쑼뽀뱐분누받루반타푸소뿌또붉다뭏또숰'
        \,'분뾰빠초추러밤도밡밣두투쏘밡뽀붐또뱔볼'
        \,'땨슡멓야뱐야냐야뱞야다샅뽀밦뱕뗘도타본'
        \,'뜌뱖서밝밤따따다쌈샴아멓샅밝밤밤따또'
        \,'또뷹추뺘져번뚜벌벌처뿌져벓투번'
        \,'더쎰서토푸터번루벋누분변뽀쑼뽀숭'
        \,'뵴범삭본투두벓벑도범라추초뻐소써'
        \,'샤써도뼈섵더여볎여녀여변여'
        \,'빠바쟈무차붏밣따다밣따다밣따다밣따다맣야희'
        \,'뫃떠벌번정따도퍼즐릿']
    let l:case.expect = l:case.code
    return l:case
endfunction

function! s:case_standard_bieup_char()
    " https://github.com/aheui/snippets/blob/master/standard/bieup-char.aheui
    let l:case = {}
    let l:case.id = 'standard/bieup-char'
    let l:case.args = ['1', '+', '한', '글', '😃', '😄']
    let l:case.code = ['밯맣밯맣밯맣밯맣밯맣밯맣희']
    let l:case.expect = ['1+한글😃😄']
    return l:case
endfunction

function! s:case_standard_bieup_sign()
    " https://github.com/aheui/snippets/blob/master/standard/bieup-sign.aheui
    let l:case = {}
    let l:case.id = 'standard/bieup-sign'
    let l:case.args = [0, 42, -42]
    let l:case.code = ['방망방망방망희']
    let l:case.expect = ['042-42']
    return l:case
endfunction

function! s:case_standard_bieup()
    " https://github.com/aheui/snippets/blob/master/standard/bieup.aheui
    let l:case = {}
    let l:case.id = 'standard/bieup'
    let l:case.args = ['밯', 3]
    let l:case.code = [
        \ '박반받발밤밥밧밪밫밬밭붚'
        \,'뭉멍멍멍멍멍멍멍멍멍멍멍'
        \,'밖밗밙밚밝밞밟밠밡밢밣밦붔'
        \,'뭉멍멍멍멍멍멍멍멍멍멍멍멍'
        \,'밯망방망희'
        \,''
        \,'ㅂ에 ㅇ받침이 있으면 입력받은 숫자를, ㅎ받침이 있으면 입력받은 문자의 유니코드 코드값을 저장공간에 집어넣습니다. 단, ㅂ의 경우 나머지 받침이 있으면 그 받침을 구성하는 선의 수에 따른 값을 집어넣습니다. 받침이 없으면 0을 집어넣습니다.']
    let l:case.expect = ['4434324453224689979975544481753']
    return l:case
endfunction

function! s:case_standard_border()
    " https://github.com/aheui/snippets/blob/master/standard/border.aheui
    let l:case = {}
    let l:case.id = 'standard/bieup'
    let l:case.args = []
    let l:case.code = [
        \ '볻         망볿'
        \,'ㅇ         ㅇ희'
        \,'멍         붒'
        \,'ㅇ         ㅇ몽'
        \,''
        \,''
        \,'                  표준: 코드 공간의 한 쪽 끝에 다다르면 커서는 반대편 끝으로 이동합니다. 이는 Funge-98의 wrapping algorithm과 동일합니다.']
    let l:case.expect = [369]
    return l:case
endfunction

function! s:case_standard_chieut()
    " https://github.com/aheui/snippets/blob/master/standard/chieut.aheui
    let l:case = {}
    let l:case.id = 'standard/chieut'
    let l:case.args = []
    let l:case.code = [
        \ '아ㅇㅇ부'
        \,'희멍번처붇'
        \,'ㅇㅇㅇ분멍'
        \,'희멍번차붇'
        \,'ㅇㅇㅇ희멍'
        \,''
        \,'ㅊ은 조건 명령으로 저장공간에서 값 하나를 뽑아내서 그 값이 0이 아니면 홀소리의 방향대로, 0이면 그 반대 방향대로 갑니다.']
    let l:case.expect = [33]
    return l:case
endfunction

function! s:case_standard_default_direction()
    " https://github.com/aheui/snippets/blob/master/standard/default-direction.aheui
    let l:case = {}
    let l:case.id = 'standard/default-direction'
    let l:case.args = []
    let l:case.code = [
        \ '뵐망희'
        \,'마본'
        \,''
        \,'커서는 코드 공간의 맨 첫 줄 맨 첫 번째 칸에서 시작합니다. 가장 첫 칸에 커서의 방향이 지정되어 있지 않을 경우 커서는 기본값인 아랫쪽으로 이동합니다.']
    let l:case.expect = [2]
    return l:case
endfunction

function! s:case_standard_default_storage()
    " https://github.com/aheui/snippets/blob/master/standard/default-storage.aheui
    let l:case = {}
    let l:case.id = 'standard/default-storage'
    let l:case.args = []
    let l:case.code = [
        \ '밞산바삳바사망희'
        \,''
        \,'처음에 선택되어 있는 스택은 (받침 없음) 스택입니다. (“사” 와 같은 명령으로 선택할 수 있습니다.)']
    let l:case.expect = [9]
    return l:case
endfunction

function! s:case_standard_digeut()
    " https://github.com/aheui/snippets/blob/master/standard/digeut.aheui
    let l:case = {}
    let l:case.id = 'standard/digeut'
    let l:case.args = []
    let l:case.code = [
        \ '반받다망희'
        \,''
        \,'ㄷ은 덧셈 명령으로 저장공간에서 두 값을 뽑아낸 다음 둘을 더한 값을 저장공간에 집어넣습니다.']
    let l:case.expect = [5]
    return l:case
endfunction

function! s:case_standard_emptyswap()
    " https://github.com/aheui/snippets/blob/master/standard/emptyswap.aheui
    let l:case = {}
    let l:case.id = 'standard/emptyswap'
    let l:case.args = []
    let l:case.code = [
        \ '뱐희파반망희'
        \,''
        \,'연산에 필요한 충분한 갯수의 값이 저장공간에 저장되어 있지 않은 경우, 커서는 그 명령을 실행하지 않고 진행해야 할 방향의 반대방향으로 움직입니다.'
        \,''
        \,'종료만 제외하고, 중복과 바꿔치기 명령을 포함한 모든 뽑아내기를 쓰는 명령에 해당합니다.']
    let l:case.expect = []
    let l:case.exitCode = 2
    return l:case
endfunction

function! s:case_standard_exhausted_storage()
    " https://github.com/aheui/snippets/blob/master/standard/exhausted-storage.aheui
    let l:case = {}
    let l:case.id = 'standard/exhausted-storage'
    let l:case.args = []
    let l:case.code = [
        \ '아ㅇㅇ우'
        \,'희멍벋망반망희'
        \,''
        \,'중복 명령을 포함한 모든 뽑아내기를 쓰는 명령에서 저장 공간에 값이 모자랄 경우, 커서는 그 명령을 실행하지 않고 커서가 있는 글자의 홀소리의 반대방향으로 움직입니다.']
    let l:case.expect = [3]
    return l:case
endfunction

function! s:case_standard_exitcode()
    " https://github.com/aheui/snippets/blob/master/standard/exitcode.aheui
    let l:case = {}
    let l:case.id = 'standard/exitcode'
    let l:case.args = []
    let l:case.code = [
        \ '반월회'
        \,''
        \,'ㅎ은 끝냄 명령으로 커서의 실행을 끝냅니다. 이 때 스택에서 맨 위 값을 뽑아서 운영체제에 돌려 줍니다.']
    let l:case.expect = []
    let l:case.exitCode = 2
    return l:case
endfunction

function! s:case_standard_hieut_pop()
    " https://github.com/aheui/snippets/blob/master/standard/hieut-pop.aheui
    let l:case = {}
    let l:case.id = 'standard/hieut-pop'
    let l:case.args = []
    let l:case.code = [
        \ '하멍번버'
        \,''
        \,''
        \,'ㅎ은 끝냄 명령으로 커서의 실행을 끝냅니다. 이 때 현재 선택된 저장 공간에 값이 하나 이상 남아 있으면 ㅁ 명령으로 뽑아낼 수 있는 값을 뽑아내 운영체제에 돌려 줍니다. 저장 공간이 비어 있으면 0을 돌려줍니다.'
        \,''
        \,'저장 공간이 비어 있더라도 커서의 실행은 끝냅니다. 반대 방향으로 이동하지 않습니다.']
    let l:case.expect = []
    return l:case
endfunction

function! s:case_standard_ieunghieut()
    " https://github.com/aheui/snippets/blob/master/standard/ieunghieut.aheui
    let l:case = {}
    let l:case.id = 'standard/ieunghieut'
    let l:case.args = []
    let l:case.code = [
        \ '아악안앋압알앗았앜앇헐'
        \,''
        \,'ㅇ은 없음 명령으로 아무 일도 하지 않습니다. * ㅎ은 끝냄 명령으로 커서의 실행을 끝냅니다.'
        \,'사용되지 않는 받침은 모두 무시됩니다.']
    let l:case.expect = []
    return l:case
endfunction

function! s:case_standard_jieut()
    " https://github.com/aheui/snippets/blob/master/standard/jieut.aheui
    let l:case = {}
    let l:case.id = 'standard/jieut'
    let l:case.args = []
    let l:case.code = [
        \ '반반자망받반자망반받자망희'
        \,''
        \,'ㅈ은 비교 명령으로 저장공간에서 값 두 개를 뽑아 내서 비교합니다. 나중에 뽑아낸 값이 더 크거나 같으면 1을, 아니면 0을 지금 저장공간에 집어넣습니다.']
    let l:case.expect = [110]
    return l:case
endfunction

function! s:case_standard_loop()
    " https://github.com/aheui/snippets/blob/master/standard/loop.aheui
    let l:case = {}
    let l:case.id = 'standard/loop'
    let l:case.args = []
    let l:case.code = [
        \ '밦밦따빠뚜'
        \,'뿌뚜뻐뚜뻐'
        \,'따ㅇㅇㅇ우'
        \,'ㅇㅇ아ㅇ분'
        \,'ㅇㅇ초뻐터'
        \,'ㅇㅇ망희']
    let l:case.expect = [0]
    return l:case
endfunction

function! s:case_standard_mieum()
    " https://github.com/aheui/snippets/blob/master/standard/mieum.aheui
    let l:case = {}
    let l:case.id = 'standard/mieum'
    let l:case.args = []
    let l:case.code = [
        \ '바반받밤발밦밠밣밞망만맘말망맋맠맟망희'
        \,''
        \,'ㅁ에 ㅇ받침이 있으면 저장공간에서 뽑아낸 값을 숫자로, ㅎ받침이 있으면 그 값에 해당하는 유니코드 문자로 출력합니다. 나머지 받침은 뽑아낸 값을 그냥 버립니다.']
    let l:case.expect = [950]
    return l:case
endfunction

function! s:case_standard_nieun()
    " https://github.com/aheui/snippets/blob/master/standard/nieun.aheui
    let l:case = {}
    let l:case.id = 'standard/nieun'
    let l:case.args = []
    let l:case.code = [
        \ '밟받나망희'
        \,''
        \,'ㄴ은 나눗셈 명령으로 저장공간에서 두 값을 뽑아낸 다음 나중 값에서 먼저 값을 나눈 값을 저장공간에 집어넣습니다.']
    let l:case.expect = [3]
    return l:case
endfunction

function! s:case_standard_pieup()
    " https://github.com/aheui/snippets/blob/master/standard/pieup.aheui
    let l:case = {}
    let l:case.id = 'standard/pieup'
    let l:case.args = []
    let l:case.code = [
        \ '바밟밟땅밝밝땅팡망망우'
        \,'숭ㅇㅇㅇㅇㅇㅇㅇㅇㅇ어'
        \,'밟밟밝밝땅땅바팡망망희'
        \,''
        \,'ㅍ은 바꿔치기 명령입니다. 지금 저장공간이 스택이라면 맨 위 값과 그 바로 아래 값을, 큐라면 맨 앞의 값과 그 바로 뒤 값을 바꿉니다.']
    let l:case.expect = [81494981]
    return l:case
endfunction

function! s:case_standard_print()
    " https://github.com/aheui/snippets/blob/master/standard/print.aheui
    let l:case = {}
    let l:case.id = 'standard/print'
    let l:case.args = []
    let l:case.code = [
        \ '밞밞반다따반타뭉'
        \,'ㅇㅇㅇㅇㅇㅇㅇ밞밞반다따반타맣희'
        \,''
        \,'ㅁ에 ㅇ받침이 있으면 저장공간에서 뽑아낸 값을 숫자로, ㅎ받침이 있으면 그 값에 해당하는 유니코드 문자로 출력합니다.']
    let l:case.expect = ['97a']
    return l:case
endfunction

function! s:case_standard_queue()
    " https://github.com/aheui/snippets/blob/master/standard/queue.aheui
    let l:case = {}
    let l:case.id = 'standard/queue'
    let l:case.args = []
    let l:case.code = [
        \ '상반받뱔우망이'
        \,'뭉뻐벋번성'
        \,'망망희']
    let l:case.expect = [235223]
    return l:case
endfunction

function! s:case_standard_rieul()
    " https://github.com/aheui/snippets/blob/master/standard/rieul.aheui
    let l:case = {}
    let l:case.id = 'standard/rieul'
    let l:case.args = []
    let l:case.code = [
        \ '밟발라망희'
        \,''
        \,'ㄹ은 나머지 명령으로 저장공간에서 두 값을 뽑아낸 다음 나중 값에서 먼저 값을 나눈 나머지를 저장공간에 집어넣습니다.']
    let l:case.expect = [4]
    return l:case
endfunction

function! s:case_standard_shebang()
    " https://github.com/aheui/snippets/blob/master/standard/shebang.aheui
    let l:case = {}
    let l:case.id = 'standard/shebang'
    let l:case.args = []
    let l:case.code = [
        \ '#!/usr/bin/env aheui'
        \,'반망희'
        \,''
        \,'표준: 커서는 코드 공간의 맨 첫 줄 맨 첫번째 칸에서 시작합니다. 맨 처음에 홀소리가 없을 경우 커서는 기본값으로 아랫쪽으로 이동하는데, 이는 #!과 호환시키기 위한 것으로, 기본 방향이 오른쪽인 funge와는 다른 점입니다.']
    let l:case.expect = [2]
    return l:case
endfunction

function! s:case_standard_ssangbieup()
    " https://github.com/aheui/snippets/blob/master/standard/ssangbieup.aheui
    let l:case = {}
    let l:case.id = 'standard/ssangbieup'
    let l:case.args = []
    let l:case.code = [
        \ '밟밟땅빵망망희'
        \,''
        \,'ㅃ은 중복 명령입니다. 지금 저장공간이 스택이라면 맨 위의 값을 그 값 위에 하나 더 집어넣고, 큐라면 맨 앞의 값을 앞에 하나 더 덧붙입니다.']
    let l:case.expect = [8181]
    return l:case
endfunction

function! s:case_standard_ssangdigeut()
    " https://github.com/aheui/snippets/blob/master/standard/ssangdigeut.aheui
    let l:case = {}
    let l:case.id = 'standard/ssangdigeut'
    let l:case.args = []
    let l:case.code = [
        \ '발밞따망희'
        \,''
        \,'ㄸ은 곱셈 명령으로 저장공간에서 두 값을 뽑아낸 다음 둘을 곱한 값을 저장공간에 집어넣습니다.']
    let l:case.expect = [45]
    return l:case
endfunction

function! s:case_standard_ssangsiot()
    " https://github.com/aheui/snippets/blob/master/standard/ssangsiot.aheui
    let l:case = {}
    let l:case.id = 'standard/ssangsiot'
    let l:case.args = []
    let l:case.code = [
        \ '아바싹반싼받싿우'
        \,'우멍석멍선멍섣어'
        \,'아바쌀반쌈받쌉우'
        \,'우멍설멍섬멍섭어'
        \,'아바쌋반쌍받쌎우'
        \,'우멍섯멍성멍섲어'
        \,'아바쌏반쌐받쌑우'
        \,'우멍섳멍섴멍섵어'
        \,'아바쌒반싺받싻우'
        \,'우멍섶멍섞멍섟어'
        \,'아바싽반싾받쌁우'
        \,'우멍섡멍섢멍섥어'
        \,'아바쌂반쌃받쌄우'
        \,'우멍섦멍섧멍섨어'
        \,'아바쌅반쌆받쌇우'
        \,'우멍섩멍섪멍섫어'
        \,'아바쌊반쌌받싸우'
        \,'희멍섮멍섰멍서어'
        \,''
        \,'ㅆ은 이동 명령으로 저장공간에서 값 하나를 뽑아내서 받침이 나타내는 저장공간에 그 값을 집어 넣습니다.']
    let l:case.expect = ['320320320320320320320320320']
    return l:case
endfunction

function! s:case_standard_storage()
    " https://github.com/aheui/snippets/blob/master/standard/storage.aheui
    let l:case = {}
    let l:case.id = 'standard/storage'
    let l:case.args = []
    let l:case.code = [
        \ '바반받뭉'
        \,'우석멍멍'
        \,'바반받뭉'
        \,'우선멍멍'
        \,'바반받뭉'
        \,'우섣멍멍'
        \,'바반받뭉'
        \,'우설멍멍'
        \,'바반받뭉'
        \,'우섬멍멍'
        \,'바반받뭉'
        \,'우섭멍멍'
        \,'바반받뭉'
        \,'우섯멍멍'
        \,'바반받뭉'
        \,'우성멍멍'
        \,'바반받뭉'
        \,'우섲멍멍'
        \,'바반받뭉'
        \,'우섳멍멍'
        \,'바반받뭉'
        \,'우섴멍멍'
        \,'바반받뭉'
        \,'우섵멍멍'
        \,'바반받뭉'
        \,'우섶멍멍'
        \,'바반받뭉'
        \,'끝희멍멍'
        \,''
        \,'아희에서 쓰이는 저장 공간은 여러 개가 있습니다. 대부분이 스택이고, 큐가 하나 있습니다.'
        \,'ㅁ은 뽑기 명령입니다. 지금 저장공간이 스택이라면 맨 위의 값, 큐라면 맨 앞의 값을 뽑아냅니다.(pop) 통로라면 거기서 값을 하나 뽑아옵니다. ㅁ 명령에는 받침이 올 수 있는데, 이에 대한 설명은 아래에 있습니다.'
        \,'ㅁ에 ㅇ받침이 있으면 저장공간에서 뽑아낸 값을 숫자로, ㅎ받침이 있으면 그 값에 해당하는 유니코드 문자로 출력합니다.']
    let l:case.expect = ['320320320320320320320320023320320320320320']
    return l:case
endfunction

function! s:case_standard_syllable()
    " https://github.com/aheui/snippets/blob/master/standard/syllable.aheui
    let l:case = {}
    let l:case.id = 'standard/syllable'
    let l:case.args = []
    let l:case.code = [
        \ 'ㅏ희ㅣ😄ㅓ'
        \,'뱓ㅗㅈㅊ몽'
        \,'ㅂ😃먕버헥'
        \,''
        \,'코드는 한글로만 이루어지는데, 여기서 한글은 유니코드 U+AC00에서 U+D7A3까지의 범위에 있는 글자(hangul syllable 영역)를 말합니다. 그 밖의 글자나 코드에서 지정하지 않은 나머지 공간은 모두 빈 칸으로 처리되어 커서가 이동하는 방향에 아무 영향을 주지 않습니다.']
    let l:case.expect = [3]
    return l:case
endfunction

function! s:case_standard_tieut()
    " https://github.com/aheui/snippets/blob/master/standard/tieut.aheui
    let l:case = {}
    let l:case.id = 'standard/tieut'
    let l:case.args = []
    let l:case.code = [
        \ '받반타망희'
        \,''
        \,'ㅌ은 뺄셈 명령으로 저장공간에서 두 값을 뽑아낸 다음 나중 값에서 먼저 값을 뺀 값을 저장공간에 집어넣습니다.']
    let l:case.expect = [1]
    return l:case
endfunction

function! s:case_standard_vowel_2step()
    " https://github.com/aheui/snippets/blob/master/standard/vowel-2step.aheui
    let l:case = {}
    let l:case.id = 'standard/vowel-2step'
    let l:case.args = []
    let l:case.code = [
        \ '뷷우희어밍우여'
        \,'아아아아아아아반받망희'
        \,'먕오뱞오뱗오뵬'
        \,''
        \,'ㅑ, ㅕ, ㅛ, ㅠ - 커서를 각각 오른쪽, 왼쪽, 위, 아래로 두 칸 옮깁니다.'
        \,'중복 명령을 포함한 모든 뽑아내기를 쓰는 명령에서 저장 공간에 값이 모자랄 경우, 커서는 그 명령을 실행하지 않고 커서가 있는 글자의 홀소리의 반대방향으로 움직입니다.']
    let l:case.expect = [3596]
    return l:case
endfunction

function! s:case_standard_vowel_advanced()
    " https://github.com/aheui/snippets/blob/master/standard/vowel-advanced.aheui
    let l:case = {}
    let l:case.id = 'standard/vowel-advanced'
    let l:case.args = []
    let l:case.code = [
        \ '반븓븝불'
        \,'우멍벎망이밟망희'
        \,'빈'
        \,'빋밟망희'
        \,'붑으'
        \,'발몽'
        \,'ㅇ밞망분'
        \,'ㅇ불법벋'
        \,'의멍밞망희'
        \,''
        \,'ㅡ - 커서가 가로로 왔으면 그 방향대로, 세로로 왔으면 전에 있던 자리로 옮깁니다.'
        \,'ㅣ - 커서가 세로로 왔으면 그 방향대로, 가로로 왔으면 전에 있던 자리로 옮깁니다.'
        \,'ㅢ - 커서를 전에 있던 자리로 옮깁니다.']
    let l:case.expect = ['543295432954329']
    return l:case
endfunction

function! s:case_standard_vowel_basic()
    " https://github.com/aheui/snippets/blob/master/standard/vowel-basic.aheui
    let l:case = {}
    let l:case.id = 'standard/vowel-basic'
    let l:case.args = []
    let l:case.code = [
        \ '붇희희멍'
        \,'망밦망볿'
        \,''
        \,'ㅏ, ㅓ, ㅗ, ㅜ - 커서를 각각 오른쪽, 왼쪽, 위, 아래로 한 칸 옮깁니다.']
    let l:case.expect = [369]
    return l:case
endfunction

function! s:case_standard_vowel_useless()
    " https://github.com/aheui/snippets/blob/master/standard/vowel-useless.aheui
    let l:case = {}
    let l:case.id = 'standard/vowel-useless'
    let l:case.args = []
    let l:case.code = [
        \ '우아앙배벤뱯볩뷜뫙뫵뮝뭥뮁우'
        \,'배맹희맹멩먱몡뮝봘봽붣붠붸어'
        \,'벤멩'
        \,'뱯먱'
        \,'볩몡'
        \,'뷜뮝'
        \,'뫙봘'
        \,'뫵봽'
        \,'묑뵏'
        \,'뭥붠'
        \,'뮁붸'
        \,'아오'
        \,''
        \,'기능 없음: ㅐ ㅔ ㅒ ㅖ ㅘ ㅙ ㅚ ㅝ ㅞ ㅟ (커서가 이동하는 방향은 변하지 않습니다.)']
    let l:case.expect = ['54320543205432054320']
    return l:case
endfunction

function! s:case_standard_vowel_useless2()
    " https://github.com/aheui/snippets/blob/master/standard/vowel-useless2.aheui
    let l:case = {}
    let l:case.id = 'standard/vowel-useless2'
    let l:case.args = []
    let l:case.code = [
        \ '와아앙배벤뱯볩뷜뫙뫵뮝뭥뮁우'
        \,'배맹희맹멩먱몡뮝봘봽붣붠붸어'
        \,'벤멩'
        \,'뱯먱'
        \,'볩몡'
        \,'뷜뮝'
        \,'뫙봘'
        \,'뫵봽'
        \,'묑뵏'
        \,'뭥붠'
        \,'뮁붸'
        \,'아오'
        \,''
        \,'기능 없음: ㅐ ㅔ ㅒ ㅖ ㅘ ㅙ ㅚ ㅝ ㅞ ㅟ (커서가 이동하는 방향은 변하지 않습니다.)']
    let l:case.expect = ['54320543205432054320']
    return l:case
endfunction


function! s:prepare()
    let s:test_case = []
    call add(s:test_case, function('<SID>case_99bottles'))
    call add(s:test_case, function('<SID>case_99dan'))
    call add(s:test_case, function('<SID>case_bahmanghui'))
    call add(s:test_case, function('<SID>case_fibonacci'))
    call add(s:test_case, function('<SID>case_helloworld'))
    call add(s:test_case, function('<SID>case_hello'))
    call add(s:test_case, function('<SID>case_32bit_integer'))
    if s:is_64bit_unsigned_integer_available()
        call add(s:test_case, function('<SID>case_64bit_integer'))
    endif
    call add(s:test_case, function('<SID>case_ha_ut'))
    call add(s:test_case, function('<SID>case_pokryong'))
    call add(s:test_case, function('<SID>case_ddeok'))
    call add(s:test_case, function('<SID>case_hammer'))
    call add(s:test_case, function('<SID>case_sijo_div'))
    call add(s:test_case, function('<SID>case_sweat'))
    call add(s:test_case, function('<SID>case_quine_puzzlet'))
    call add(s:test_case, function('<SID>case_quine_puzzlet_40col'))
    call add(s:test_case, function('<SID>case_standard_bieup_char'))
    call add(s:test_case, function('<SID>case_standard_bieup_sign'))
    call add(s:test_case, function('<SID>case_standard_bieup'))
    call add(s:test_case, function('<SID>case_standard_border'))
    call add(s:test_case, function('<SID>case_standard_chieut'))
    call add(s:test_case, function('<SID>case_standard_default_direction'))
    call add(s:test_case, function('<SID>case_standard_default_storage'))
    call add(s:test_case, function('<SID>case_standard_digeut'))
    call add(s:test_case, function('<SID>case_standard_emptyswap'))
    call add(s:test_case, function('<SID>case_standard_exhausted_storage'))
    call add(s:test_case, function('<SID>case_standard_exitcode'))
    call add(s:test_case, function('<SID>case_standard_hieut_pop'))
    call add(s:test_case, function('<SID>case_standard_ieunghieut'))
    call add(s:test_case, function('<SID>case_standard_jieut'))
    call add(s:test_case, function('<SID>case_standard_loop'))    " passed 너무 오래 걸려서 봉인
    call add(s:test_case, function('<SID>case_standard_mieum'))
    call add(s:test_case, function('<SID>case_standard_nieun'))
    call add(s:test_case, function('<SID>case_standard_pieup'))
    call add(s:test_case, function('<SID>case_standard_print'))
    call add(s:test_case, function('<SID>case_standard_queue'))
    call add(s:test_case, function('<SID>case_standard_rieul'))
    call add(s:test_case, function('<SID>case_standard_shebang'))
    call add(s:test_case, function('<SID>case_standard_ssangbieup'))
    call add(s:test_case, function('<SID>case_standard_ssangdigeut'))
    call add(s:test_case, function('<SID>case_standard_ssangsiot'))
    call add(s:test_case, function('<SID>case_standard_storage'))
    call add(s:test_case, function('<SID>case_standard_syllable'))
    call add(s:test_case, function('<SID>case_standard_tieut'))
    call add(s:test_case, function('<SID>case_standard_vowel_2step'))
    call add(s:test_case, function('<SID>case_standard_vowel_advanced'))
    call add(s:test_case, function('<SID>case_standard_vowel_basic'))
    call add(s:test_case, function('<SID>case_standard_vowel_useless'))
    call add(s:test_case, function('<SID>case_standard_vowel_useless2'))

    return s:test_case
endfunction

function! s:is_64bit_unsigned_integer_available()
    let l:vim_long_max = 9223372036854775807     " 2^63 - 1
    return l:vim_long_max + 1 > 0
endfunction

