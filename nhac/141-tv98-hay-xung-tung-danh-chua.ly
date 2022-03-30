% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Xưng Tụng Danh Chúa" }
  composer = "Tv. 98"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8. f16 g8 f |
  e4. g8 |
  g4 d16 (f) d8 |
  c4 r8 c16 c |
  f8 g16 (f) e8 f16 (g) |
  a4. bf8 |
  bf4 d,8 d16 (f) |
  g2 |
  bf8. bf16 bf8 d |
  g, bf4 c8 |
  c2 |
  a8. g16 a8 c |
  \slashedGrace { d,16 ( } c4.) e8 |
  f4 r8 \bar "||" \break
  
  a8 |
  a4 bf8 (a) |
  g f4 g8 |
  d4. d8 |
  c2 |
  f8 e16 (f) g8 f16 (g) |
  a4 bf8 d |
  g,4. e8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*13
  r4.
  f8 |
  f4 g8 (f) |
  c d4 c8 |
  b!4. b8 |
  c2 |
  a8 [a] bf [c] |
  f4 g8 f |
  bf,4. c8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa là Vua hiển trị, chư dân phải rụng rời,
      Ngài ngự trên các thần hộ giá,
      Trái đất phải chuyển rung.
      Ngài thật là vĩ đại ở Si -- on
      Cao vượt trên tất cả mọi dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa là Vua uy hùng, luôn yêu lẽ công bình,
	    Hằng thực thi những điều trực chính,
	    Hãy đến phục lạy đi.
	    Mau tuyên dương Chúa toàn năng chí thánh,
	    Chung lời ta khấn cầu Tôn Danh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa dủ thương nhậm lời, luôn luôn xử khoan hồng,
	    Mà nào ngơi đoán phạt tội lỗi.
	    Hát kính và phục suy,
	    Bao hân hoan hướng về nơi núi thánh,
	    Ca mừng danh Chúa Trời của ta.
    }
  >>
  \set stanza = "ĐK:"
  Chư dân hãy xưng tụng danh Ngài vĩ đại,
  Danh khả tôn khả ái,
  Danh thánh thiện dường bao.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
