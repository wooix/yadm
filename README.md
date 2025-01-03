# yadm 파일 설정작업

## .setup 폴더로 이동 후 설치를 위한 script실행

```bash
cd .setup
sudo ./setup.sh
```

- 필수 sw를 설치하고 작동을 위한 .bash_profile_yadm 과 .vimrc를 배포한다.
- nerd font 설치 필요 : https://www.nerdfonts.com/font-downloads

## 설치 목록

cmatrix
bat
fzf
zoxide
eza
direnv
jq
glow(수동설치)
pandoc
starship

## cmatrix

10분 후에 자동 terminal 잠김

## bat 

- cat 대용품

## fzf

- find ./ 의 index형태

```bash
fzf --preview "batcat --color=always {}"
docker ps -a | fzf --preview 'docker inspect {1}'
```

## zoxide 

- cd 대신 `z` 사용, 자동으로 index를 생성한뒤 index 사이를 `zi`를 이용하여 검색

## direnv

- 각 디렉토리별 환경변수 자동 설정, 디렉토리 진입시 자동으로 적용


```bash
.envrc 파일 생성
export OPENAI_API_KEY="~~~"

만약 .envrc파일이 존재한다면~

direnv reload (현재 디렉토리 추가) 
direnv revoke (현재 디렉토리 제외)
```

## jq

- json formatter with syntax

```bash
[
 {
     "title" : "this is title",
     "body" : "helo lfkdjj lala distinctio odio"
 }
 ...
]
jq ‘.[].title’  
jq '.[] | select(.body | contains("distinctio odio"))’

```

## glow(수동설치)

- Render markdown on the CLI

```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow
```

## pandoc

- Markdown을 다양한 포맷으로 변환하며, 쉘에서 보기에도 적합합니다.

```bash
pandoc README.md -t <format>
man pandoc에서 확인
```

## starship

- Starship은 모든 쉘과 호환되는 빠르고 커스터마이징 가능한 프롬프트

