# 빔아희

* 빔아희는 난해한 프로그래밍 언어 [아희](http://aheui.github.io)의 vimscript 구현체입니다.
* 왜 하필 vimscript냐 하면, 그냥... vimscript 구현체가 없는 것 같아서 만들었습니다.

## 편의 기능

* `m` mark로 break point를 지정할 수 있습니다.
* inspector가 있어, 메모리에 입력된 값들을 확인할 수 있습니다.

## 사용 방법

* Vim 내부에서 돌아가기 때문에 실행하기 위해서는 일단 Vim을 켜야 합니다.
* `:AheuiRun`
    * 현재 버퍼에 열려 있는 아희 코드를 실행합니다.
    * 실행이 완료되면 콘솔이 열리고, 실행 결과와 수행 시간을 보여줍니다.
    * 이 기능은 break point를 무시하고 끝까지 돌아갑니다.  
![:AheuiRun](https://user-images.githubusercontent.com/1855714/28654325-57bff924-72ce-11e7-9101-34fa51c309eb.png)

* `:AheuiStep`
    * 아희 코드를 한 글자씩 실행합니다.
    * 매 스텝마다 inspector를 통해 stack과 queue에 입력된 값을 보여줍니다.  
![:AheuiStep](https://user-images.githubusercontent.com/1855714/28654326-5de0403e-72ce-11e7-89e9-4ca3e7f2e18c.gif)

* `:AheuiRunUntilBreak`
    * break point를 걸어놨다면, 해당 지점에서 실행이 중단됩니다.
        * 실행이 중단되면 stack과 queue에 입력된 값을 볼 수 있도록 inspector가 열립니다.
    * 현재 구현된 상태에서 break point는 실행 도중에는 재지정할 수 없습니다.
    * break point 거는 방법
        * `m`으로 마크를 지정하면 마크 표시한 곳을 break point로 사용합니다.
        * 예) `ma`, `mb`, `mc`, ...
    * break point 목록 보는 방법
        * `:marks`로 마크 목록을 확인하면 됩니다.
    * break point 삭제하는 방법
        * `delm`을 사용해 마크를 삭제하면 됩니다.
        * 예) `:delm a`, `:delm b`, ...

* `:AheuiTest`
    * vim-aheui를 검증하는 테스트 코드를 실행합니다.
    * 테스트 코드의 출처는 모두 [github.com/aheui/snippets](https://github.com/aheui/snippets)입니다.
    * [standard 테스트 케이스](https://github.com/aheui/snippets/tree/master/standard)는 모두 들어가 있으며, 나머지는 재미있어 보이는 코드를 추가한 것입니다.
    * 다음은 테스트를 수행한 결과입니다.  
![:AheuiTest](https://user-images.githubusercontent.com/1855714/28654327-5e0da466-72ce-11e7-9d32-7c2f36dc5d6c.png)

* `:AheuiInspectorOpen`, `:AheuiInspectorClose`
    * 아희 코드 실행 과정에 스택과 큐에 입력된 값들을 볼 수 있는 inspector를 열고/닫습니다.

* `:AheuiConsoleOpen`, `:AheuiConsoleClose`
    * 아희 코드 실행 결과와 수행 시간을 볼 수 있는 콘솔을 열고/닫습니다.
    * 아직까지는 실행 결과를 보는 기능 밖에 없습니다.

## 사용 예

* 수행 결과를 보고 싶음
    1. `:AheuiRun`
* 일단 실행시키고 break point에서 멈춘 다음, 한 step 씩 이동
    1. `ma` - break point a 설정
    1. `:AheuiRunUntilBreak`
    1. `:AheuiStep`
    1. `:AheuiStep`
    1. ...
* break point에서 멈춘 다음, 다음 break point까지 실행
    1. `ma` - break point a 설정
    1. `mb` - break point b 설정
    1. `:AheuiRunUntilBreak`
    1. `:AheuiRunUntilBreak`
* 처음부터 한 step 씩 이동하다가 다음 break point까지 실행
    1. `ma` - break point a 설정
    1. `:AheuiStep`
    1. `:AheuiStep`
    1. ...
    1. `:AheuiRunUntilBreak`
* 처음부터 한 step 씩 이동하다가 break point를 무시하고 끝까지 실행
    1. `:AheuiStep`
    1. `:AheuiStep`
    1. ...
    1. `:AheuiRun`

## `.vimrc` 설정 예

```viml
" 명령어를 일일이 입력하기 귀찮으므로 다음과 같이 단축키를 매핑해두면 편합니다

nnoremap <F6> :AheuiStep<CR>
nnoremap <F7> :AheuiRunUntilBreak<CR>
nnoremap <F8> :AheuiRun<CR>

nnoremap <leader>aco :AheuiConsoleOpen<CR>
nnoremap <leader>acc :AheuiConsoleClose<CR>
nnoremap <leader>aio :AheuiInspectorOpen<CR>
nnoremap <leader>aic :AheuiInspectorClose<CR>
```

## 설치 방법

자신이 좋아하는 Vim 플러그인 관리자를 사용해 설치합니다.

### VimPlug

다음을 .vimrc 에 추가합니다.

> Plug 'johngrib/vim-game-code-break'

그리고 다음과 같이 설치합니다.

> :source %

> :PlugInstall

