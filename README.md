# OMR4Attendance

出欠集計に悩む全てのTAに捧ぐ -- Rubyによるマークシート式(OMR)出欠集計システム。

## Features

- 面倒な授業の出欠集計を、出席シート+OMRにより全自動で行うことが可能

![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s1.png)

- 出席シート(A4,Texファイル)を編集することにより、学生からの感想や簡単な課題を提示することも可能
 * サンプルでは、『授業のキーワード3つ』『授業の感想』欄を設けた
- かつ、それらのコメントを切り取り、まとめてPDFファイルに出力することも可能
![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s2.png)
- 識別部には[RubyMarksライブラリ](https://github.com/andrerpbts/ruby_marks)を適用
- アウトプットはExcelなどでも使いやすいよう、CSVファイルで出力
 * 集計はVLOOKなどを使って、ご自由にどうぞ！

![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s3.png)

## Specifications

当システムは筑波大学 グローバル人材育成教育プログラムが開設する[グローバルサウス講義Ⅰ(新興国経済論)](http://shakai.tsukuba.ac.jp/news/2014/09/-ghrd.html)で使用されているため、出席番号の仕様も筑波大学に準ずる**9桁**(20xxxxxxx)となっている。
なお、もちろん桁数はTexファイルとプログラム内の読み取り位置を調整することで変更が可能。

## Environments

- Ruby 1.9.3
 - Rmagic
- ghostscript  9.xx
- Texがコンパイルできる環境

(その他準備中)

## Steps

(下準備…授業で回収した出席シートをスキャン、1つのPDFファイルにまとめる)

1. シェルスクリプトでPDFファイルを全ページ読み込み、jpgファイルで分割保存
2. jpgファイルからマークシート部のおおよそのピクセル位置を抜き出す
3. マーク部のピクセルと出力先フォルダを指定して、プログラム実行！

## How to Use

1. シェルスクリプト`pdf2jpg.sh` を実行し、出席PDFファイル(ex.`SAMPLE.pdf`)を読み込みjpgで分割保存

 ```
$ ./pdf2jpg.sh [出席PDFファイルのパス] [JPGファイル名]
⇒(例) $ ./pdf2jpg.sh ./SAMPLE.pdf SAMPLE
```

 ⇒ ` 00 src`フォルダに全出席シートがjpgファイル(ex. `SAMPLE001.jpg`, `SAMPLE002.jpg`, ...)で格納される

2. 分割生成されたjpgファイルから、マークシート部のおおよそのピクセル位置を抜き出す

  ![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s4.png)

 少し広めにとってもかまいません。

3. リストを挿入する際は、**リストの上下に空行がないと正しく表示されません**

## License
- MIT-LICENSE

## Acknowledgments
- [Ruby Marks](https://github.com/andrerpbts/ruby_marks)
