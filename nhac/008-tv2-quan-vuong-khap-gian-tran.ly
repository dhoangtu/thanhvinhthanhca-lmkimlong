% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Quân Vương Khắp Gian Trần" }
  composer = "Tv. 2"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c4 |
  g'4. g8 |
  g8. a16 f8 e |
  d4 g8 g |
  c,4 r8 c |
  f8. f16 d8 a' |
  a4 a16 (b) a8 |
  g4 g8 g |
  c4. c8 |
  c b c (d) |
  e4 e16 (f) e8 |
  a,4. a16 (b) |
  g4 d'8 d |
  \once \stemDown c4 \bar "||"
  
  g4 |
  g8. g16 e (d) g8 |
  c,4 b8 c |
  d d c (d) |
  e2 |
  f8. d16 d8 g |
  g2 |
  b8 b16 (a) g8 (a) |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c4 |
  g'4. g8 |
  g8. a16 f8 e |
  d4 g8 g |
  c,4 r8 c |
  f8. f16 d8 a' |
  a4 a16 (b) a8 |
  g4 g8 f |
  e4. e8 |
  a g a (b) |
  c4 c8 [a] |
  f4. f8 |
  e4 f8 g |
  <e c>4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Giờ đây quân vương khắp cõi gian trần
  hãy biết điều,
  Thủ lãnh khắp cùng thế giới hãy tỉnh ngộ,
  và thực tâm suy tôn thờ phượng Chúa,
  hãy run sợ phủ phục trước Thánh Nhan.
  <<
    {
      \set stanza = "1."
      Chúa phán: Chính Ta
      sẽ đặt Vị quân vương Ta chọn sẵn,
      Lên trị vì Si -- on,
      núi thánh của Ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Các nước cớ sao náo động
	    và vạn dân sao bày kế chống lại Vị Tân Vương,
	    tính kế viển vông.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cứ đến khấn xin sẽ được vạn dân Ta bạn tặng đó,
	    Đây sản nghiệp Ta trao:
	    Khắp cõi trần gian.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
