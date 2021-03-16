# ■ **TerraformCloudの使い方**

- 「**variables.tf**」ファイル  
・・・各パラメータのデフォルト値を定義しています。ファイル内の「variable」ブロック内で定義されている変数に関しては、TerraformCloudの変数設定で上書きが可能です。

- 「**output.tf**」ファイル  
・・・モジュール間で受け渡しする変数の値を定義。Demo用では構築したEC2にアタッチされたパブリックIPアドレスの値を「demo-ec2-public-ip」というoutput値に格納し、構築完了時にターミナルに標準出力しています。
