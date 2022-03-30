% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Thần Khí Mới" }
  composer = "Ed. 36,24-28"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  g4. d16 f |
  e8 c e g |
  a4. f16 f |
  f8 f a b |
  c4 r8 d |
  e4. e16 b |
  c8 d c a |
  g4. e16 d |
  f8 g e d |
  c4 \bar "||" \break
  
  g'8 a |
  g4. e8 |
  f8. d16 g8 e16 (d) |
  c4. c16 e |
  d8 c d e |
  f4 r8 d16 f |
  e8 d e f |
  g4 r8 a |
  f4. f16 f |
  f8 g e d |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4
  e8 f |
  e4. c8 |
  d8. c16 b8 ^(b) |
  c4. c16 c |
  g8 a b c |
  d4 r8 b16 d |
  c8 b c d |
  e4 r8 c |
  d4. d16 d |
  d8 c c b |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ta sẽ gọi các ngươi từ muôn dân nước,
      triệu tập về từ bao viễn xứ,
      Ta sẽ đoái tình đem các ngươi trở về,
      trở về quê cũ cha ông mình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ta sẽ tặng các ngươi một quả tim mới,
	    Và đặt vào lòng Thần Khí mới,
	    Ta sẽ lấy quả tim biết luôn yêu
	    và thay quả tim các ngươi chai lỳ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ta lấy Thần Khí ta đặt vào tâm trí
	    Và chỉ dạy bền tâm đưa bước theo đúng huấn lệnh
	    Ta đã cho ban truyền,
	    thi hành nghị quyết Ta vẹn toàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ta sẽ để các ngươi lập cư trên đất
	    đà được dành tặng cho tiền bối,
	    Muôn kiếp sẽ là dân nước Ta tuyển chọn,
	    Ta là Chúa các ngươi tôn thờ.
    }
  >>
  \set stanza = "ĐK:"
  Trên các ngươi Ta sẽ rẩy nước trong ngần
  để các ngươi được nên tinh trắng,
  rửa các ngươi sạch mọi bợn nhơ,
  Quét sạch mọi thần tượng các ngươi tôn thờ.
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
  page-count = 1
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
