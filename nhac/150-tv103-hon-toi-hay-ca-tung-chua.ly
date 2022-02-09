% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hồn Tôi Hãy Ca Tụng Chúa" }
  composer = "Tv. 103"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  %\autoPageBreaksOff
  \partial 8 c16 g' |
  g4 \tuplet 3/2 { f8 e d } |
  a'4 r8 g 
  e'4. b16 c |
  d4. c8 |
  g4. a16 g |
  f4. e8 |
  d4 r8 e16 c |
  c4. c8 |
  g' g4 a16 (g) |
  e4 \tuplet 3/2 { f8 d d } |
  a'4. a8 |
  g d'4 b8 |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  c,16 c |
  f8. d16 \tuplet 3/2 { g8 g e } |
  a4 r8 b16 a |
  g8. g16 \tuplet 3/2 { c8 e d } |
  d2 ~ |
  d4 \tuplet 3/2 { b8 d c } |
  %\pageBreak
  c8. e,16 \tuplet 3/2 { g8 g a } |
  a4 r8 a16 g |
  f8 e d g |
  c2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c16 g' |
  g4 \tuplet 3/2 { f8 e d } |
  a'4 r8 g |
  c4. g16 e |
  f4. f8 |
  e4. f16 e |
  d4. c8 |
  b4 r8 e16 c |
  c4. c8 |
  e e4 d8 |
  c4 \tuplet 3/2 { f8 d d } |
  a'4. f8 |
  e f4 g8 |
  <e c>2 ~ |
  <e c>4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hồn tôi ơi, hãy ca tụng Chúa,
  lạy Chúa là Thiên Chúa con thờ,
  Chúa cao cả muôn trùng,
  Áo Ngài mặc toàn oai phong lẫm liệt,
  Cẩm bao Ngài khoác muôn vạn ánh hào quang.
  <<
    {
      \set stanza = "1."
      Tầng trời thẳm Ngài căng như màn trướng
      Với cung điện dựng trên nước mênh mông
      Ngự giá xe mây, Ngài tung bay cánh gió
      Bắt muôn ngọn lửa làm nô bộc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Địa cầu đó Ngài xây trên nền vững
	    Đến muôn đời hằng kiên cố khôn lay
	    Vực thẳm mênh mông choàng lên thân trái đất
	    Nước quy tụ trên đỉnh núi đồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lời Ngài mới vừa âm vang truyền phán
	    Chúng kinh hoàng chạy tan tác nơi nơi
	    Vượt núi non cao, tràn nương xanh bát nhát
	    Tưới cây cỏ xanh rì lá cành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Kìa Ngài khiến khởi nguyên bao mạch suối
	    Giữa núi đồi lượn muôn khúc quanh co
	    Cầm thú no say, ngựa hoang nay đã khát,
	    Lũ chim rủ nhau về kết đoàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Từ trời thẳm đổ mưa trên đồi núi
	    Đó ân lộc Ngài gieo xuống dương gian
	    Cỏ thắm nương xanh để nuôi gia súc béo,
	    Sẵn rau để con người hưởng dùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Từ ruộng đất tìm ra ngay được bánh
	    Phấn khởi vì rượu pha chế thơm ngon
	    Dầu ngát hương bay làm duyên tươi sắc thắm,
	    Bánh cơm để no lòng chắc dạ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nhờ Ngài khiến ngàn cây căng nhựa sống
	    Chúa vun trồng cả hương bá Ly -- băng
	    Từng cánh chim bay về đây xây mái ấm,
	    Núi cao thẳm muôn loài ẩn mình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Ngài trần thiết vầng trăng đo thời tiết
	    Đúng theo giờ, vầng ô gasc non tây
	    Vào lúc đêm lên Ngài tung gieo bóng tối,
	    Tiếng sư tử vang dội núi rừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Ngày vừa tới là bao nhiêu cầm thú
	    Bảo nhau về tim hang hốc nương thân
	    Là lúc nhân gian cùng ra lao tác hết
	    Những mê mải cho tận đến chiều.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
	    Sự việc Chúa thực thiên muôn hình sắc
	    Đã viên thành thể theo đức khôn ngoan
	    Biển nước mênh mông, tàu ra khơi lướt sóng,
	    Các sinh vật to nhỏ vẫy vùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Mọi loài vẫn bền tâm trông về Chúa,
	    Những trông đợi Ngài theo bữa nuôi ăn
	    Ngài mới quay đi mọi sinh linh khiếp hãi,
	    Rút hơi thở chúng thành cát bụi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
	    Này Thần Khí Ngài ban cho trần thế,
	    Khiến địa cầu được đổi mới xinh tươi
	    Thần khí cao minh tạo sinh ra thế giới,
	    Cánh tay mở ban lộc phúc đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "13."
	    Sự nghiệp Chúa ngàn m uôn năm còn mãi
	    Những sự nghiệp làm cho Chúa hân hoan
	    Kìa đất run lên vừa khi ra mắt Chúa,
	    Núi bung lửa khi Ngài khẽ đụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "14."
	    Trọn cuộc sống nguyện luôn ca mừng Chúa
	    Tấu cung đàn ngợi khen mãi khôn ngơi
	    Nguyện tiếng con đây làm vui say thánh ý,
	    Mối hoan hỷ con là chính Ngài.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #2
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    %\override Lyrics.LyricSpace.minimum-distance = #0.3
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
