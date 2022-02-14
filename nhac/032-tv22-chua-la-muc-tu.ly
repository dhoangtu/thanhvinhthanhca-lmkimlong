% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Mục Tử" }
  composer = "Tv. 22"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  r8 e c c |
  f4 g8 a |
  g4 g8 g |
  e (d4) g8 |
  c,2 |
  r8 f e f |
  g4 c8 a |
  a ^(g4) e8 |
  f2 |
  r8 f a f |
  d4 d8 d |
  g4. b,8 |
  c2 \bar "||" \break
  
  c8. ef16 f8 g ~ |
  g af g4 |
  f8. g16 d8 ef |
  c4 r8 c |
  c'8. c16 a!?8 g |
  e f4 g8 |
  d8. f16 e8 d |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 e c c |
  f4 g8 a |
  g4 e8 d |
  c (b4) b8 |
  c2 |
  r8 d c d |
  e4 a8 f |
  f _(e4) c8 |
  d2 |
  r8 d d c |
  b4 g8 g |
  e'4 (f8) d |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa là mục tử chăn dắt tôi,
  tôi không còn thiếu gì.
  Trên đồng cỏ xanh,
  Chúa cho tôi nghỉ ngơi,
  Bên suối trong lành,
  Ngài bồi dưỡng hồn tôi,
  <<
    {
      \set stanza = "1."
      Dù qua thung lũng tối sâu,
      tôi chẳng sợ khốn cùng,
      vì có Chúa luôn ở cùng tôi,
      bảo vệ khiến tôi an lòng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tiệc hân hoan Chúa thiết tôi
	    ngay trước mặt quân thù,
	    Ngài xức thuốc thơm trên đầu tôi,
	    chén rượu cứ luôn châm đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tình yêu thương với phúc ân luôn ấp ủ suốt đời,
	    Vào chốn thánh cung tôi ẩn thân
	    tháng ngày sống vui êm đềm.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #2.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
