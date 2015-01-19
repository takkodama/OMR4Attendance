# OMR4Attendance

出欠集計に悩む全てのTAに捧ぐ -- Rubyによるマークシート式(OMR)出欠集計システム。

## Features

- 面倒な授業の出欠集計を、出席シートPDF+OMR読み取りにより全自動で行うことが可能

![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s1.png)

- 出席シート(A4,Texファイル)を編集することにより、学生からの感想や簡単な課題を提示することも可能
 * サンプルでは、『授業のキーワード3つ』『授業の感想』欄を設けた
- かつ、それらのコメントを切り取り、まとめてPDFファイルに出力することも可能
![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s2.png)
- 識別部には[RubyMarksライブラリ](https://github.com/andrerpbts/ruby_marks)を適用
- アウトプットはExcelなどでも使いやすいよう、CSVファイルで出力
 * 集計はVLOOKなどを使って、ご自由にどうぞ！

![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s3.png)
## How to Use

(下準備 … `sheet`フォルダ内にある出席シートを授業で配布⇒授業で回収した出席シートをスキャン⇒1つのPDFファイルにまとめる)

1. シェルスクリプト`pdf2jpg.sh` を実行し、出席PDFファイル(ex.`SAMPLE.pdf`)を読み込みjpgで分割保存

 ```
$ ./pdf2jpg.sh [出席PDFファイルのパス] [JPGの共通ファイル名]
⇒(例) $ ./pdf2jpg.sh ./SAMPLE.pdf SAMPLE
```

 ⇒ ` 00 src`フォルダに全出席シートがjpgファイル(ex. `SAMPLE001.jpg`, `SAMPLE002.jpg`, ...)で格納される

2. 分割生成されたjpgファイルから、マークシート部のおおよそのピクセル位置を始点と終点両方取得する(Macのプレビューを使うと便利。)

  ![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s4.png)

 各ファイルに多少のずれは生じるので、少し広めにとってもかまいません。

 なお、ここでシート内のコメント欄を抜き出す場合は、同様に始点と終点のピクセル位置を取得し、
  ![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s5.png)

 `main.rb`内でそれぞれピクセルを指定してあげればオッケーです。

 ```ruby:main.rb
  # Comment Area
  jpg.cutting(img, filelist[n], '02 key', 0, 2950, img.columns, 4450) #sx, sy, ex, ey
 ```
 第3引数`'02 key'`はフォルダ名で、ここで指定したフォルダに切り取られた画像が格納されていきます。

 また、プログラム内下部で画像をpdfでまとめる処理も行っています。

 ```ruby:main.rb
pdf = WritePDF::new
pdf.write("./#{outputdir}/#{thumb}keywords.pdf", "./02 key/#{thumb}*.jpg")
 ```
`#{outputdir}`はデフォルトで`10 output`フォルダにセットされているので、3でプログラム実行後当該フォルダで生成済みのpdfを確認してみてください。

3. マークシート部のピクセルをコマンドライン引数に指定し、プログラム実行！

  ![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s4.png)

より、

 ```
$ ruby main.rb [JPGの共通ファイル名] [マーク部の開始x地点] [開始y地点] [終了x地点] [終了y地点]
⇒(例) $ ruby main.rb SAMPLE 2700 1060 4370 2640
```

 上手く実行できれば以下のようにコマンドラインに結果が出てきます。

 ```
$ ruby main.rb SAMPLE 2700 1060 4370 2640
001 206543210
002 201420642
003 209876542
004 209999999
005 204680246
…
```
これらの結果をまとめたCSVファイルも、2のカット画像たちと同様に`10 output`フォルダに保存されているはずなので、確認してみてください。

- (番外編:出てこない場合は)

 `04 marked`に保存された、読み取り結果のファイルを確認しつつ以下を調整してみてください。

 □ マークシート部の読み取り位置(開始x~終了y)を広げてみる(Lv.★)

 □ 画像の圧縮サイズを再検討する(Lv.★★)
　ーデフォルトでは`300x284`に設定されていますが、読み取り位置を変更されたならば縦横比が元画像と一致させ、300ピクセル前後に再度設定してあげてください。

 □ 読み取り設定confを変更する(Lv.★★★)
　ープログラム内で、マークシート部に切り取られ、300ピクセル前後に圧縮された後の画像(`01 id`フォルダ/*.jpg)に対しての読み取り位置、許容量、マークのサイズ、カラムとローの幅を設定できます。

 ```ruby:main.rb
#1 SET OMRCONFIG
@recognizer = RubyMarks::Recognizer.new
conf = Conf.new(@recognizer)
conf.OMRsettings(25, 23, 30, 284, 5, 30) 
#OMRsettings(tolerance, size, startx, endx, starty, betweeny)
 ```
 デフォルトでは以上のように設定されていますが、もし極端に画像を変更された場合や、自作PDFを適用したい時などは再調整してみてください。

  ![](https://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s6.png)

## Specifications

当システムは筑波大学 グローバル人材育成教育プログラムが開設する[グローバルサウス講義Ⅰ(新興国経済論)](http://shakai.tsukuba.ac.jp/news/2014/09/-ghrd.html)で使用されているため、出席番号の仕様も筑波大学に準ずる**9桁**(20xxxxxxx)となっています。
なお、もちろん桁数はTexファイルとプログラム内の読み取り位置を調整することで変更が可能です。

## Environments

- Ruby 1.9.3
 - Rmagic
- ghostscript  9.xx
- Texがコンパイルできる環境

(その他準備中)


## License
- MIT-LICENSE

## Acknowledgments
- [Ruby Marks](https://github.com/andrerpbts/ruby_marks)
