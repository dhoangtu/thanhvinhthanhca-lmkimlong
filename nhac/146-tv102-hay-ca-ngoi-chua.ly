% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Hãy Ca Ngợi Chúa"
  composer = "Tv. 102"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. e8 d c |
  f8. f16 e8 d |
  g4 r8 g |
  c c r a |
  d d4 c8 |
  b2 |
  r8 e, d c |
  f8. f16 e8 d |
  g4 r8 g |
  c c r a |
  d d4 b8 |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  c,8 |
  g'8. g16 g8 g |
  e a4 c8 |
  b8. g16 a8 f |
  e2 ~ |
  e4 r8 e' |
  d8. b16 b8 c |
  d a4 a8 |
  g8. e'16 e8 d |
  b c ~ c4 ~ |
  c8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 d c |
  f8. f16 e8 d |
  g4 r8 f |
  e e r g |
  fs fs4 fs8 |
  g2 |
  r8 e d c |
  f8. f16 e8 d |
  g4 r8 f |
  e e r c |
  f f4 g8 |
  e2 ~ |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy ca ngợi Chúa, hỡi linh hồn tôi,
  Toàn thân tôi, nào hát kính Danh Ngài.
  Hãy ca ngợi Chúa, hỡi linh hồn tôi,
  Đừng quên đi lộc phúc Chúa đà ban.
  <<
    {
      \set stanza = "1."
      Ngài tha cho ngươi muôn tội lỗi,
      chữa ngươi khỏi các tật nguyền,
      Cứu ngươi khỏi vùi sây đáy huyệt,
      ân lộc nghĩa thiết bao bọc ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngài ban cho ngươi luôn hạnh phúc,
	    tuổi xuân như cánh chim bằng.
	    Chúa luôn hằng xử phân chính trực,
	    ai bị ức hiếp cho giải oan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài cho Mô -- sê hay đường lối,
	    Ít -- ra -- en thấy công trình,
	    chúa luôn giầu tình sâu nghĩa nặng,
	    không hề mãi mãi nuôi hờn căm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ngài không theo như ta lầm lỗi,
	    giống soi trả báo tội tình.
	    Chúa thương kẻ nào tôn kính Ngài,
	    ân tình bát ngát cung trời cao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ngài quăng ta xa muôn tội lỗi,
	    giống phương đông các phương đoài.
	    Chúa thương kẻ thành tín
	    khác gì cha hiền vẫn mến thương đoàn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Nặn nên thân ta do bùn đất,
	    Chúa sao không nhớ không tường.
	    Tháng năm phận phù sinh
	    ví tựa hoa đồng sáng thắm nhưng chiều phai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nào ai trung kiên tôn thờ Chúa,
	    phúc ân muôn kiếp muôn đời.
	    Giữ y mệnh lệnh, giao ước Ngài,
	    miêu duệ Chúa cũng minh xử cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Đặt ngai uy linh trên trời thẳm,
	    Chúa trông coi hết mọi loài.
	    Hỡi muôn bậc hùng anh lẫm liệt,
	    thiên thần lớp lớp ca tụng đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Cùng muôn cơ binh ca tụng Chúa,
	    chúng sinh do Chúa tạo thành.
	    Khắp nơi trực thuộc vương quốc Ngài.
	    Chung lời hát kính đi, hồn ơi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 5\mm
  bottom-margin = 5\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
