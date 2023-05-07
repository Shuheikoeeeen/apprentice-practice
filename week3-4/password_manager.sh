#!/bin/bash

FILE_PATH=./password.txt

echo "パスワードマネージャーへようこそ！"

while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit):" REPLY
    if [ "${REPLY}" = "Add Password" ]; then
        read -p "サービス名を入力してください：" service_name
        read -p "ユーザー名を入力してください：" user_name
        read -p "パスワードを入力してください：" password

        echo "${service_name}:${user_name}:${password}" >> "${FILE_PATH}"
        echo "パスワードの追加は成功しました!"

        read -s -p "暗号化のためにパスワードを入力してください：" secret_password
        gpg --batch --yes --passphrase "${secret_password}" --cipher-algo AES256 --output "${FILE_PATH}" --symmetric "${FILE_PATH}"
        echo "暗号化が完了しました!"



    elif [ "${REPLY}" = "Get Password" ]; then
        read -p "サービス名を入力してください：" service_name
        gpg --quiet --decrypt --passphrase-fd 0 "${FILE_PATH}" | grep "${service_name}:" > /dev/null
      
        if [ $? -eq 0 ]; then
            user_name=$(gpg --quiet --decrypt --passphrase-fd 0 "${FILE_PATH}" | grep "${service_name}:" | cut -d ":" -f 2)
            password=$(gpg --quiet --decrypt --passphrase-fd 0 "${FILE_PATH}" | grep "${service_name}:" | cut -d ":" -f 3)
            
            echo "サービス名：${service_name}"
            echo "ユーザー名：${user_name}"
            echo "パスワード：${password}"

            gpg --batch --yes --passphrase-fd 0 --cipher-algo AES256 --output "${FILE_PATH}" --symmetric < "${FILE_PATH}"
            echo "ファイルを元の状態に戻しました。"

        else
          echo "サービス名が間違っています。"
        fi

    elif [ "${REPLY}" = "Exit" ]; then
        echo "Thank you!"
        break
    else
        echo "入力を間違えています。Add Password/Get Password/Exit から入力してください。"
    fi
done
