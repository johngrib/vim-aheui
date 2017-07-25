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
        if l:result == string(join(l:item.expect, "\n"))
            let l:success += 1
            echom 'passed: ' . l:item.id
        else
            let l:failed += 1
            call add(l:failed_id, l:item.id)
            echom 'failed: ' . l:item.id
            echom 'result: ' . l:result
        endif
    endfor

    echom l:success . '/' . len(s:test_case) . ' success'

    if len(l:failed_id) > 0
        echom 'failed id list : '.string(l:failed_id)
    endif
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
    let l:case.expect = ['8589934592']
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
    let l:case.expect = ['36893488147419103232']
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

    return s:test_case
endfunction

function! s:is_64bit_unsigned_integer_available()
    let l:vim_long_max = 9223372036854775807     " 2^63 - 1
    return l:vim_long_max + 1 > 0
endfunction



