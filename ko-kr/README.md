# developer.github.com [![Build Status] (https://travis-ci.org/github/developer.github.com.svg?branch=master)](https://travis-ci.org/github/developer.github.com )


이 함께 내장 GitHub의 API를 자원입니다. [Nanoc] [nanoc]

진행중인 ## 개발

나는이 파일을 편집을하고 마스터 브랜치에 커밋 : 명령 줄을 열고 '스크립트 / bootstrap`를 실행하여 최신 종속성을 가져올 수 있습니다.

```쉬
$ 스크립트 / 부트 스트랩
==> 보석 종속성을 설치 ...
==> NPM 종속성을 설치 ...
```

당신은 루비와 노드가 시스템에 설치해야합니다. 각 언어에 필요한 버전은 각각 * .ruby 버전의 *와 * package.json * 파일에서 찾을 수 있습니다.

당신은`실행 사이트를 생성하기 간부 레이크 build` 번들하지만, 종종 더 유용 할 수 있습니다
단순히 서버 *을 구축 * 동시에 사이트를 시작한다.

Nanoc는 output``에 살고있는 정적 파일로 사이트를 컴파일합니다. 그
똑똑 변경되지 않은 파일을 컴파일하려고하지.

당신은`스크립트 / server`로 사이트를 시작할 수 있습니다 :

```쉬
$ 스크립트 / 서버
로드 사이트 데이터 ...
사이트를 컴파일 ...
출력 [0.28s] / V3 / 학자 / 의견 / index.html을을 만들
출력 [1.31s] / V3 / 학자 / 의견 / index.html을을 만들
동일한 [1.92s] 출력 / V3 / 문제 / 의견 / index.html을
동일한 [0.25s] 출력 / V3 / 문제 / 의견 / index.html을
업데이트 [0.99s] 출력 / V3 / index.html을
업데이트 [0.05s] 출력 / V3 / index.html을
…

사이트는 5.81s. 컴파일.
```

이 사이트는 HTTP`에서 호스팅 : // localhost를 : 4000`.

Nanoc가있다 (http://nanoc.ws/docs/tutorial/)를 [some nice documentation] 시작할 수 있습니다. 당신이 편집 또는 추가 콘텐츠를 주로 우려하는 경우지만, 당신은 Nanoc에 대해 많이 알 필요가 없습니다.

[nanoc]: http://nanoc.ws/

기업

은`/ 엔터프라이즈 '버전을 생성하려면,`스크립트 / server`에 엔터프라이즈 버전에 전달합니다. 예를 들면 :

```쉬
$ 스크립트 / 서버 2.6
```

라이브 재로드가 Enterprise 설명서를 사용할 수 없습니다 있습니다.

## 스타일 가이드

아니 문서를 구성하는 방법을 잘? 여기에 무엇의 구조
API 문서는 같아야합니다 :

# API 제목

{:toc}

## API 끝점 표제

[VERB] / 경로 /로 / 엔드 포인트

### 매개 변수

이름 | 입력 | 기술
-----|------|--------------
`name` |`type` | 기술.

### 입력 (요청 JSON 본체)

`name` |`type` | 기술.
-----|------|--------------
이름 | 입력 | 기술

### 응답

<% = 헤더 (200) : 매김 => default_pagination_rels, 'X-맞춤 헤더'=> "값"%>
<% = JSON : RESOURCE_NAME %>

** 참고 ** [Kramdown Markdown extensions] : 우리는 정의의 목록으로, (http://kramdown.gettalong.org/syntax.html) 사용하고 있습니다.

### JSON 응답

우리가 작성하지 않도록 우리는 루비에서 JSON 응답을 지정
그 모든 문서를 통해 손으로. 당신은 자원에 대한 JSON을 렌더링 할 수
이 같은 :

```ERB
<% = JSON : 문제 %>
```

이는`lib 디렉토리 / lib/resources.rb`에`GitHub의 :: 자원 :: ISSUE`을 보인다.

일부 작업은 배열을 반환합니다. 당신은 블록을 전달하여 JSON을 수정할 수 있습니다 :

```ERB
<% = { |hash| [hash] } JSON (: 문제) %>
```

문서의 샘플 응답에서 JSON 파일을 생성하는 레이크 작업도 있습니다 :

```쉬
$ 레이크 generate_json_from_responses
```

생성 된 파일은 * / * JSON 덤프에 종료됩니다.

### 터미널 블록

당신은`명령 line` 구문 강조를 사용하여 터미널 블록을 지정할 수 있습니다.

```명령 줄
$ 컬는 foobar
```

당신은 다른 부분을 강조,`$`와`#`와 같은 특정 문자를 사용할 수 있습니다
의 명령.

```명령 줄
# 통화는 foobar
$ 컬는 <em> foobar <em>
....
```

자세한 내용은 (https://github.com/gjtorikian/extended-markdown-filter#command-line-highlighting)를 참조하십시오. [the reference documentation]

## 배포

홍보가 master``에 병합되면 배포가 자동으로 발생합니다. (https://github.com/gjtorikian/publisher)라는 도구는`master` 분기를 취 Nanoc를 사용하여 구축하고, [Publisher] 'GH-pages`에 콘텐츠를 게시합니다. 따라서, 어느`master`가 자동으로 집어 GitHub의 페이지에서 제공하는 것 'GH-pages`로를 통해 전송하기 위해 커밋합니다.

## 라이센스

코드는 모든 자산 콘텐츠를 제외 (사이트를 생성 할
상기 위치에 배치 디렉토리)뿐만 아니라, 코드 샘플은
에 의거하여 라이센스
[CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/legalcode).
CC0 모든 저작권 제한을 포기하지만 어떤 상표를 부여하지 않습니다
권한.

자산, 콘텐츠 및 레이아웃 디렉토리의 사이트 콘텐츠 (모든,
개별적으로 표시 오픈 소스 라이센스)에서 제외 파일은 허가
아래 [CC-BY-4.0] (https://creativecommons.org/licenses/by/4.0/). CC-BY-4.0
당신에게 거의 모든 목적을 위해 콘텐츠를 사용할 수있는 권한을 제공하지만 부여하지 않습니다
당신 상표 권한, 너무 오래 라이센스를 기록하고 신용을 제공으로,
다음과 같은 :

> 콘텐츠에 기반
> <a href="https://github.com/github/developer.github.com">developer.github.com</a>
>를 받아 사용
> <a href="https://creativecommons.org/licenses/by/4.0/"> CC-BY-4.0 </a>
## 라이센스 </a>

이것은 당신이를 제외하고이 저장소의 코드 및 콘텐츠를 사용할 수 있다는 것을 의미
자신의 프로젝트에 GitHub의 상표.

당신은 당신이 위의 아래에 그렇게되어이 저장소에 기여하는 경우
## 라이센스
