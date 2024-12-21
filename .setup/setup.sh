#!/usr/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "이 스크립트는 관리자 권한이 필요합니다. sudo를 사용하여 실행하세요."
    echo "예: sudo $0"
    exit 1
fi

# 패키지 목록 업데이트
sudo apt update

checkstall() {
    if dpkg -l | grep -qw ${1}; then
        echo "${1}가 이미 설치되어 있습니다."
    else
        echo "${1}가 설치되어 있지 않습니다. 설치를 진행합니다."
    fi


    # ${1} 설치
    sudo apt install -y ${1}

    # 설치 성공 여부 확인
    if dpkg -l | grep -qw ${1}; then
        echo "${1}가 성공적으로 설치되었습니다."
    else
        echo "${1} 설치에 실패했습니다. 문제가 발생했습니다."
    fi

}

for sw in cmatrix bat fzf zoxide eza direnv jq pandoc
do
    echo $sw
    checkstall ${sw}
done

USER_HOME=$(eval echo ~$SUDO_USER)
echo "#### 사용자 확인 ####"
echo $SUDO_USER:$USER_HOME

echo "#### Starship 설치 진행 중..."
curl -sS https://starship.rs/install.sh | sh || { echo "Starship 설치 실패!"; exit 1; }
echo "Starship 설치 완료!"


echo "#### default script생성"
cp .skel/.bash_wooix .skel/.bash_profile_yadm
zoxide init bash >> .skel/.bash_profile_yadm
echo 'eval "$(zoxide init bash)"' >> .skel/.bash_profile_yadm


echo "#### default script복사"
mv .skel/.bash_profile_yadm ${USER_HOME}		##생성되는 파일이라 옮기고 삭제
cp .skel/.vimrc ${USER_HOME}

chown $SUDO_USER:$SUDO_USER "${USER_HOME}/.bash_profile_yadm"
chown $SUDO_USER:$SUDO_USER "${USER_HOME}/.vimrc"

echo "#### bashrc reload"
echo "#yadm으로 설치된 sw의 사용을 위해서 설정파일을 추가한다." >> ${USER_HOME}/.bashrc
echo 'source ~/.bash_profile_yadm' >> ${USER_HOME}/.bashrc
sudo -u ${SUDO_USER} bash -c "source ${USER_HOME}/.bashrc"

echo ""
echo ""
echo "#########################################################"
echo " 다시 terminal을 뜨워주시오~"
echo "#########################################################"
