# OMR4Attendance

出欠管理に悩む全てのTAに捧ぐ -- Rubyによるマークシート式(OMR)出欠管理システム。

## Features

- 面倒な授業の出席集計を、出席シート+OMRにより全自動で行うことが可能

![](ht
tps://raw.githubusercontent.com/shartsu/OMR4Attendance/master/READMEimg/s1.png)

- 出席シート(A4,Texファイル)を編集することにより、学生からの感想や簡単な課題を提示することも可能
 * サンプルでは、『授業のキーワード3つ』『授業の感想』を書かせた
- かつ、それらのコメントを切り取り、まとめてPDFファイルに出力することも可能
- 識別部には[RubyMarksライブラリ](https://github.com/andrerpbts/ruby_marks)を適用
- アウトプットはCSVファイルでまとめて出力が可能
 * 集計はExcelのVLOOKなどを使って、ご自由にどうぞ！

## Specifications

当システムは筑波大学 グローバル人材育成教育プログラムが開設する[グローバルサウス講義Ⅰ(新興国経済論)](http://shakai.tsukuba.ac.jp/news/2014/09/-ghrd.html)で使用されているため、出席番号の仕様も筑波大学に準ずる9桁となっている。
なお、もちろん桁数はTexファイルとプログラム内の読み取り位置を調整することで変更が可能。

## Environments

(準備中)

- Ruby 1.9.3
 - Rmagic
- ghostscript  9.xx
- Texがコンパイルできる環境

## Steps

(下準備…授業で回収した出席シートをスキャン、1つのPDFファイルにまとめる)

1. `pdf2jpg.sh` 出席PDFファイル(sample.pdf)を1枚1枚分割し、各jpgで保存

```
OMR $ chmod 755 ./pdf2jpg.sh
OMR $ ./pdf2jpg.sh ./sample.pdf SAMPLE
```

これで、` 00 src`フォルダに全出席シートがjpg(SAMPLExxx.jpg)で格納される

2.  1.2.3.と入れていくといい具合です
3.  リストを挿入する際は、**リストの上下に空行がないと正しく表示されません**


## How to Use

## Prize
- 平成23年度[「情報処理学会 北海道支部長賞」](http://hokkaido.ipsj.or.jp/pukiwiki/index.php?%E6%94%AF%E9%83%A8%E9%95%B7%E8%B3%9E%E5%8F%97%E8%B3%9E%E8%80%85)を受賞し、同時に独立行政法人国立高等専門学校機構が発行する論文誌­「創造性を育む『卒業研究』集」に研究内容が掲載

## License
- MIT-LICENSE

## Acknowledgments
- [Ruby Marks](https://github.com/andrerpbts/ruby_marks)
- [CiNii 雑誌 - 創造性を育む「卒業研究」集] (http://ci.nii.ac.jp/ncid/AA12148693)
- [OpenCV] (http://opencv.org/)