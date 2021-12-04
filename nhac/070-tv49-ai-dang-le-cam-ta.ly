% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Ai Dâng Lễ Cảm Tạ"
  composer = "Tv. 49"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. c8 f f |
  d8. c16 a8 bf |
  \slashedGrace { d16 ( } c2) ~ |
  c8 c c g' |
  g8. bf16 a8 g |
  f2 ~ |
  f4 r8 f |
  f8. f16 bf8 c |
  d2 ~ |
  d8 c16 (f) d8 c |
  a bf4 c8 |
  g (bf a) g |
  f2 \bar "||"
  
  f8. f16 g8 d |
  c4. a'8 |
  f4 bf8 a |
  g2 |
  c8. c16 c8 d |
  a4. a8 |
  a8. bf16 g8 c |
  f,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4. |
  R2*12
  
  f8. f16 g8 d |
  c4. f8 |
  d4 g8 f |
  e2 |
  a8. a16 a8 g |
  f4. f8 |
  f8. g16 e8 e |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thượng Đế chí tôn nay Ngài lên tiếng
      Triệu tập chư dân khắp cõi địa cầu.
      Người đòi trời cao đất thấp phải ra phiên tòa
      nghe Chúa xử dân Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Này hãy lắng nghe bao lời Ta phán
	    Vì thực Ta đây Chúa ngươi tôn thờ.
	    Cần gì đòi ngươi tế lễ
	    bởi Ta đâu thèm chi máu thịt chiên bò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy kính tiến lên bao lời cảm mến
	    Trọn niềm tri ân Chúa muôn cao trọng
	    Vào hôi gặp cơn nguy khốn,
	    Hãy kêu xin là Ta tế độ an toàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Miệng nhắc nhớ luôn bao điều giao ước
	    Mà lòng khinh chê giới răn Ta truyền,
	    Vừa gặp phường gian trộm cướp
	    Ấy ngươi vội vàng theo chúng để chia phần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Còn tấc lưỡi luôn thêu dệt xảo trá
	    Ngồi là lê la diễu bêu lân bàng,
	    Từng tội rầy Ta khiển trách
	    Hỡi quân gian tà mau gắng hiểu cho tường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Này hỡi những ai quên lời Thượng Đế
	    Lẳng lặng nghe đây, gắng suy cho tường,
	    Kẻo rồi bị Ta xé xác,
	    Chẳng trông mong còn ai cứu nổi cho cùng.
    }
  >>
  \set stanza = "ĐK:"
  Ai dâng lễ cảm tạ sẽ làm hiển danh Ta,
  Ai đi trong chính lộ Ta cho thấy ơn cứu độ.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 5\mm
  bottom-margin = 5\mm
  left-margin = 8\mm
  right-margin = 8\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %system-system-spacing = #'((basic-distance . 0.1) (padding . 1))
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
